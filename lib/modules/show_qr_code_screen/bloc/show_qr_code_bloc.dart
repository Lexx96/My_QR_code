import 'dart:async';
import 'package:qr_coder/modules/show_qr_code_screen/bloc/show_qr_code_state.dart';
import 'package:qr_coder/modules/show_qr_code_screen/service/show_qr_code_service.dart';

/// Класс управления состоянием модуля show_qr_code_screen
class ShowCodeBloc {
  final _showCodeStreamController = StreamController<ShowCodeState>();

  Stream<ShowCodeState> get showQRCodeStreamController =>
      _showCodeStreamController.stream;

  /// Запись URL в setURLSharedPreferences, принимает URL String [_url]
  void setURLSharedPreferences(String _url) async {
    await ShowCodeService().setUrlService(_url).whenComplete(
      () {
        _showCodeStreamController.sink.add(ShowCodeState.recordedURLState());
      },
    );
  }

  /// Чтение URL из setURLSharedPreferences
  void readURLSharedPreferences() async {
    await ShowCodeService().readeURLService().then(
      (url) {
        if (url != null) {
          _showCodeStreamController.sink.add(ShowCodeState.readURLState(url));
        } else {
          _showCodeStreamController.sink.add(ShowCodeState.readURLState(null));
        }
      },
    );
  }

  /// Состояние для показа виджета QR кода, после загрузки старницы WebView
  void showQRCode() {
    _showCodeStreamController.sink.add(ShowCodeState.showQRCodeState());
  }

  void dispose() {
    _showCodeStreamController.close();
  }
}
