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

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    // TODO: implement getPopular
    return dataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopReader({int page = 1}) {
    // TODO: implement getPopular
    return dataSource.getTopReader(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    // TODO: implement getPopular
    return dataSource.getUpComing(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    // TODO: implement getMovieById
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    // TODO: implement getUpComing
    return dataSource.getUpComing(page: page);
  }
}
