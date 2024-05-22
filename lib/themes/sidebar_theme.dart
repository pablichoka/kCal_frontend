import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:kcal_control_frontend/themes/theme_colors.dart';

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
    selectedTextStyle: sidebarTextStyle,
    hoverTextStyle: sidebarTextStyle,
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
    iconTheme: IconThemeData(
      color: Theme.of(context).focusColor,
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
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
    ),
    itemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    selectedItemDecoration: BoxDecoration(
      color: Theme.of(context).focusColor,
      borderRadius: BorderRadius.circular(20),
    ),
  );
  return theme;
}

const iconHeader = SizedBox(
  height: 150,
  child: Padding(
    padding: EdgeInsets.only(bottom: 16.0, top: 16.0),
    child: Icon(Icons.fastfood, size: 80, color: white),
  ),
);

const sidebarTextStyle =
    TextStyle(color: dark, fontSize: 20, fontWeight: FontWeight.bold);
