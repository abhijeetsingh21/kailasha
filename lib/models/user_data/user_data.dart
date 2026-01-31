class UserData {
  final String phoneNumber;
  final String userId;

  UserData({
    required this.phoneNumber,
    required this.userId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      phoneNumber: json['phoneNumber'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'userId': userId,
    };
  }
}
