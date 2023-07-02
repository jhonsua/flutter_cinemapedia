import 'package:flutter_cinemapedia/infrastructure/dataSour/actor_moviedb_datasource.dart';
import 'package:flutter_cinemapedia/infrastructure/repositories/actorrepository_implt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImplt(ActorMovieDbDataSource());
});
