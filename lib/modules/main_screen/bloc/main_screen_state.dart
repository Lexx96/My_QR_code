/// Класс состояний модуля main_screen
class MainScreenState {
  MainScreenState();
  factory MainScreenState.readURLFromSharedPreferencesState(String? url) =
      ReadURLFromSharedPreferencesState;

  factory MainScreenState.readURLFromGalleryState(String? url) =
      ReadURLFromGalleryState;

  factory MainScreenState.isFirstExitFromSharedPreferencesState(
      bool isFirstExit) = IsFirstExitFromSharedPreferencesState;
}

/// Состояние прочтеного URL из SharedPreferences
class ReadURLFromSharedPreferencesState extends MainScreenState {
  String? url;
  ReadURLFromSharedPreferencesState(this.url);
}

/// Состояние прочтеного URL из галереи
class ReadURLFromGalleryState extends MainScreenState {
  String? urlFromImage;
  ReadURLFromGalleryState(this.urlFromImage);
}

/// Состояние прочтеного значения для определения первого
/// входа при запуске приложения
class IsFirstExitFromSharedPreferencesState extends MainScreenState {
  bool isFirstExit;
  IsFirstExitFromSharedPreferencesState(this.isFirstExit);
}
