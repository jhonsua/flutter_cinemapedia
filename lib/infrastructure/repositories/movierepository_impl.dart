import 'package:flutter_cinemapedia/domain/data/movies_data.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entitie.dart';
import 'package:flutter_cinemapedia/domain/repositories/movie_repositorie.dart';

class MovieRepositoryImpl extends MoiveDataRepositorie {
  final MoviesDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }
}
