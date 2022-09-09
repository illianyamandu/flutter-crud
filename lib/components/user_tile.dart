// ignore_for_file: prefer_const_constructors

import 'package:crud_flutter/provider/users.dart';
import 'package:crud_flutter/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class UserTile extends StatelessWidget {

  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context){
    final avatar = (user.avatarUrl == null || user.avatarUrl == '')
    ? CircleAvatar(child: Icon(Icons.person)) 
    : CircleAvatar(backgroundImage: NetworkImage("${user.avatarUrl}"));
    return ListTile(
      leading: avatar,
      title: Text('${user.name}'),
      subtitle: Text('${user.email}'),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
                arguments: user,
              );
              }, 
              color: Colors.blue,
              icon: Icon(Icons.edit)
            ),
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir usuário'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FloatingActionButton(
                        child: Text('Não'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      FloatingActionButton(
                        child: Text('Sim'),
                        onPressed: (){
                          Provider.of<Users>(context, listen:false).remove(user);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              color: Colors.red,
              icon: Icon(Icons.delete)
            ),
          ],
        ),
      ),
    );
  }
}