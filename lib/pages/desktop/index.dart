import 'package:flutter/material.dart';

import '../../forms/login.dart';
import '../../forms/signup.dart';
import '../../themes/theme_data.dart';
import '../../widgets/app_bar.dart';

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
      children: <Widget>[
        const BackgroundScreen(),
        Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Center(
                  child: Text('Welcome to kCal Control',
                      style: Theme.of(context).textTheme.headlineLarge),
                )),
          ],
        ),
      ],
    ),
    floatingActionButton: themeSelectorButton(context),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(context),
      child: Container(),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final BuildContext context;

  BackgroundPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Theme.of(context).primaryColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    Path trianglePath = Path();
    trianglePath.moveTo(0, size.height * 0.6);
    trianglePath.lineTo(size.width, size.height * 0.6);
    trianglePath.lineTo(size.width, size.height);
    trianglePath.close();
    paint.color = Theme.of(context).primaryColor;
    canvas.drawPath(trianglePath, paint);

    Path bottomPath = Path();
    bottomPath.moveTo(0, size.height * 0.8);
    bottomPath.lineTo(size.width, size.height * 0.6);
    bottomPath.lineTo(size.width, size.height);
    bottomPath.lineTo(0, size.height);
    bottomPath.close();

    paint.color = Theme.of(context).highlightColor;
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
