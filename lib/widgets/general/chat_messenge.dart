
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
   
  const ChatMessage({
    Key? key, 
    required this.texto, 
    required this.uid, 
    required this.animationController
    }) : super(key: key);

  final String texto;
  final String uid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == '123'
            ? _MyUsersMessage( texto: texto, uid: uid,)
            : _OtherUserMessage(texto: texto, uid: uid),
        ),
      ),
    );
  }
}








class _OtherUserMessage extends StatelessWidget {
  const _OtherUserMessage({
    Key? key, required this.texto, required this.uid,
  }) : super(key: key);

  final String texto;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 60),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text( texto, style: const TextStyle( color: Colors.black87 ), ),
      ),
    );
  }
}



class _MyUsersMessage extends StatelessWidget {
  const _MyUsersMessage({
    Key? key, required this.texto, required this.uid,
  }) : super(key: key);

  final String texto;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 60, right: 10),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text( texto, style: const TextStyle( color: Colors.white ), ),
      ),
    );
  }
}