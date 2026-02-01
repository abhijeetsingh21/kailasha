import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolClassModel {
  final String id;          // Firestore document ID
  final String name;        // "Class 8"
  final String? section;    // "A"
  final DateTime? createdAt;

  SchoolClassModel({
    required this.id,
    required this.name,
    this.section,
    this.createdAt,
  });

  /// Firestore → Model
  factory SchoolClassModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return SchoolClassModel(
      id: doc.id,
      name: data['name'] as String,
      section: data['section'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'section': section,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }
}
