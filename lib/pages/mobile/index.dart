import 'package:flutter/material.dart';

import '../../forms/login.dart';
import '../../forms/signup.dart';
import '../../themes/theme_data.dart';
import '../../widgets/common/app_bar.dart';

const title = 'kCal Control';

Scaffold mobileIndex(BuildContext context) {
  return Scaffold(
    body: Row(children: <Widget>[
      SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.60,
          child: Center(
              child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text('Welcome to kCal Control',
                        style: Theme.of(context).textTheme.headlineLarge),
                  )))),
      SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.40,
          child: Card(
              color: Theme.of(context).disabledColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                        borderOnForeground: true,
                        color: Theme.of(context).secondaryHeaderColor,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const SignUpPage(),
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                    transitionsBuilder: (context, animation,
                                        animation2, child) {
                                      final offsetAnimation = Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero)
                                          .animate(animation);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ));
                            },
                            child: Text('Sign up',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall))),
                    Card(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: Text('Log in',
                                style:
                                    Theme.of(context).textTheme.headlineSmall)))
                  ])))
    ]),
  );
}
