import 'package:image_picker/image_picker.dart';
import 'package:r_scan/r_scan.dart';
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

  /// Запись значения для определения первого входа при запуске приложения,
  Future<void> setIsFirstExitService() async {
    await MainScreenRepository().setIsFirstExitRepository();
  }

  /// Чтение значения для определения первого входа при запуске приложения
  Future<bool?> readeIsFirstExitService() async {
    return await MainScreenRepository().readIsFirstExitRepository();
  }

  /// Получение изображения из галереи или памяти устройства
  Future<String?> getImageFile() async {
    final XFile? imageXFile = await MainScreenRepository().pickImageXFile();
    if (imageXFile != null) {
      final result = await RScan.scanImagePath(imageXFile.path);
      return result.toString();
    }
  }
}
