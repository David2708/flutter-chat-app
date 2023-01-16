import 'package:chat/models/Usuario.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/user.dart';
import '../widgets/widgets.dart';

class UsersScreen extends StatefulWidget {

  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

   final RefreshController _refreshController = RefreshController(initialRefresh: false);

    final users = [
    User(uid: '1', nombre: 'María', email: 'test1@test.com', online: true ),
    User(uid: '2', nombre: 'Melissa', email: 'test2@test.com', online: false ),
    User(uid: '3', nombre: 'Fernando', email: 'test3@test.com', online: true ),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);    
    final Usuario usuario = authService.usuario!;

    return Scaffold(
      appBar: myappbar(usuario),
      body: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue.shade400,
        ),
        onRefresh: _cargarUsuarios,
        child: ListsUsers(users: users),
      ),
    );
  }

  AppBar myappbar(Usuario usuario) {
    return AppBar(
      centerTitle: true,
      title: Text( usuario.nombre! , style: TextStyle(color: Colors.black87)),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            //todo: desconectar del socket server
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
          icon: const Icon( Icons.logout_outlined, color: Colors.black87,)
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Icon(Icons.check_circle, color: Colors.blue.shade400,),
          // child: Icon(Icons.offline_bolt, color: Colors.red.shade400,),
        )
      ],
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _refreshController.refreshCompleted();
  }

}
