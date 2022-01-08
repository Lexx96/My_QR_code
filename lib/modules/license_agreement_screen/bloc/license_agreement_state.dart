
class LicenseAgreementState {
  LicenseAgreementState();
  factory LicenseAgreementState.empty() = EmptyLicenseAgreementState;
  factory LicenseAgreementState.accepted() = AcceptedLicenseAgreementState;

}

class EmptyLicenseAgreementState extends LicenseAgreementState{}

class AcceptedLicenseAgreementState extends LicenseAgreementState{}