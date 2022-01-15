import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesKeysMainScreen {
  static const _isShowQRCodeScreen = 'isShowQRCodeScreen';
}

/// Класс получения данных модуля main_screen
class MainScreenRepository {
  final _storage = SharedPreferences.getInstance();

  /// Запись значения для показа экрана ShowQRCodeScreen при запуске приложения,
  /// принимает bool? [isShowQRCodeScreen]
  Future<void> setIsShowQRCodeScreenRepository(bool isShowQRCodeScreen) async {
    final storage = await _storage;
    await storage.setBool(SharedPreferencesKeysMainScreen._isShowQRCodeScreen,
        isShowQRCodeScreen);
  }

  /// Чтение значения для показа экрана ShowQRCodeScreen при запуске приложения
  Future<bool?> readIsShowQRCodeScreenRepository() async {
    final storage = await _storage;
    return storage.getBool(SharedPreferencesKeysMainScreen._isShowQRCodeScreen);
  }

  /// Получение изображения из галереи или памяти устройства
  Future pickImageXFile() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    return image;
  }
}
