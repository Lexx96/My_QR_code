import 'package:flutter/material.dart';
import 'package:qr_coder/utils/main_navigation/main_navigation.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: MainNavigation().routes,
      initialRoute: MainNavigation().initialRouteMain,
    );
  }
}
