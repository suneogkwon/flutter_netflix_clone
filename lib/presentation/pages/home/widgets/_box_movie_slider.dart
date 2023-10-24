part of '../home_page.dart';

class _BoxMovieSlider extends StatelessWidget {
  const _BoxMovieSlider({
    super.key,
    required this.movieList,
  });

  final List<MovieModel> movieList;

  @override
  Widget build(BuildContext context) {
    final List<Widget> boxMovieListWidget = movieList.mapIndexed(
      (index, element) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => MovieDetailPage(
                  movie: element,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.network(element.poster),
            ),
          ),
        );
      },
    ).toList();

    return Padding(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('지금 뜨는 콘텐츠'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: boxMovieListWidget,
            ),
          ),
        ],
      ),
    );
  }
}
