import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cinemapedia/presetation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie_entitie.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActor(widget.movieId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movie.posterPath,
                    width: size.width * 0.25,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Cavis Cream',
                  style: textStyle.bodyMedium,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            // descripcion
            SizedBox(
              width: (size.width - 30) * 0.7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    Text(
                      movie.overview,
                      style: textStyle.bodyMedium,
                    )
                  ]),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(children: [
            ...movie.genreIds.map((e) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(e),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ))
          ]),
        ),
        // mostrar actores
        _ActorsView(movieId: movie.id.toString()),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}

class _ActorsView extends ConsumerWidget {
  final String movieId;
  const _ActorsView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final actorsByMovie = ref.watch(actorByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 3,
      );
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actors.length,
            itemBuilder: (context, index) {
              final actor = actors[index];
              return Container(
                padding: const EdgeInsets.all(8.0),
                width: size.width * 0.3,
                child: Column(children: [
                  // actor photo
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                      actor.profilePath,
                      height: size.height * 0.2,
                      width: size.width * 0.6,
                      loadingBuilder: (context, child, loadingProgress) {
                        // PARA HACER ALGO MIENTRAS CARGA
                        if (loadingProgress != null)
                          return const CircularProgressIndicator(
                            strokeWidth: 3,
                          );
                        return FadeInRight(child: child);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    actor.name,
                    maxLines: 2,
                  ),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  )
                  // nombre
                ]),
              );
            }));
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.8,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          // un stack es para poner un widget sobre otro, en este caso para poner un gradiente y ver el titulo
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  // PARA HACER ALGO MIENTRAS CARGA
                  if (loadingProgress != null)
                    return const CircularProgressIndicator(
                      strokeWidth: 3,
                    );
                  return FadeInDown(child: child);
                },
              ),
            ),
            const _SizeBoxDecorationGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
            ),
            const _SizeBoxDecorationGradient(
              colors: [Colors.black, Colors.transparent],
              stops: [0.0, 0.3],
              begin: Alignment.topLeft,
              end: Alignment.center,
            )
          ],
        ),
      ),
    );
  }
}

class _SizeBoxDecorationGradient extends StatelessWidget {
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final List<double> stops;
  const _SizeBoxDecorationGradient(
      {super.key,
      required this.begin,
      required this.end,
      required this.colors,
      required this.stops});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
