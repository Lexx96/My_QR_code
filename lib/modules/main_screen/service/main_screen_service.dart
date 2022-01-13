import 'main_screen_repository.dart';

/// Класс обработки данных модуля main_screen
class MainScreenService {
  /// Запись значения для показа экрана ShowQRCodeScreen при запуске приложения,
  /// принимает bool? [isShowQRCodeScreen]
  Future<void> setIsShowQRCodeScreenService(bool isShowQRCodeScreen) async {
    await MainScreenRepository()
        .setIsShowQRCodeScreenRepository(isShowQRCodeScreen);
  }

  /// Чтение значения для показа экрана ShowQRCodeScreen при запуске приложения
  Future<bool?> readeIsShowQRCodeScreenService() async {
    return await MainScreenRepository().readIsShowQRCodeScreenRepository();
  }
}
