

import 'dart:convert';
import 'package:chat/models/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'package:chat/models/login_response.dart';
import '../globals/environment.dart';


class AuthService with ChangeNotifier{

  Usuario? usuario;
  bool _autenticado = false;

  final _storage =  const FlutterSecureStorage();


  bool get autenticando => _autenticado;

  set autenticando( bool valor ) {
    _autenticado = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  // Getters del token de forma estática
  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }



  Future<bool> login( String email, String password ) async {

    autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final uri = Uri.parse('${ Environment.apiUrl }/login');
    final resp = await http.post( uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );


    autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = LoginResponse.fromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken( loginResponse.token! );

      return true;
    } else{

      return false;
    }

  }


  Future register(String nombre, String email, String password ) async {

    autenticando = true;

    final data = {
      "nombre": nombre,
      "email": email,
      "password": password
    };

    final uri = Uri.parse('${ Environment.apiUrl }/login/new');
    final resp = await http.post( uri, 
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = LoginResponse.fromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken( loginResponse.token! );

      return true;
    } else{
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn() async {

    final token = await _storage.read(key: 'token') ?? '';


    final uri = Uri.parse('${ Environment.apiUrl }/login/renew');
    final resp = await http.get( uri, 
      headers: {
        'Content-Type': 'application/json',
        'x-token' : token
      }
    );


    if ( resp.statusCode == 200 ) {
      final loginResponse = LoginResponse.fromJson( resp.body );
      usuario = loginResponse.usuario;

      await _guardarToken( loginResponse.token! );

      return true;
    } else{
      logout();
      return false;
    }

  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

}