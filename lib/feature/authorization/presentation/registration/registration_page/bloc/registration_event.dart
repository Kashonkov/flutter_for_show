import 'package:flutter_for_show/core/widgets/international_phone_input/utils/phone_number.dart';

abstract class RegistrationEvent {
  const RegistrationEvent();
}

class AcceptedTermsEvent extends RegistrationEvent {
  final bool isAccepted;

  AcceptedTermsEvent(this.isAccepted);
}

class OnRegisterClickedEvent extends RegistrationEvent {
  final String phone;

  OnRegisterClickedEvent(this.phone);
}

class OnRegisterButtonClickedEvent extends RegistrationEvent {
  OnRegisterButtonClickedEvent();
}

class OnBackClickedEvent extends RegistrationEvent {
  OnBackClickedEvent();
}

class OnPhoneChangeEvent extends RegistrationEvent {
  final PhoneNumber value;

  OnPhoneChangeEvent(this.value);
}

class OnGoogleCLickedEvent extends RegistrationEvent {}

class OnAppleCLickedEvent extends RegistrationEvent {}

class OnFacebookCLickedEvent extends RegistrationEvent {}

class OnTermsNextCLicked extends RegistrationEvent {}

