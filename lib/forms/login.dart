import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;

import '../pages/dashboard.dart';
import '../themes/theme_data.dart';
import '../widgets/common/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String title = "kCal Control";
  final FocusScopeNode _focusNode = FocusScopeNode();
  BuildContext? _navigationContext;
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _focusNode.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleKeyEvent);
    RawKeyboard.instance.removeListener(_handleRawKeyEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _navigationContext = context;
    return Scaffold(
      appBar: DAppBar(title: title, actions: const [], returnable: true),
      body: FocusScope(
        node: _focusNode,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Username'),
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
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
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
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _login();
                        },
                        child: const Text('Log in'),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 3,
                        child: InkWell(
                          //TODO: Implement password recovery
                          onTap: () {},
                          child: const Text(
                            'Did you forget your password?',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: themeSelectorButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<bool> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        bool loginSuccessful =
            await api.ApiService.instance.login(_username, _password);
        if (loginSuccessful) {
          Navigator.pushReplacement(
            _navigationContext!,
            MaterialPageRoute(builder: (ctx) => const Dashboard()),
          );
        } else {
          ScaffoldMessenger.of(_navigationContext!).showSnackBar(
            const SnackBar(
              content: Text('There was an error signing in.'),
            ),
          );
        }
        return loginSuccessful;
      } catch (e) {
        print('Error: $e');
      }
    }
    return false;
  }

  void _handleKeyEvent() {
    if (_focusNode.hasFocus) {
      RawKeyboard.instance.addListener(_handleRawKeyEvent);
    } else {
      RawKeyboard.instance.removeListener(_handleRawKeyEvent);
    }
  }

  void _handleRawKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      _login();
    }
  }
}
