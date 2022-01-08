import 'dart:async';
import 'license_agreement_state.dart';


class LicenseAgreementBloc {

  final _streamController = StreamController<LicenseAgreementState>();
  Stream<LicenseAgreementState> get streamControllerLicense => _streamController.stream;

  void emptyState() {
    _streamController.sink.add(LicenseAgreementState.empty());
  }

  void accepted () {
    _streamController.sink.add(LicenseAgreementState.accepted());
  }

  void dispose(){
    _streamController.close();
  }
}