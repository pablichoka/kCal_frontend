import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kcal_control_frontend/pages/homePage.dart';
import 'package:kcal_control_frontend/pages/menu_builder.dart';
import 'package:kcal_control_frontend/pages/menu_list.dart';
import 'package:kcal_control_frontend/pages/profile.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:kcal_control_frontend/services/api_service.dart' as api;

import '../main.dart';
import '../themes/sidebar_theme.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  final String title = "kCal Control";

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  Widget _currentScreen = const ProfilePage();
  final SidebarXController _sidebarController = SidebarXController(selectedIndex: 0, extended: false);
  final Future<String?> _accessToken = storage.read(key: 'accessToken');

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
          theme: collapsedTheme(MediaQuery.of(context).size.width * 0.05),
          extendedTheme: extendedTheme(MediaQuery.of(context).size.width * 0.125),
          footerDivider: ActionChip(
            label: const Text('Log out'),
            onPressed: () async {
              Navigator.of(context).pop();
              await api.ApiService.instance.logout(_accessToken);
            },
          ),
          headerBuilder: (context, extended) {
            return SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/avatar.png'),
              ),
            );
          },
          controller: _sidebarController,
          items: [
            SidebarXItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () => _changeScreen(0)),
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
          animationDuration: Durations.long1,
        ),
        Expanded(child: Center(
          child: _currentScreen,
        ))
      ]),
    );
  }
}

// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   toolbarHeight: 80,
//   elevation: 0,
//   centerTitle: true,
//   title: Text(widget.title,
//       style: Theme.of(context).textTheme.headlineLarge),
//   backgroundColor: Colors.transparent,
//   flexibleSpace: Container(
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topRight,
//         end: Alignment.bottomLeft,
//         colors: [Colors.blueAccent, Colors.grey, Colors.teal],
//       ),
//     ),
//   ),
// ),
// body: _currentScreen,
// bottomNavigationBar: BottomNavigationBar(
//   elevation: 10,
//   items: const [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: 'Home',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.account_tree_sharp),
//       label: 'Menu builder',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.food_bank),
//       label: 'Menu list',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.account_circle_outlined),
//       label: 'Profile',
//     ),
//   ],
//   onTap: (index) {
//     if (index == 0) {
//       _changeScreen(const HomePage());
//     } else if (index == 1) {
//       _changeScreen(const MenuBuilder());
//     } else if (index == 2) {
//       _changeScreen(const MenuList());
//     } else {
//       _changeScreen(const ProfilePage());
//     }
//   },
// ),
