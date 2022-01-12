/// Класс состояний модуля qr_view_screen
class QRViewState {
  QRViewState();
  factory QRViewState.onToggleFlash(bool? onFlash) = OnToggleFlashState;
  factory QRViewState.uRLIsTrueState(String? url) = URLIsTrueState;
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
