import 'package:flutter_cinemapedia/infrastructure/dataSour/movideDB_datasource.dart';
import 'package:flutter_cinemapedia/infrastructure/repositories/movierepository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDBDataSource());
});
