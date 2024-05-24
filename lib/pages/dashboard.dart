import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/pages/homePage.dart';
import 'package:kcal_control_frontend/pages/menu_builder.dart';
import 'package:kcal_control_frontend/pages/menu_list.dart';
import 'package:kcal_control_frontend/pages/profile.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../main.dart';
import '../services/theme_provider.dart';
import '../themes/sidebar_theme.dart';
import '../themes/theme_data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  final String title = "kCal Control";

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  Widget _currentScreen = const ProfilePage();
  final SidebarXController _sidebarController =
      SidebarXController(selectedIndex: 0);

  void _changeScreen(int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = const HomePage();
        break;
      case 1:
        screen = const MenuBuilder();
        break;
      case 2:
        screen = const MenuList();
        break;
      case 3:
        screen = const ProfilePage();
        break;
      default:
        throw Exception('Invalid index: $index');
    }

    setState(() {
      _currentScreen = screen;
      _sidebarController.selectIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        SidebarX(
          theme: collapsedTheme(MediaQuery.of(context).size.width * 0.05, context),
          extendedTheme:
              extendedTheme(MediaQuery.of(context).size.width * 0.125, context),
          footerDivider: IconButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await api.ApiService.instance
                  .logout(storage.read(key: 'accessToken'));
            },
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(white),
            ),
            icon: const Icon(Icons.logout),
            iconSize: 40,
            padding: const EdgeInsets.only(bottom: 40),
            hoverColor: Colors.transparent,
          ),
          headerBuilder: (context, extended) {
            return iconHeader;
          },
          controller: _sidebarController,
          items: [
            SidebarXItem(
              icon: Icons.home,
              label: 'Home',
              onTap: () => _changeScreen(0),
            ),
            SidebarXItem(
                icon: Icons.account_tree_sharp,
                label: 'Menu builder',
                onTap: () => _changeScreen(1)),
            SidebarXItem(
                icon: Icons.food_bank,
                label: 'Menu list',
                onTap: () => _changeScreen(2)),
            SidebarXItem(
                icon: Icons.account_circle_outlined,
                label: 'Profile',
                onTap: () => _changeScreen(3)),
          ],
          animationDuration: Durations.medium4,
        ),
        Expanded(
            child: Center(
          child: _currentScreen,
        )),
      ]),
      floatingActionButton: themeSelectorButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
