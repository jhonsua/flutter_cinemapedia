import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/enviroment.dart';
import 'package:flutter_cinemapedia/domain/data/movies_data.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entitie.dart';
import 'package:flutter_cinemapedia/infrastructure/mappers/movie_mappers.dart';
import 'package:flutter_cinemapedia/infrastructure/models/MovieDb/modelsDb_Response.dart';
import 'package:flutter_cinemapedia/infrastructure/models/MovieDb/movieDetailsDb.dart';

class MovieDBDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBresponse = MovieDbResponde.fromJson(json);

    final List<Movie> movies = (movieDBresponse.results
        .where((e) => e.posterPath != 'no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))).toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopReader({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie id no found');
    final movieDB = MovieDetailsDb.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDB);
    return movie;
  }
}
