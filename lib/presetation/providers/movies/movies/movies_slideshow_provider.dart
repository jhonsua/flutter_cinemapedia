import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie_entitie.dart';
import 'movies_providers.dart';

final moviesSlideShow = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0, 6);
});
