import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(children: [
            Icon(
              Icons.movie_creation,
              color: colors.primary,
            ),
            SizedBox(width: 1),
            Text('CineApp', style: titleStyle),
            const Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.search_sharp)),
          ]),
        ),
      ),
    );
  }
}
