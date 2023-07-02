import 'package:dio/dio.dart';
import 'package:flutter_cinemapedia/domain/data/actos_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/actors.dart';
import 'package:flutter_cinemapedia/infrastructure/mappers/actors_mappers.dart';
import 'package:flutter_cinemapedia/infrastructure/models/ActorsDB/actorsDb.dart';

import '../../config/constants/enviroment.dart';

class ActorMovieDbDataSource extends ActorDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
