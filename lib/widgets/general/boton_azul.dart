import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  const BotonAzul({Key? key, required this.text, required this.onPressed, this.color, }) : super(key: key);

  final String text;
  final Function() onPressed;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        elevation: 2,
        highlightElevation: 5,
        color: color ?? Colors.blue,
        shape: const StadiumBorder(),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
              child: Text(text,
                  style: const TextStyle(color: Colors.white, fontSize: 17))),
        ));
  }
}
