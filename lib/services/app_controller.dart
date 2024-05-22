import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/pages/index.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kcal_control_frontend/services/theme_provider.dart';
import 'package:provider/provider.dart';

final ThemeData _kCalControlLightTheme = _buildKCalControlLightTheme();
final ThemeData _kCalControlDarkTheme = _buildKCalControlDarkTheme();

ThemeData _buildKCalControlLightTheme() {
  final ThemeData lightTheme = ThemeData.light();
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(164, 194, 165, 1),
        brightness: Brightness.light),
    textTheme: _buildKCalControlTextTheme(lightTheme.textTheme),
  );
}

ThemeData _buildKCalControlDarkTheme() {
  final ThemeData darkTheme = ThemeData.dark();
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(164, 194, 165, 1),
        brightness: Brightness.dark),
    textTheme: _buildKCalControlTextTheme(darkTheme.textTheme),
  );
}

TextTheme _buildKCalControlTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall?.copyWith(
          fontFamily: 'ProductSans',
          fontWeight: FontWeight.w300,
        ),
        headlineMedium: base.headlineMedium
            ?.copyWith(fontFamily: 'ProductSans', fontWeight: FontWeight.w400),
        headlineLarge: base.headlineLarge
            ?.copyWith(fontFamily: 'ProductSans', fontWeight: FontWeight.w500),
      )
      .apply(
        displayColor: Colors.white,
      );
}

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
