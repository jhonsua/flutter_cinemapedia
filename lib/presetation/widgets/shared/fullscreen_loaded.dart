import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando restaurantes',
      'Llamando Rapidines',
      'Buscando las mejores ofertas para ti',
      'Rastreando GPS'
    ];

    return Stream.periodic(const Duration(seconds: 2), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Espere'),
        const SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(
          strokeWidth: 5,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando ...');
              return Text(snapshot.data!);
            })
      ]),
    );
  }
}
