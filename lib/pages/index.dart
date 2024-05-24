import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/forms/login.dart';
import 'package:kcal_control_frontend/forms/signup.dart';
import 'package:kcal_control_frontend/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart' as api;
import '../services/theme_provider.dart';
import '../themes/theme_data.dart';

class WebIndex extends StatefulWidget {
  const WebIndex({super.key});

  @override
  State<WebIndex> createState() => _WebIndexState();
}

class _WebIndexState extends State<WebIndex> {
  final String title = "kCal Control";
  String welcomeText = 'Loading...';

  @override
  void initState() {
    super.initState();
    loadWelcomeText();
  }

  Future<void> loadWelcomeText() async {
    var apiService = api.ApiService.instance;
    var response = await apiService.getNoAuth('/index');
    setState(() {
      welcomeText = response['message'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DAppBar(title: title, actions: const [], returnable: false),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              welcomeText,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  borderOnForeground: true,
                  color: const Color.fromRGBO(255, 255, 255, 0.75),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: Text(
                        'Sign up',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )),
                ),
                Card(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        'Log in',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      floatingActionButton: themeSelectorButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
