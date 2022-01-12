import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesKeys {
  static const url = 'url';
}

/// Класс получения данных модуля show_qr_code_screen
class ShowCodeRepository {
  final _storage = SharedPreferences.getInstance();

  /// Запись ссылки на QR код, принимает ссылку String? [url]
  Future<void> setURL(String? url) async {
    final storage = await _storage;
    storage.setString(SharedPreferencesKeys.url, url!);
    final f = await readURL();
  }

  /// Чтение ссылки на QR код
  Future<String?> readURL() async {
    final storage = await _storage;
    return storage.getString(SharedPreferencesKeys.url);
  }

  /// Удаление ссылки на QR код
  Future<String?> deleteURL() async {
    final storage = await _storage;
    storage.clear();
  }
}
