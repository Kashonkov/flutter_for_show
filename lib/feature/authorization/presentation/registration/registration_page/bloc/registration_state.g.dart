// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegistrationState extends RegistrationState {
  @override
  final bool isLoading;
  @override
  final bool isTermsAccepted;
  @override
  final bool isRegistrationSuccessful;
  @override
  final RegistrationStep step;
  @override
  final bool canSendSms;
  @override
  final PhoneNumber? phoneNumber;
  @override
  final ErrorMessage? errorMessage;

  factory _$RegistrationState(
          [void Function(RegistrationStateBuilder)? updates]) =>
      (new RegistrationStateBuilder()..update(updates)).build();

  _$RegistrationState._(
      {required this.isLoading,
      required this.isTermsAccepted,
      required this.isRegistrationSuccessful,
      required this.step,
      required this.canSendSms,
      this.phoneNumber,
      this.errorMessage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isLoading, 'RegistrationState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(
        isTermsAccepted, 'RegistrationState', 'isTermsAccepted');
    BuiltValueNullFieldError.checkNotNull(isRegistrationSuccessful,
        'RegistrationState', 'isRegistrationSuccessful');
    BuiltValueNullFieldError.checkNotNull(step, 'RegistrationState', 'step');
    BuiltValueNullFieldError.checkNotNull(
        canSendSms, 'RegistrationState', 'canSendSms');
  }

  @override
  RegistrationState rebuild(void Function(RegistrationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegistrationStateBuilder toBuilder() =>
      new RegistrationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegistrationState &&
        isLoading == other.isLoading &&
        isTermsAccepted == other.isTermsAccepted &&
        isRegistrationSuccessful == other.isRegistrationSuccessful &&
        step == other.step &&
        canSendSms == other.canSendSms &&
        phoneNumber == other.phoneNumber &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, isLoading.hashCode),
                            isTermsAccepted.hashCode),
                        isRegistrationSuccessful.hashCode),
                    step.hashCode),
                canSendSms.hashCode),
            phoneNumber.hashCode),
        errorMessage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RegistrationState')
          ..add('isLoading', isLoading)
          ..add('isTermsAccepted', isTermsAccepted)
          ..add('isRegistrationSuccessful', isRegistrationSuccessful)
          ..add('step', step)
          ..add('canSendSms', canSendSms)
          ..add('phoneNumber', phoneNumber)
          ..add('errorMessage', errorMessage))
        .toString();
  }
}

class RegistrationStateBuilder
    implements Builder<RegistrationState, RegistrationStateBuilder> {
  _$RegistrationState? _$v;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  bool? _isTermsAccepted;
  bool? get isTermsAccepted => _$this._isTermsAccepted;
  set isTermsAccepted(bool? isTermsAccepted) =>
      _$this._isTermsAccepted = isTermsAccepted;

  bool? _isRegistrationSuccessful;
  bool? get isRegistrationSuccessful => _$this._isRegistrationSuccessful;
  set isRegistrationSuccessful(bool? isRegistrationSuccessful) =>
      _$this._isRegistrationSuccessful = isRegistrationSuccessful;

  RegistrationStep? _step;
  RegistrationStep? get step => _$this._step;
  set step(RegistrationStep? step) => _$this._step = step;

  bool? _canSendSms;
  bool? get canSendSms => _$this._canSendSms;
  set canSendSms(bool? canSendSms) => _$this._canSendSms = canSendSms;

  PhoneNumber? _phoneNumber;
  PhoneNumber? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(PhoneNumber? phoneNumber) =>
      _$this._phoneNumber = phoneNumber;

  ErrorMessage? _errorMessage;
  ErrorMessage? get errorMessage => _$this._errorMessage;
  set errorMessage(ErrorMessage? errorMessage) =>
      _$this._errorMessage = errorMessage;

  RegistrationStateBuilder();

  RegistrationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLoading = $v.isLoading;
      _isTermsAccepted = $v.isTermsAccepted;
      _isRegistrationSuccessful = $v.isRegistrationSuccessful;
      _step = $v.step;
      _canSendSms = $v.canSendSms;
      _phoneNumber = $v.phoneNumber;
      _errorMessage = $v.errorMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegistrationState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RegistrationState;
  }

  @override
  void update(void Function(RegistrationStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RegistrationState build() {
    final _$result = _$v ??
        new _$RegistrationState._(
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, 'RegistrationState', 'isLoading'),
            isTermsAccepted: BuiltValueNullFieldError.checkNotNull(
                isTermsAccepted, 'RegistrationState', 'isTermsAccepted'),
            isRegistrationSuccessful: BuiltValueNullFieldError.checkNotNull(
                isRegistrationSuccessful,
                'RegistrationState',
                'isRegistrationSuccessful'),
            step: BuiltValueNullFieldError.checkNotNull(
                step, 'RegistrationState', 'step'),
            canSendSms: BuiltValueNullFieldError.checkNotNull(
                canSendSms, 'RegistrationState', 'canSendSms'),
            phoneNumber: phoneNumber,
            errorMessage: errorMessage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
