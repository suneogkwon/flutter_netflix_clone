import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/models/movie_model.dart';
import 'package:flutter_netflix_clone/presentation/pages/movie_detail/movie_detail_page.dart';

class LikeMoviePage extends StatelessWidget {
  const LikeMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieStream = FirebaseFirestore.instance
        .collection('movies')
        .where(
          'like',
          isEqualTo: true,
        )
        .snapshots();

    return StreamBuilder(
      stream: movieStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          final movieDocSnapshot = snapshot.data!.docs;
          final movieList = movieDocSnapshot.map(
            (e) => MovieModel.fromFirestore(e),
          );

          return GridView.count(
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
          );
        }
      },
    );
  }
}
