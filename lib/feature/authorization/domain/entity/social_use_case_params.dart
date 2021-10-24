class SocialUseCaseParams {
  final String id;
  final String token;
  final String? code;

  SocialUseCaseParams({
    required this.id,
    required this.token,
    this.code,
  });
}
