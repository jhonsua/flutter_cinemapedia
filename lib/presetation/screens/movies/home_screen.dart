import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/presetation/providers/movies/movies_providers.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPlayingMovies = ref.watch(moviesSlideShow);
    return Column(
      children: [
        const CustomAppBar(),
        MoviesSlideShow(movies: nowPlayingMovies)
      ],
    );
  }
}
