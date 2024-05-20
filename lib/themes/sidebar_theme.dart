import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

SidebarXTheme collapsedTheme(double width) {
  var theme = SidebarXTheme(
    width: width,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.brown,
      borderRadius: BorderRadius.circular(20),
    ),
    hoverColor: Colors.greenAccent,
    textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
    selectedTextStyle: const TextStyle(color: Colors.white),
    hoverTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    itemTextPadding: const EdgeInsets.only(left: 30),
    selectedItemTextPadding: const EdgeInsets.only(left: 30),
    itemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.brown),
    ),
    selectedItemDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.limeAccent.withOpacity(0.37),
      ),
      gradient: const LinearGradient(
        colors: [Colors.red, Colors.blueAccent],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.28),
          blurRadius: 30,
        )
      ],
    ),
    iconTheme: IconThemeData(
      color: Colors.white.withOpacity(0.7),
      size: 40,
    ),
    selectedIconTheme: const IconThemeData(
      color: Colors.white,
      size: 50,
    ),
  );
  return theme;
}

SidebarXTheme extendedTheme(double width) {
  var theme = SidebarXTheme(
    width: width,
      decoration: const BoxDecoration(
        color: Colors.amberAccent,
      ),
      itemDecoration: const BoxDecoration(
        color: Colors.amber,
      ));
  return theme;
}
