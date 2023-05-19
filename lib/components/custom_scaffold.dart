import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? drawer;
  final FloatingActionButton? floatingActionButton;

  const CustomScaffold({
    Key? key,
    required this.child,
    this.appBar,
    this.drawer,
    this.backgroundColor,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: appBar,
      drawer: drawer,
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
