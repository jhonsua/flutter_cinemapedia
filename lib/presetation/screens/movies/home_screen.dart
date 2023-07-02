import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/presetation/providers/providers.dart';
import 'package:flutter_cinemapedia/presetation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/movies/movies/movies_slideshow_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topReaderMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final SlideShowMovies = ref.watch(moviesSlideShow);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topReaderMovies = ref.watch(topReaderMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(),
        title: CustomAppBar(),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideShow(movies: SlideShowMovies),
            MoviesHorizontalListView(
              movies: nowPlayingMovies,
              title: 'Mejores',
              subtitle: '30 de junio',
              loadNexpage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListView(
              movies: popularMovies,
              title: 'Populares',
              subtitle: 'Ver mas',
              loadNexpage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListView(
              movies: topReaderMovies,
              title: 'TOP',
              subtitle: 'Ver mas',
              loadNexpage: () =>
                  ref.read(topReaderMoviesProvider.notifier).loadNextPage(),
            ),
            MoviesHorizontalListView(
              movies: upComingMovies,
              title: 'Mejorando',
              subtitle: 'Ver mas',
              loadNexpage: () =>
                  ref.read(upComingMoviesProvider.notifier).loadNextPage(),
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
