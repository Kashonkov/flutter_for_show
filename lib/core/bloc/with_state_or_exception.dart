mixin DefState<T> {
  ErrorMessage? get errorMessage;

  bool get isLoading;

  T failure(String message);
}

class ErrorMessage{
  final String message;

  ErrorMessage(this.message);
}
