import 'package:crud_flutter/models/user.dart';
import 'package:crud_flutter/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget{

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user){
    _formData['id'] = '${user.id}';
    _formData['name'] = '${user.name}';
    _formData['email'] = '${user.email}';
    _formData['avatarUrl'] = '${user.avatarUrl}';
    return;
  }

  @override
  Widget build(BuildContext context){
    final User user = ModalRoute.of(context)?.settings.arguments != null ? ModalRoute.of(context)?.settings.arguments as User 
    : const User(email: '', avatarUrl: '', name: '', id: '');

    _loadFormData(user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              final isValid = _form.currentState!.validate();

              if(isValid){
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'],
                  name: _formData['name'],
                  email: _formData['email'],
                  avatarUrl: _formData['avatarUrl'],
                ),
                );

                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save)
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15), 
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Informe um nome!';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = '${value}',

              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Informe um email!';
                  }

                  return null;
                },
                onSaved: (value) => _formData['email'] = '${value}',
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = '${value}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}