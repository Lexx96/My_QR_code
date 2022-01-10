/// Класс состояний модуля show_qr_code_screen
class ShowCodeState {
  ShowCodeState();
  factory ShowCodeState.loadedUserData() = LoadedUserData;
}

class LoadedUserData extends ShowCodeState {}
