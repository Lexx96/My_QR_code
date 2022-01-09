import 'package:qr_code_scanner/qr_code_scanner.dart';

/// Класс обработки данных модуля qr_view_screen
class QRViewScreenService {
  /// Включение и отключение фанарика, принимает контроллер
  /// QRViewController? [controller]
  Future<bool?> changeToggleFlash(QRViewController? controller) async {
    await controller?.toggleFlash();
    return await controller?.getFlashStatus();
  }

  /// Переключение между основной и фронтальной камерами
  Future<void> changeFlipCamera(QRViewController? controller) async {
    await controller?.flipCamera();
  }

  /// Постановка камеры на паузу
  Future<void> pauseCamera(QRViewController? controller) async {
    await controller?.pauseCamera();
  }

  /// Постановка камеры на паузу
  Future<void> resumeCamera(QRViewController? controller) async {
    await controller?.resumeCamera();
  }
}
