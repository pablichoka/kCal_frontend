import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/models/user.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;

import '../widgets/app_bar.dart';
import 'package:kcal_control_frontend/pages/index.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String title = "kCal Control";
  late final BuildContext? _navigationContext;
  var newUser = User(
      username: '',
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      mobile: '',
      role: 'USER');

  Future<bool> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        _navigationContext = context;
        return await api.ApiService.instance.signup(newUser);
      } catch (e) {
        print('Error: $e');
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: title,
        actions: const [],
        returnable: true,
      ),
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
                  newUser.username = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  newUser.email = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'First name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (value) {
                  newUser.firstName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  newUser.lastName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(
                //     RegExp(r'^[0-9+A-Za-z\s]+$'),
                //   ),
                // ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  newUser.password = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mobile'),
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(
                //       RegExp(r'^(?=.*[0-9]){15,}$'),
                //   )],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your mobile with the prefix of you country';
                  }
                  return null;
                },
                onSaved: (value) {
                  newUser.mobile = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (await _signup()) {
                    Navigator.pushReplacement(_navigationContext!,
                        MaterialPageRoute(builder: (ctx) => const WebIndex()));
                  } else {
                    ScaffoldMessenger.of(_navigationContext!).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Something went wrong during registration.'),
                      ),
                    );
                  }
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
