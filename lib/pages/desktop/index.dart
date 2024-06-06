import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/forms/desktop/login.dart';

import '../../forms/mobile/login.dart';
import '../../forms/signup.dart';
import '../../themes/theme_data.dart';
import '../../widgets/common/app_bar.dart';
import '../../widgets/desktop/background_index.dart';
import '../../widgets/desktop/carrousel_index.dart';

const title = 'kCal Control';

Scaffold desktopIndex(BuildContext context) {
  return Scaffold(
    appBar: DAppBar(
      title: title,
      returnable: false,
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: Text('Sign up',
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.color)))),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).highlightColor)),
                child: Text('Log in',
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.color)))),
      ],
    ),
    body: Stack(
      children: [
        const BackgroundScreen(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Center(
                        child: Text('Welcome to kCal Control',
                            style: Theme.of(context).textTheme.headlineLarge),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: IndexDesktopCarousel(context))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: const LoginForm()),
            ),
          ],
        ),
      ],
    ),
    floatingActionButton: themeSelectorButton(context),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}
