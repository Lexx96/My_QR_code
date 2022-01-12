import 'package:qr_coder/modules/show_qr_code_screen/service/show_qr_code_repository.dart';

/// Класс обработки данных модуля show_qr_code_screen
class ShowCodeService {
  /// Запись ссылки на QR код
  Future<void> setUrlService(String? url) async {
    if (url != null) {
      await ShowCodeRepository().setURL(url);
    }
  }

  /// Чтение ссылки на QR код
  Future<String?> readeURLService() async {
    return await ShowCodeRepository().readURL();
  }

  /// Удаление ссылки на QR код
  Future<void> deleteURLService() async {
    await ShowCodeRepository().deleteURL();
  }
}
