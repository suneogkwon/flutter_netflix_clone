import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/presentation/pages/home/home_page.dart';
import 'package:flutter_netflix_clone/presentation/pages/like_movie/like_movie_page.dart';
import 'package:flutter_netflix_clone/presentation/pages/more/more_page.dart';
import 'package:flutter_netflix_clone/presentation/pages/movie_search/movie_search_page.dart';
import 'package:flutter_netflix_clone/presentation/widgets/main_bottom_navigation_bar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            MovieSearchPage(),
            LikeMoviePage(),
            MorePage(),
          ],
        ),
        bottomNavigationBar: MainBottomNavigationBar(),
      ),
    );
  }
}
