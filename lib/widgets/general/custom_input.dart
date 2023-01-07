import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  const CustomInput({
    Key? key, 
    required this.hintText, 
    required this.icon, 
    required this.textController, 
    this.keyboardType, 
    required this.isPassword
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 15),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: _boxdecoration(),
        child: TextField(
          controller: textController,
          autocorrect: false,
          keyboardType: keyboardType,
          obscureText: isPassword 
                    ? true
                    : false,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: hintText),
        ));
  }

  BoxDecoration _boxdecoration() {
    return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]);
  }
}
