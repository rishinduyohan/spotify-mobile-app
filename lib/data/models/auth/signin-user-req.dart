class SigninUserReq {
  final String email;
  final String password;

  const SigninUserReq({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SigninUserReq.fromJson(Map<String, dynamic> json) {
    return SigninUserReq(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  SigninUserReq copyWith({
    String? email,
    String? password,
  }) {
    return SigninUserReq(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
