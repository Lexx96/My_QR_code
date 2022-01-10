import 'package:qr_code_scanner/qr_code_scanner.dart';

/// Класс состояний модуля qr_view_screen
class QRViewState {
  QRViewState();
  factory QRViewState.loadingViewState(Barcode result) = LoadingViewState;
  factory QRViewState.onToggleFlash(bool? onFlash) = OnToggleFlashState;
  factory QRViewState.uRLIsTrueState(String? url) = URLIsTrueState;
}

/// Состояние получения ссылки, принимаеет Barcode [result]
class LoadingViewState extends QRViewState {
  Barcode result;
  LoadingViewState(this.result);
}

/// Состояние включение и отключения фонарика, принимаеет bool [isOnFlash]
class OnToggleFlashState extends QRViewState {
  bool? isOnFlash;
  OnToggleFlashState(this.isOnFlash);
}

/// Состояние при верном url, принимаеет bool [isTrue]
class URLIsTrueState extends QRViewState {
  String? url;
  URLIsTrueState(this.url);
}
