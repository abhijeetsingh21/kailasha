import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolModel {
  final String id;
  final String name;
  final String board;
  final String city;
  final String state;
  final String contactPerson;
  final String email;
  final List<dynamic> classes;
  final String role;
  final String createdBy;
  final bool isActive;
  final DateTime? createdAt;

  SchoolModel({
    required this.id,
    required this.name,
    required this.board,
    required this.city,
    required this.state,
    required this.contactPerson,
    required this.email,
    required this.classes,
    required this.role,
    required this.createdBy,
    required this.isActive,
    this.createdAt,
  });

  factory SchoolModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return SchoolModel(
      id: doc.id,
      name: data['name'] ?? '',
      board: data['board'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      contactPerson: data['contactPerson'] ?? '',
      email: data['email'] ?? '',
      classes: List<dynamic>.from(data['classes'] ?? []),
      role: data['role'] ?? '',
      createdBy: data['createdBy'] ?? '',
      isActive: data['isActive'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
