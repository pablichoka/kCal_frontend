import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/pages/index.dart';
import 'package:kcal_control_frontend/services/theme_provider.dart';
import 'package:kcal_control_frontend/themes/theme_data.dart';
import 'package:provider/provider.dart';

final ThemeData _kCalControlLightTheme = buildKCalControlLightTheme();
final ThemeData _kCalControlDarkTheme = buildKCalControlDarkTheme();

class KCalFront extends StatelessWidget {
  const KCalFront({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      home: kIsWeb ? const WebIndex() : const WebIndex(),
      theme: _kCalControlLightTheme,
      darkTheme: _kCalControlDarkTheme,
      themeMode: themeNotifier.themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}
