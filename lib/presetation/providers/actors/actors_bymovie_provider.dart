import 'package:flutter_cinemapedia/presetation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/actors.dart';

final actorByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorRepository = ref.watch(actorRepositoryProvider);
  return ActorByMovieNotifier(getActor: actorRepository.getActorsByMovie);
});

typedef GetActors = Future<List<Actor>> Function(String movieId);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActors getActor;
  ActorByMovieNotifier({required this.getActor}) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await getActor(movieId);
    state = {...state, movieId: actors};
  }
}
