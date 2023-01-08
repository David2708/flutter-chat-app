import 'dart:io';
import 'package:chat/help/messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
   
  const ChatScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final messagesProvider = Provider.of<MessagesProvider>(context);
    List<ChatMessage> messages = messagesProvider.listMessages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('David Jadid', style: TextStyle(color: Colors.black87, fontSize: 18),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [

            Flexible(
              child: ListView.builder(
                physics:const BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, index) => messages[index],
                reverse: true,
              ),
            ),

            const Divider(height: 2,),

            Container(
              color:  Colors.white,
              height: 50,
              child: _InputChat()
            )
          ],
        )
      ),
    );
  }
}

class _InputChat extends StatefulWidget {
  const _InputChat({
    Key? key,
  }) : super(key: key);

  @override
  State<_InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<_InputChat> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 8.0 ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: ( String texto ){
                  setState(() => texto.trim().isEmpty ? _isWriting = false : _isWriting = true );
                },
                decoration: const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric( horizontal: 4 ),
            child: !Platform.isIOS
                  ? CupertinoButton(
                    onPressed: _isWriting
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                    child: const Text('Enviar'), 
                    )
                  : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.send),
                        onPressed: _isWriting
                                 ? () => _handleSubmit(_textController.text.trim())
                                 : null, 
                        ),
                    )
                    )
          )
        ],
      ),
    );

  }

  
    _handleSubmit(String texto){
      if(texto.isEmpty) return;
      print(texto);
      _textController.clear();
      _focusNode.requestFocus();

      final messagesProvider = Provider.of<MessagesProvider>(context, listen: false);
      messagesProvider.addMesage( ChatMessage(
        texto: 
        texto, 
        uid: '123',
        animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
      ) );


      setState(() {_isWriting = false;});

        @override
        void dispose() {
          // TODO: off del socket

          for( ChatMessage message in messagesProvider.listMessages){
            message.animationController.dispose();
          }
          
          super.dispose();
        }


    }
    
}