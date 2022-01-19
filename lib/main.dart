import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_coder/utils/main_navigation/main_navigation.dart';
import 'package:qr_coder/utils/themes/my_dark_theme.dart';
import 'package:qr_coder/utils/themes/my_light_theme.dart';
import 'generated/l10n.dart';
import 'modules/main_screen/service/main_screen_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Home(
      initialRoute: await isFirstScreen(),
    ),
  );
}

class Home extends StatelessWidget {
  final String? initialRoute;
  const Home({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: myLightTheme,
      dark: myDarkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (ThemeData light, ThemeData dark) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        localeResolutionCallback: (locales, supportedLocales) {
          if (locales == null) {
            return supportedLocales.first;
          }
        },
        routes: MainNavigation().routes,
        initialRoute: initialRoute,
      ),
    );
  }
}

///Определение страницы загрузки при запуске приложения
Future<String> isFirstScreen() async {
  final _isFirstScreen =
      await MainScreenService().readeIsShowQRCodeScreenService();
  if (_isFirstScreen != null && _isFirstScreen == true) {
    return MainNavigation().initialRouteShowQRCode;
  } else {
    return MainNavigation().initialRouteMain;
  }
}
