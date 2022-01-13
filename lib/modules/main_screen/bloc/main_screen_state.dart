/// Класс состояний модуля main_screen
class MainScreenState {
  MainScreenState();
  factory MainScreenState.readURLFromSharedPreferencesState(String? url) =
      ReadURLFromSharedPreferencesState;
  factory MainScreenState.readIsShowQRCodeScreenFromSharedPreferencesState(
          bool? isShowQRCodeScreen) =
      ReadIsShowQRCodeScreenFromSharedPreferencesState;
}

/// Состояние прочтеного URL из SharedPreferences
class ReadURLFromSharedPreferencesState extends MainScreenState {
  String? url;
  ReadURLFromSharedPreferencesState(this.url);
}

/// Состояние прочтеного значения для показа экрана ShowQRCodeScreen
/// при запуске приложения
class ReadIsShowQRCodeScreenFromSharedPreferencesState extends MainScreenState {
  bool? isShowQRCodeScreen;
  ReadIsShowQRCodeScreenFromSharedPreferencesState(this.isShowQRCodeScreen);
}
