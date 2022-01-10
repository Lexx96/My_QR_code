import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Класс получения данных модуля show_qr_code_screen
class ShowCodeRepository {
  var client = http.Client();

  /// Получение данных по url, принимает String [url]
  Future<Response> getUserData(String url) async {
    Response response = await client.get(Uri.parse(url));
    return response;
  }

  ///Получение данных для виджета WebView, принимает контроллекр WebViewController [controller]
  Future<String> getDataWebView(WebViewController controller) async {
    return await controller.runJavascriptReturningResult(
        "window.document.getElementsByClassName('mb-4 person-data-wrap align-items-center')[0].getElementsByClassName('small-text gray mr-4')[0].outerHTML;");
  }
}
