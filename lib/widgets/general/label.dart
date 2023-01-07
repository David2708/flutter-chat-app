import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key, 
    required this.ruta, required this.titulo, required this.subtitulo,
  }) : super(key: key);

  final String ruta;
  final String titulo;
  final String subtitulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '¿ $titulo ?',
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, ruta),
            child: Text('$subtitulo!',
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)))
      ],
    );
  }
}
