
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MessagesProvider extends ChangeNotifier  {

  List<ChatMessage> listMessages = [];

  addMesage( ChatMessage message ){
    listMessages.insert(0, message);
    message.animationController.forward();
    notifyListeners();
  }
  
}