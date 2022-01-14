/// Класс состояний модуля main_screen
class MainScreenState {
  MainScreenState();
  factory MainScreenState.readURLFromSharedPreferencesState(String? url) =
      ReadURLFromSharedPreferencesState;
}

/// Состояние прочтеного URL из SharedPreferences
class ReadURLFromSharedPreferencesState extends MainScreenState {
  String? url;
  ReadURLFromSharedPreferencesState(this.url);
}
