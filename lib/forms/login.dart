import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kcal_control_frontend/forms/signup.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;

import '../pages/dashboard.dart';
import '../themes/theme_data.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/desktop/background_desktop.dart';

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
  late final String _username;
  late final String _password;
  late bool _rememberMe = false;

  TextFormField buildTextField(
      {required String hintText,
      required IconData icon,
      bool obscureText = false}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter required information.';
        }
        return null;
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
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
          return loginSuccessful;
        } else {
          ScaffoldMessenger.of(_navigationContext!).showMaterialBanner(
            const MaterialBanner(
              content: Text('There was an error signing in.'),
              actions: [],
            ),
          );
        }
      } catch (e) {
        throw ErrorWidget(e);
      }
    }
    return false;
  }

  void _handleKeyEvent() {
    if (_focusNode.hasFocus) {
      HardwareKeyboard.instance.addHandler(_handleRawKeyEvent);
    } else {
      HardwareKeyboard.instance.removeHandler(_handleRawKeyEvent);
    }
  }

  bool _handleRawKeyEvent(KeyEvent event) {
    if (event is KeyboardKey && event.logicalKey == LogicalKeyboardKey.enter) {
      _login();
      return true;
    }
    return false;
  }

  bool handleCheckbox(bool value) {
    return !value;
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _focusNode.addListener(_handleKeyEvent);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleKeyEvent);
    HardwareKeyboard.instance.removeHandler(_handleRawKeyEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _navigationContext = context;
    return Scaffold(
      appBar: DAppBar(title: title, actions: const [], returnable: true),
      body: Stack(
        children: [
          const BackgroundScreen(),
          FocusScope(
              node: _focusNode,
              child: Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              decoration: kContainerDecoration.copyWith(
                                  color: Theme.of(context).cardColor),
                              margin: const EdgeInsets.only(right: 20),
                              child: Center(
                                  child: Text('Welcome to kCal Control',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge)))),
                      Expanded(
                        child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            decoration: kContainerDecoration.copyWith(
                                color: Theme.of(context).cardColor),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Welcome Back!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Login to continue',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  buildTextField(
                                    hintText: 'Email or username',
                                    icon: Icons.person,
                                  ),
                                  const SizedBox(height: 20),
                                  buildTextField(
                                    hintText: 'Password',
                                    icon: Icons.lock,
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                            value: _rememberMe,
                                            onChanged: (value) {
                                              setState(() {
                                                _rememberMe = value!;
                                              });
                                            },
                                          ),
                                          const Text('Remember me'),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text('Forgot password?'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      _login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).splashColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text('Sign In'),
                                  ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              const SignUpPage(),
                                          transitionDuration:
                                              const Duration(milliseconds: 300),
                                          transitionsBuilder: (context,
                                              animation, animation2, child) {
                                            final offsetAnimation =
                                                Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(animation);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text('New User? Sign Up'),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextButton(
                                        onPressed: () {},
                                        child:
                                            const Text('Terms and Conditions'),
                                      ),
                                      const Text('|'),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text('Privacy Policy'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ])),
                      )
                    ])),
              )),
        ],
      ),
      floatingActionButton: themeSelectorButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
