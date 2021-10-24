abstract class BlocNews{}

class ErrorBlocNews extends BlocNews{
  final String errorMessage;

  ErrorBlocNews(this.errorMessage);
}
