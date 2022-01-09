import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_coder/modules/qr_view_screen/service/screen_repository.dart';

/// Класс обработки данных модуля qr_view_screen
class QRViewScreenService {
  /// Включение и отключение фанарика, принимает контроллер
  /// QRViewController? [controller]
  Future<bool?> changeToggleFlashService(QRViewController? controller) async {
    await controller?.toggleFlash();
    return await controller?.getFlashStatus();
  }

  /// Переключение между основной и фронтальной камерами
  Future<void> changeFlipCameraService(QRViewController? controller) async {
    await controller?.flipCamera();
  }

  /// Постановка камеры на паузу
  Future<void> pauseCameraService(QRViewController? controller) async {
    await controller?.pauseCamera();
  }

  /// Постановка камеры на паузу
  Future<void> resumeCameraService(QRViewController? controller) async {
    await controller?.resumeCamera();
  }

  /// Запись ссылки на QR код
  void setUrlService(String? url) async {
    if (url != null) {
      await QRViewScreenRepository().setURL(url);
    }
  }

  /// Чтение ссылки на QR код
  Future<String?> readeURLService() async {
    return await QRViewScreenRepository().readURL();
  }
}
