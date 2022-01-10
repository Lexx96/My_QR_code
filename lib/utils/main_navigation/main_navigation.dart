import 'package:flutter/material.dart';
import 'package:qr_coder/modules/main_screen/main_screen.dart';
import 'package:qr_coder/modules/qr_view_screen/qr_view_screen.dart';
import 'package:qr_coder/modules/show_qr_code_screen/show_qr_code_screen.dart';

/// Класс параметров навигации
abstract class MainNavigationRouteName {
  static const mainScreen = 'mainScreen';
  static const viewScreen = 'viewScreen';
  static const showQRScreen = 'showQRScreen';
}

/// Класс навигации
class MainNavigation {
  final initialRouteMain = MainNavigationRouteName.mainScreen;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteName.mainScreen: (context) => const MainScreen(),
    MainNavigationRouteName.viewScreen: (context) => const QRViewScreen(),
    MainNavigationRouteName.showQRScreen: (context) => const ShowQRCodeScreen(
          url: null,
        ),
  };
}
