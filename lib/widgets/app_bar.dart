import 'package:flutter/material.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool returnable;

  const DAppBar({super.key, required this.title, this.actions, required this.returnable});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        automaticallyImplyLeading: returnable ? true : false,
        toolbarHeight: 80,
        elevation: 0,
        centerTitle: true,
        actions: actions,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blueAccent, Colors.grey, Colors.teal],
        ))));
  }
  @override
  Size get preferredSize => const Size.fromHeight(80);
}
