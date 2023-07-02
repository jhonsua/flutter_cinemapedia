import '../entities/actors.dart';

abstract class ActorDataSource {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
