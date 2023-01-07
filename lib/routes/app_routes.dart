
import 'package:flutter/material.dart';

import '../screens/screns.dart';


class AppRoutes {

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': ( _ ) => const LoginScreen(),
    'register': ( _ ) => const RegisterScreen(),
    'loading': ( _ ) => const LoadingScreen(),
    'users': ( _ ) => const UsersScreen(),
    'chat': ( _ ) => const ChatScreen(),
  };


}