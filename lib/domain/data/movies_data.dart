import '../entities/movie_entitie.dart';

abstract class MoiveDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
