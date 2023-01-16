import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid ? 'http://192.168.122.148:3000/api' : 'http://192.168.48.20:3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.122.148:3000' : 'http://192.168.48.20:3000';
 
}