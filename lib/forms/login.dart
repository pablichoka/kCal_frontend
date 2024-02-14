import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;
import 'package:kcal_control_frontend/pages/logout_test.dart';

import '../widgets/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String title = "kCal Control";
  BuildContext? _navigationContext;
  String _username = '';
  String _password = '';

  Future<bool> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        return await api.ApiService.instance.login(_username, _password);
      } catch (e) {
        print('Error: $e');
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _navigationContext = context;
    return Scaffold(
      appBar: DAppBar(title: title, actions: const [], returnable: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (await _login()) {
                    Navigator.pushReplacement(
                        _navigationContext!,
                        MaterialPageRoute(
                            builder: (ctx) => const LogoutTest()));
                  } else {
                    ScaffoldMessenger.of(_navigationContext!).showSnackBar(
                      const SnackBar(
                        content: Text('There was an error signing in.'),
                      ),
                    );
                  }
                },
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
