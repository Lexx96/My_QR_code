import 'dart:async';
import 'package:qr_coder/modules/show_qr_code_screen/bloc/show_qr_code_state.dart';

/// Класс управления состоянием модуля show_qr_code_screen
class ShowCodeBloc {
  final _showCodeStreamController = StreamController<ShowCodeState>();

  Stream<ShowCodeState> get viewStreamController =>
      _showCodeStreamController.stream;
}
