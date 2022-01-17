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
        _mainScreenStreamController.sink.add(
          MainScreenState.readURLFromSharedPreferencesState(url),
        );
      },
    );
  }

  /// Удаление ссылки на URL из SharedPreferences
  void deleteURLFromSharedPreferences() {
    ShowCodeService().deleteURLService().whenComplete(
      () {
        _mainScreenStreamController.sink.add(
          MainScreenState.readURLFromSharedPreferencesState(null),
        );
      },
    );
  }

  /// Получение URL из галереи или памяти устройства по изображению
  void choicePickImage() {
    MainScreenService().getImageFile().then(
      (qrCode) async {
        if (qrCode.toString().length > 73) {
          switch (qrCode.toString().substring(49, 73)) {
            case 'https://www.gosuslugi.ru':
              _mainScreenStreamController.sink.add(
                MainScreenState.readURLFromGalleryState(
                  qrCode.toString().substring(49),
                ),
              );
              break;
            default:
              _mainScreenStreamController.sink.add(
                MainScreenState.readURLFromGalleryState(null),
              );
          }
        } else {
          _mainScreenStreamController.sink.add(
            MainScreenState.readURLFromGalleryState(null),
          );
        }
      },
    );
  }

  /// Чтение значения для определения первого входа при запуске приложения
  void isFirstExitFromSharedPreferences() async {
    await MainScreenService().readeIsFirstExitService().then(
      (_isFirstExit) {
        if (_isFirstExit != true) {
          _mainScreenStreamController.sink.add(
            MainScreenState.isFirstExitFromSharedPreferencesState(true),
          );
        } else {
          _mainScreenStreamController.sink.add(
            MainScreenState.isFirstExitFromSharedPreferencesState(false),
          );
        }
      },
    );
  }

  void dispose() {
    _mainScreenStreamController.close();
  }
}
