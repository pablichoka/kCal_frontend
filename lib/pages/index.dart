import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/forms/login.dart';
import 'package:kcal_control_frontend/forms/signup.dart';
import 'package:kcal_control_frontend/pages/desktop/index.dart';
import 'package:kcal_control_frontend/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart' as api;
import '../services/theme_provider.dart';
import '../themes/theme_data.dart';
import 'mobile/index.dart';



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
    try {
      var response = await apiService.getNoAuth('/index');
      setState(() {
        welcomeText = response['message'];
      });
    } catch (e) {
      setState(() {
        welcomeText = 'Connection failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? desktopIndex(context)
        : mobileIndex(context);
    //   floatingActionButton: themeSelectorButton(context),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    // );
  }
}

AppBar _indexAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: const Text("kCal Control"),
    leading: const Icon(Icons.fastfood),
  );
}
