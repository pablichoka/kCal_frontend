import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:kcal_control_frontend/models/user.dart';
import 'package:kcal_control_frontend/pages/index.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;

import '../services/phone_validator.dart';
import '../themes/theme_data.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/desktop/background_index.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String title = "kCal Control";
  BuildContext? _navigationContext;
  var newUser = User(
    username: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    mobile: '',
    role: 'USER',
  );

  TextFormField buildTextField(
      {required String hintText,
      required IconData icon,
      bool obscureText = false,
      required String field}) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter required information.';
        }
        return null;
      },
      onSaved: (value) {
        switch (field) {
          case 'username':
            newUser.username = value!;
            break;
          case 'email':
            newUser.email = value!;
            break;
          case 'password':
            newUser.password = value!;
            break;
          case 'firstName':
            newUser.firstName = value!;
            break;
          case 'lastName':
            newUser.lastName = value!;
            break;
          case 'mobile':
            newUser.mobile = value!;
            break;
          default:
            break;
        }
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Future<bool> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        return await api.ApiService.instance.signup(newUser);
      } on FlutterErrorDetails catch (error) {
        throw ErrorWidget.builder(error);
      }
    }
    return false;
  }

  final TextEditingController _phoneController = TextEditingController();
  PhoneNumber _number = PhoneNumber(isoCode: 'ES');

  @override
  Widget build(BuildContext context) {
    _navigationContext = context;
    return Scaffold(
      appBar: DAppBar(
        title: title,
        actions: const [],
        returnable: true,
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Stack(children: <Widget>[
        const BackgroundScreen(),
        Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.height * 0.70,
                  child: Card(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Welcome to kCal Control',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.vertical,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        decoration: kContainerDecoration.copyWith(
                          color: Theme.of(context).cardColor,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              const Text(
                                'Welcome!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              const Text(
                                'Provide the required data to get your access',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              buildTextField(
                                hintText: 'Username',
                                icon: Icons.alternate_email,
                                field: 'username',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              buildTextField(
                                hintText: 'Email or username',
                                icon: Icons.email,
                                field: 'email',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              buildTextField(
                                  hintText: 'First name',
                                  icon: Icons.person,
                                  field: 'firstName'),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              buildTextField(
                                  hintText: 'Last name',
                                  icon: Icons.person,
                                  field: 'lastName'),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              buildTextField(
                                hintText: 'Password',
                                icon: Icons.lock,
                                obscureText: true,
                                field: 'password',
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),

                              InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  _number = number;
                                },
                                validator: (value) {
                                  if (validatePhoneNumber(
                                      phoneNumber: value!,
                                      isoCode: _number.isoCode!)) {
                                    return null;
                                  }else{
                                    return 'Enter a valid phone number';                                  }
                                },
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                  useBottomSheetSafeArea: true,
                                  showFlags: true,
                                  trailingSpace: true,
                                ),
                                ignoreBlank: true,
                                inputDecoration: InputDecoration(
                                  labelText: 'Phone number',
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                selectorTextStyle:
                                    TextStyle(color: Theme.of(context).textTheme.displaySmall?.color),
                                initialValue: _number,
                                textFieldController: _phoneController,
                                formatInput: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: false),
                                inputBorder: const OutlineInputBorder(),
                                onSaved: (PhoneNumber number) {
                                  newUser.mobile = number.phoneNumber!;
                                },
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    try {
                                      if (await _signup()) {
                                        Navigator.pushReplacement(
                                          _navigationContext!,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const WebIndex(),
                                            transitionDuration: const Duration(
                                                milliseconds: 200),
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
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(_navigationContext!)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Something went wrong during registration.',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text('Sign up'),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      style: Theme.of(context).textTheme.labelSmall,
                                        'Terms and Conditions'),
                                  ),
                                  const Text('|'),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        style: Theme.of(context).textTheme.labelSmall,
                                        'Privacy Policy'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ]),
      floatingActionButton: themeSelectorButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
