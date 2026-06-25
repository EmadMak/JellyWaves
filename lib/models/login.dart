class LoginResult {
  final String accessToken;
  final String userId;

  LoginResult({
    required this.accessToken,
    required this.userId
  });

  factory LoginResult.fromJson(Map<String, dynamic> json){
    final user = json['User'] as Map<String, dynamic>;

    return LoginResult(
      accessToken: json["AccessToken"] as String,
      userId: user['Id'] as String
    );
  }
}
