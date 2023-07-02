import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import 'movies_slideshow_provider.dart';

final initialLoadingProvider = Provider((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(moviesSlideShow).isEmpty;
  final step3 = ref.watch(popularMoviesProvider).isEmpty;
  final step4 = ref.watch(topReaderMoviesProvider).isEmpty;
  final step5 = ref.watch(upComingMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4 || step5) return true;
  return false;
});
