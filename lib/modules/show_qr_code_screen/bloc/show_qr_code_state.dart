/// Класс состояний модуля show_qr_code_screen
class ShowCodeState {
  ShowCodeState();
  factory ShowCodeState.recordedURLState() = RecordedURLState;
  factory ShowCodeState.readURLState(String? url) = ReadURLState;
  factory ShowCodeState.showQRCodeState() = ShowQRCodeState;
}

/// Состояние записанного URL в SharedPreferences
class RecordedURLState extends ShowCodeState {}

/// Состояние прочтеного URL из SharedPreferences
class ReadURLState extends ShowCodeState {
  String? url;
  ReadURLState(this.url);
}

/// Состояние для показа виджета QR кода, после загрузки старницы WebView
class ShowQRCodeState extends ShowCodeState {}
