import 'package:html/parser.dart';
import 'package:qr_coder/modules/show_qr_code_screen/service/show_qr_code_repository.dart';

/// Класс обработки данных модуля show_qr_code_screen
class ShowCodeService {
  /// Получение данных по url
  Future getUserDataService({required String url}) async {
    final _response = await ShowCodeRepository().getUserData(url);
    if (_response.statusCode == 200) {
      var userData = parse(_response.body);
    }
  }
}
