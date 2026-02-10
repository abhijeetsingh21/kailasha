class User {
  final String email;
  final String password;
  final String userId;

  User({
    required this.email,
    required this.userId,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      userId: json['userId'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userId': userId,
      'password': password,
    };
  }
}
