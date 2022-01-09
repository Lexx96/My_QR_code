import 'dart:async';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_coder/modules/qr_view_screen/bloc/qr_view_screen_state.dart';
import 'package:qr_coder/modules/qr_view_screen/service/screen_service.dart';

/// Класс управления состоянием модуля qr_view_screen
class QRViewBloc {
  QRViewController? controller;

  QRViewBloc(this.controller);

  final _viewStreamController = StreamController<QRViewState>();

  Stream<QRViewState> get viewStreamController => _viewStreamController.stream;

  /// Получение ссылки с камеры, при сканировании QR кода,
  /// принимает контроллер QRViewController [controller]
  void onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // shared _preference
      _viewStreamController.sink.add(QRViewState.loadingViewState(scanData));
    });
  }

  /// Включение и отключение фанарика
  void onToggleFlash() async {
    await QRViewScreenService().changeToggleFlash(controller).then((_status) {
      _viewStreamController.sink.add(QRViewState.onToggleFlash(_status));
    });
  }

  /// Переключение между основной и фронтальной камерами
  void flipCamera() async {
    await QRViewScreenService().changeFlipCamera(controller);
  }

  /// Постановка камеры на паузу
  void pauseCamera() async {
    await QRViewScreenService().pauseCamera(controller);
  }

  /// Снятие камеры с паузы
  void resumeCamera() async {
    await QRViewScreenService().resumeCamera(controller);
  }

  void dispose() {
    _viewStreamController.close();
  }
}
