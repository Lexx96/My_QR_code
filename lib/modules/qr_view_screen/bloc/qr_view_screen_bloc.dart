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
  /// проверка url,
  /// принимает контроллер QRViewController [controller]
  void onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) async {
        if (scanData.code!.length >= 24) {
          switch (scanData.code?.substring(0, 24)) {
            case 'https://www.gosuslugi.ru':
              _viewStreamController.sink.add(
                QRViewState.uRLIsTrueState(scanData.code),
              );
              break;
            default:
              _viewStreamController.sink.add(
                QRViewState.uRLIsTrueState(null),
              );
          }
        } else {
          _viewStreamController.sink.add(
            QRViewState.uRLIsTrueState(null),
          );
        }
      },
    );
  }

  /// Включение и отключение фанарика
  void onToggleFlash() async {
    await QRViewScreenService().changeToggleFlashService(controller).then(
      (_status) {
        _viewStreamController.sink.add(QRViewState.onToggleFlash(_status));
      },
    );
  }

  /// Переключение между основной и фронтальной камерами
  void flipCamera() async {
    await QRViewScreenService().changeFlipCameraService(controller);
  }

  /// Постановка камеры на паузу
  void pauseCamera() async {
    await QRViewScreenService().pauseCameraService(controller);
  }

  /// Снятие камеры с паузы
  void resumeCamera() async {
    await QRViewScreenService().resumeCameraService(controller);
  }

  void dispose() {
    _viewStreamController.close();
  }
}
