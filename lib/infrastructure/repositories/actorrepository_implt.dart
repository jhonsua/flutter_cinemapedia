import 'package:flutter_cinemapedia/domain/data/actos_datasource.dart';
import 'package:flutter_cinemapedia/domain/entities/actors.dart';
import 'package:flutter_cinemapedia/domain/repositories/actors_repositories.dart';

class ActorRepositoryImplt extends ActorRepository {
  final ActorDataSource actorDataSource;

  ActorRepositoryImplt(this.actorDataSource);
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return actorDataSource.getActorsByMovie(movieId);
  }
}
