
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key, required this.titulo,
  }) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Column(
        children:  [
          const Image(
            image: AssetImage('assets/tag-logo.png'),
            height: 170,
          ),
          const SizedBox( height: 5 ),
          Text(titulo, style: const TextStyle( fontSize: 30, color: Colors.black54 ),)
        ],
      ),
    );
  }

}