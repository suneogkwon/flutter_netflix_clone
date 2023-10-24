import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/core/constants/assets.dart';
import 'package:flutter_netflix_clone/models/movie_model.dart';
import 'package:flutter_netflix_clone/presentation/pages/movie_detail/movie_detail_page.dart';

part 'widgets/_box_movie_slider.dart';
part 'widgets/_circle_movie_slider.dart';
part 'widgets/_poster_carousel.dart';
part 'widgets/_top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final movieStream =
      FirebaseFirestore.instance.collection('movies').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieStream,
      builder: (context, snapshot) {
        print('홈 리빌드');
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        } else {
          final movieList =
              snapshot.data!.docs.map(MovieModel.fromFirestore).toList();

          return ListView(
            children: [
              Stack(
                children: [
                  _PosterCarousel(
                    movieList: movieList,
                  ),
                  _TopBar(),
                ],
              ),
              _CircleMovieSlider(
                movieList: movieList,
              ),
              _BoxMovieSlider(
                movieList: movieList,
              ),
            ],
          );
        }
      },
    );
  }
}
