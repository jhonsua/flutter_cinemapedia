import 'package:flutter_cinemapedia/domain/entities/movie_entitie.dart';
import 'package:flutter_cinemapedia/presetation/providers/movies/moviesrepository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentpage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier(
    this.fetchMoreMovies,
  ) : super([]);

  Future<void> loadNextPage() async {
    currentpage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentpage);
    state = [...state, ...movies];
  }
}
