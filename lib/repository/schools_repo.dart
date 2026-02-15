import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/models/school_model/school_model.dart';

@LazySingleton()
class SchoolsRepo {
  static final _firestore = FirebaseFirestore.instance;

  //  static Future<List<SchoolModel>> fetchAllSchoolsAsAdmin() async {
  //     final snapshot = await _firestore
  //         .collection('schools')
  //         .orderBy('createdAt', descending: true)
  //         .get();

  //     return snapshot.docs.map((doc) => SchoolModel.fromFirestore(doc)).toList();
  //   }

  static Future<List<SchoolModel>> fetchAllSchoolsAsAdmin({
    String? searchQuery,
  }) async {
    Query<Map<String, dynamic>> query = _firestore.collection('schools');

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final formattedQuery = searchQuery.trim().toLowerCase();

      query = query
          .orderBy('name_lower')
          .where('name_lower', isGreaterThanOrEqualTo: formattedQuery)
          .where('name_lower', isLessThanOrEqualTo: '$formattedQuery\uf8ff');
    } else {
      query = query.orderBy('createdAt', descending: true);
    }

    final snapshot = await query.get();

    return snapshot.docs.map(SchoolModel.fromFirestore).toList();
  }
}
