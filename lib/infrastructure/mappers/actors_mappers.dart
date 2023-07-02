import 'package:flutter_cinemapedia/domain/entities/actors.dart';
import 'package:flutter_cinemapedia/infrastructure/models/ActorsDB/actorsDb.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      cast.id,
      cast.name,
      cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://cdn-icons-png.flaticon.com/512/3106/3106773.png',
      cast.character);
}
