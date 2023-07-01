import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movie_entitie.dart';

class MoviesSlideShow extends StatelessWidget {
  const MoviesSlideShow({super.key, required this.movies});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: size * 0.5, // alto de la tarjeta
      width: double.infinity, // ancho de la tarjeta
      child: Swiper(
        // widget tarjetas
        viewportFraction:
            0.8, // para ver un porcentaje de las tarjetas de cada lado
        autoplay: true,
        autoplayDelay: 3000, // delay en el cambio
        duration:
            2000, // duracion de la transccion entre cada una de la tarjetas
        pagination: SwiperPagination(
            builder: RectSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
        itemCount: movies.length, // cuantas tarjetas
        itemBuilder: (context, index) {
          // constructor
          final movie = movies[index];
          return _SlideShow(movie: movie); // widget para mostrar
        },
      ),
    );
  }
}

class _SlideShow extends StatelessWidget {
  final Movie movie;
  const _SlideShow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        // para crea un box de sombras
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: DecoratedBox(
        // para poner una caja sobre otra o decorar una caja
        decoration: decoration,
        child: ClipRRect(
          //oara poner la imagen
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingPogress) {
              if (loadingPogress != null) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 100,
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
