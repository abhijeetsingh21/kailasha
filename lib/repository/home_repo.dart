import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/core/utils/custom_toast.dart';

@LazySingleton()
class HomeRepo {
  final _firestore = FirebaseFirestore.instance;

  /// Add a class under a school
  Future<void> addClassToSchool({
    required String schoolId,
    required String className, // e.g. "Class 8"
    String? section, // e.g. "A"
  }) async {
    try {
      final classRef = _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('classes')
          .doc(); // auto-id

      await classRef.set({
        'name': className,
        'section': section,
        'createdAt': FieldValue.serverTimestamp(),
      });
      AppUtils.customToast(message: 'Class Added Successfully');
    } on FirebaseException catch (e) {
      AppUtils.customToast(message: e.message);
      rethrow;
    }
  }
}
