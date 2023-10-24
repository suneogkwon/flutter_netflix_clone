part of '../home_page.dart';

class _CircleMovieSlider extends StatelessWidget {
  const _CircleMovieSlider({
    super.key,
    required this.movieList,
  });

  final List<MovieModel> movieList;

  @override
  Widget build(BuildContext context) {
    final circleMovieListWidget = movieList.mapIndexed(
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
              child: CircleAvatar(
                backgroundImage: NetworkImage(element.poster),
                radius: 48,
              ),
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
          Text('미리보기'),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: circleMovieListWidget,
            ),
          ),
        ],
      ),
    );
  }
}
