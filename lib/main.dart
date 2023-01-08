import 'package:chat/help/messages.dart';
import 'package:chat/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


void main() => runApp(const AppState());


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MessagesProvider(),),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'chat',
      routes: AppRoutes.routes,
    );
  }
}