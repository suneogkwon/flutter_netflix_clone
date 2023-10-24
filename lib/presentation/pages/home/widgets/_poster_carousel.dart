part of '../home_page.dart';

class _PosterCarousel extends StatefulWidget {
  const _PosterCarousel({
    super.key,
    required this.movieList,
  });

  final List<MovieModel> movieList;

  @override
  State<_PosterCarousel> createState() => _PosterCarouselState();
}

class _PosterCarouselState extends State<_PosterCarousel> {
  late int currentCarouselIndex;
  MovieModel get currentMovie => widget.movieList[currentCarouselIndex];

  List<Widget> _buildPosterList() {
    return widget.movieList
        .map(
          (e) => Image.network(
            e.poster,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        )
        .toList();
  }

  Widget _buildMovieGenre() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
      child: Text(
        currentMovie.genre,
        style: const TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildLikeIcon() {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            final toggledMovie = currentMovie.copyWith(
              like: !currentMovie.like,
            );

            currentMovie.reference
                ?.update(
              toggledMovie.toJson(),
            )
                .then((value) {
              // setState(() {
              //   currentMovie = toggledMovie;
              // });
            });
          },
          icon: Icon(
            currentMovie.like ? Icons.check : Icons.add,
          ),
        ),
        const Text(
          '내가 찜한 컨텐츠',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const BeveledRectangleBorder(),
        ),
        onPressed: () {},
        child: const Row(
          children: [
            Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              '재생',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MovieDetailPage(
                    movie: currentMovie,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.info,
            ),
          ),
          const Text(
            '정보',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCarouselIndicator() {
    return widget.movieList
        .mapIndexed(
          (index, e) => Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFFFFF).withOpacity(
                currentCarouselIndex == index ? 0.9 : 0.4,
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    currentCarouselIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    print(currentMovie);
    return Column(
      children: [
        CarouselSlider(
          items: _buildPosterList(),
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height * 0.6,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentCarouselIndex = index;
              });
            },
          ),
        ),
        _buildMovieGenre(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLikeIcon(),
            _buildPlayButton(),
            _buildMoreButton(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildCarouselIndicator(),
        )
      ],
    );
  }
}
