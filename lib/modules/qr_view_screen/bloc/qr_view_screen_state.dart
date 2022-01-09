import 'package:qr_code_scanner/qr_code_scanner.dart';

/// Класс состояний модуля qr_view_screen
class QRViewState {
  QRViewState();
  factory QRViewState.loadingViewState(Barcode result) = LoadingViewState;
  factory QRViewState.onToggleFlash(bool? onFlash) = OnToggleFlashState;
}

/// Состояние получения ссылки
class LoadingViewState extends QRViewState {
  Barcode result;
  LoadingViewState(this.result);
}

/// Состояние включение и отключения фонарика
class OnToggleFlashState extends QRViewState {
  bool? onFlash;
  OnToggleFlashState(this.onFlash);
}
