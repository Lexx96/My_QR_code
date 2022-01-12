import 'dart:async';
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
}
