import 'package:flutter/material.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool returnable;

  const DAppBar(
      {super.key, required this.title, this.actions, required this.returnable});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        automaticallyImplyLeading: returnable ? true : false,
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: actions,
        // flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //   color: Theme.of(context).primaryColor,
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
