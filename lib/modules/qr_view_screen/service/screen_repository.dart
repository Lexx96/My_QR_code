import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesKeys {
  static const url = 'url';
}

/// Класс получения данных модуля qr_view_screen
class QRViewScreenRepository {
  final _storage = SharedPreferences.getInstance();

  /// Запись ссылки на QR код, принимает ссылку String? [url]
  Future<void> setURL(String? url) async {
    final storage = await _storage;
    storage.setString(SharedPreferencesKeys.url, url!);
  }

  /// Чтение ссылки на QR код
  Future<String?> readURL() async {
    final storage = await _storage;
    storage.getString(SharedPreferencesKeys.url);
  }
}
