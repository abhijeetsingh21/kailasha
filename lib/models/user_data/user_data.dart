class UserData {
  final String email;
  final String password;
  final String userId;

  UserData({
    required this.email,
    required this.userId,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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
