import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        // minimo tienen que ser dos
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Inicio'),

        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add), label: 'Pedidos'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: 'Favoritos'),
      ],
    );
  }
}
