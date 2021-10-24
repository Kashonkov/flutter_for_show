import 'package:built_value/built_value.dart';
import 'package:i_talent/core/bloc/with_state_or_exception.dart';
import 'package:i_talent/core/widgets/international_phone_input/utils/phone_number.dart';
import 'package:i_talent/feature/authorization/presentation/registration/registration_page/registration_step.dart';

part 'registration_state.g.dart';

abstract class RegistrationState
    with DefState<RegistrationState>
    implements Built<RegistrationState, RegistrationStateBuilder> {
  bool get isLoading;

  bool get isTermsAccepted;
  bool get isRegistrationSuccessful;

  RegistrationStep get step;

  bool get canSendSms;

  PhoneNumber? get phoneNumber;

  RegistrationState._();

  factory RegistrationState([updates(RegistrationStateBuilder b)]) = _$RegistrationState;

  factory RegistrationState.initial() {
    return RegistrationState((b) => b
      ..step = RegistrationStep.terms
      ..isTermsAccepted = false
      ..isRegistrationSuccessful = false
      ..canSendSms = false
      ..errorMessage = null
      ..isLoading = false);
  }

  RegistrationState failure(String message) {
    return rebuild((b) => b
      ..errorMessage = ErrorMessage(message)
      ..isLoading = false);
  }

  RegistrationState loading() {
    return rebuild((b) => b
      ..errorMessage = null
      ..isLoading = true);
  }

  RegistrationState stopLoading() {
    return rebuild((b) => b..isLoading = false);
  }

  RegistrationState setTermsAccepted(bool isAccepted) {
    return rebuild((b) => b..isTermsAccepted = isAccepted);
  }

  RegistrationState setStep(RegistrationStep step) {
    return rebuild((b) => b..step = step);
  }

  RegistrationState setCanSend(bool canSend) {
    return rebuild((b) => b..canSendSms = canSend);
  }

  RegistrationState setRegistrationSuccessful(){
    return rebuild((b) => b..isRegistrationSuccessful = true);
  }

  RegistrationState setPhoneNumber(PhoneNumber? value){
    return rebuild((b) => b..phoneNumber = value);
  }
}
