import '../entities/movie_entitie.dart';

abstract class MoiveDataRepositorie {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
}
