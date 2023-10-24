import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/models/movie_model.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({
    super.key,
    required this.movie,
  });

  final MovieModel movie;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieModel movie;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }

  Widget _buildActionButtons() {
    return Container(
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: InkWell(
              onTap: () {
                final toggledMovie = movie.copyWith(
                  like: !movie.like,
                );

                movie.reference
                    ?.update(
                  toggledMovie.toJson(),
                )
                    .then((value) {
                  setState(() {
                    movie = toggledMovie;
                  });
                });
              },
              child: Column(
                children: [
                  Icon(
                    movie.like ? Icons.check : Icons.add,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              children: [
                Icon(Icons.thumb_up),
                SizedBox(height: 10),
                Text(
                  '평가',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              children: [
                Icon(Icons.send),
                SizedBox(height: 10),
                Text(
                  '공유',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieDetail() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.movie.poster),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      padding: const EdgeInsets.fromLTRB(0, 45, 0, 10),
                      child: Image.network(widget.movie.poster),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        '99% 일치 2019 15+ 시즌 1개',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Text(
                        widget.movie.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          shape: const BeveledRectangleBorder(),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow),
                            Text('재생'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        widget.movie.toString(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        '출연: 현빈, 손예진, 서지혜\n제작사: 이정효, 박지은',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('리빌드! : ${widget.movie}');
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _buildMovieDetail(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }
}
