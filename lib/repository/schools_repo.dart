import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/models/school_model/school_model.dart';

@LazySingleton()
class SchoolsRepo {
 static final _firestore = FirebaseFirestore.instance;

 static Future<List<SchoolModel>> fetchAllSchoolsAsAdmin() async {
    final snapshot = await _firestore
        .collection('schools')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => SchoolModel.fromFirestore(doc)).toList();
  }
}
  