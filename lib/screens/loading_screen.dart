
import 'package:chat/screens/screns.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Espere...'),
          );
          
        },
      ),
    );
  }

  Future checkLoginState ( BuildContext context ) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if( autenticado ){
      // todo: conectar sl soceket server 
      // Navigator.pushReplacementNamed(context, 'users');
      
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _ , __ , ___) => const UsersScreen(),
          transitionDuration: const Duration(milliseconds: 0)
        )
      );
    }else{
       // ignore: use_build_context_synchronously
       Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _ , __ , ___) => const LoginScreen(),
          transitionDuration: const Duration(milliseconds: 0)
        )
      );

    }

  }

}