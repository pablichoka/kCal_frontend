import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:kcal_control_frontend/themes/theme_data.dart';

SidebarXTheme collapsedTheme(double width, BuildContext context) {
  var theme = SidebarXTheme(
    width: width,
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
    ),
    hoverColor: hoverColor,
    textStyle: sidebarTextStyle,
    selectedTextStyle:
        const TextStyle(color: dark, fontSize: 20, fontWeight: FontWeight.bold),
    hoverTextStyle:
        const TextStyle(color: dark, fontSize: 20, fontWeight: FontWeight.bold),
    itemTextPadding: const EdgeInsets.only(left: 30),
    selectedItemTextPadding: const EdgeInsets.only(left: 30),
    itemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    selectedItemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: white,
      boxShadow: [
        BoxShadow(
          color: dark.withOpacity(0.1),
          blurRadius: 30,
        )
      ],
    ),
    iconTheme: const IconThemeData(
      color: white,
      size: 40,
    ),
    selectedIconTheme: const IconThemeData(
      color: dark,
      size: 40,
    ),
  );
  return theme;
}

SidebarXTheme extendedTheme(double width, BuildContext context) {
  var theme = SidebarXTheme(
    width: width,
    itemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    itemMargin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    selectedItemDecoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(20),
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
    ),
  );
  return theme;
}

const iconHeader = SizedBox(
  height: 150,
  child: Center(
    child: Icon(Icons.fastfood, size: 70, color: white),
  ),
);

const sidebarTextStyle =
    TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold);
