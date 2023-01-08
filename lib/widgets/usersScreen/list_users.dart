import 'package:flutter/material.dart';

import '../../models/user.dart';



class ListsUsers extends StatelessWidget {
  const ListsUsers({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics         : const BouncingScrollPhysics(),
        itemBuilder     : (_, index) => _User(user: users[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount       : users.length
      );
  }
}



class _User extends StatelessWidget {
  const _User({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text( user.nombre.substring(0,2) ),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: _boxdecoration(),
      ),

    );
  }

  BoxDecoration _boxdecoration() {
    return BoxDecoration(
        color: user.online ? Colors.green.shade400 : Colors.red.shade400,
        borderRadius: BorderRadius.circular(50)
      );
  }
}
