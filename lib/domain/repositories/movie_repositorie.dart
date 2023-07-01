import '../entities/movie_entitie.dart';

abstract class MoiveDataRepositorie {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopReader({int page = 1});
  Future<List<Movie>> getUpComing({int page = 1});
  Future<Movie> getMovieById(String id);
}
