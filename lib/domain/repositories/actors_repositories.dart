import 'package:flutter_cinemapedia/domain/entities/actors.dart';

abstract class ActorRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
