import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/models/movie_model.dart';
import 'package:flutter_netflix_clone/presentation/pages/movie_detail/movie_detail_page.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;
  String searchKeyword = '';

  Stream<QuerySnapshot<Map<String, dynamic>>> get movieStream =>
      FirebaseFirestore.instance
          .collection('movies')
          .where(
            'title',
            isGreaterThanOrEqualTo: searchKeyword,
            isLessThanOrEqualTo: '$searchKeyword~',
          )
          .snapshots();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          searchKeyword = searchController.text;
        });
      });
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          final movieList = snapshot.data!.docs.map(
            MovieModel.fromFirestore,
          );

          return Column(
            children: [
              SizedBox(height: 60),
              Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        focusNode: searchFocusNode,
                        controller: searchController,
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white12,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white60,
                            size: 20,
                          ),
                          suffixIcon: searchFocusNode.hasFocus
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchController.clear();
                                      searchKeyword = '';
                                    });
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 20,
                                  ),
                                )
                              : null,
                          hintText: '검색',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    if (searchFocusNode.hasFocus)
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              searchFocusNode.unfocus();
                              searchKeyword = '';
                            });
                          },
                          child: Text('취소'),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.5,
                  padding: EdgeInsets.all(3),
                  children: movieList.map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return MovieDetailPage(movie: e);
                              },
                            ),
                          );
                        },
                        child: Image.network(
                          e.poster,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
