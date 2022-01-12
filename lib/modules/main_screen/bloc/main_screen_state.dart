/// Класс состояний модуля main_screen
class MainScreenState {
  MainScreenState();
  factory MainScreenState.readURLFromSharedPreferencesState(String? url) =
      ReadURLFromSharedPreferencesState;
}

class ReadURLFromSharedPreferencesState extends MainScreenState {
  String? url;
  ReadURLFromSharedPreferencesState(this.url);
}
