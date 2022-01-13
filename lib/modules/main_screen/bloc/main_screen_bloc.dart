import 'dart:async';
import 'package:qr_coder/modules/main_screen/service/main_screen_service.dart';
import 'package:qr_coder/modules/show_qr_code_screen/service/show_qr_code_service.dart';
import 'main_screen_state.dart';

/// Класс управления состоянием модуля main_screen
class MainScreenBloc {
  final _mainScreenStreamController = StreamController<MainScreenState>();

  Stream<MainScreenState> get mainScreenStreamController =>
      _mainScreenStreamController.stream;

  /// Проверка наличия и получение URL из SharedPreferences
  void getURLFromSharedPreferences() async {
    await ShowCodeService().readeURLService().then(
      (url) {
        _mainScreenStreamController.sink
            .add(MainScreenState.readURLFromSharedPreferencesState(url));
      },
    );
  }

  /// Удаление ссылки на URL из SharedPreferences
  void deleteURLFromSharedPreferences() {
    ShowCodeService().deleteURLService().whenComplete(
      () {
        _mainScreenStreamController.sink
            .add(MainScreenState.readURLFromSharedPreferencesState(null));
      },
    );
  }

  /// Проверка значения для показа экрана ShowQRCodeScreen при запуске приложения
  void isShowQRCodeScreen() async {
    await MainScreenService().readeIsShowQRCodeScreenService().then(
      (isShowQRCodeScreen) {
        _mainScreenStreamController.sink.add(
          MainScreenState.readIsShowQRCodeScreenFromSharedPreferencesState(
              isShowQRCodeScreen),
        );
      },
    );
  }

  void dispose() {
    _mainScreenStreamController.close();
  }
}
