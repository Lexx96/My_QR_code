/// Класс состояний модуля main_screen
class MainScreenState {
  MainScreenState();
  factory MainScreenState.readURLFromSharedPreferencesState(String? url) =
      ReadURLFromSharedPreferencesState;

  factory MainScreenState.readURLFromGalleryState(String? url) =
      ReadURLFromGalleryState;
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
