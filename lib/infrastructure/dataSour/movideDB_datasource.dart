import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/config/constants/enviroment.dart';
import 'package:flutter_cinemapedia/domain/data/movies_data.dart';
import 'package:flutter_cinemapedia/domain/entities/movie_entitie.dart';
import 'package:flutter_cinemapedia/infrastructure/mappers/movie_mappers.dart';
import 'package:flutter_cinemapedia/infrastructure/models/MovieDb/modelsDb_Response.dart';

class MovieDBDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('movie/upcoming');
    final movieDBresponse = MovieDbResponde.fromJson(response.data);
    final List<Movie> movies = (movieDBresponse.results
        .where((e) => e.posterPath != 'no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))).toList();
    return movies;
  }
}
