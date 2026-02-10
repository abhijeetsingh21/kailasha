import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';

class ExperimentRepository {
  final FirebaseFirestore _firestore;

  ExperimentRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Add experiment (Admin only)
  Future<void> addExperiment(ScienceExperiment experiment) async {
    final docRef = _firestore.collection('experiments').doc(experiment.id);

    await docRef.set({
      ...experiment.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': FirebaseAuth.instance.currentUser?.uid ?? 'admin',
      'isActive': true,
    });
  }

  /// Fetch all experiments (Admin usage)
  Future<List<ScienceExperiment>> fetchAllExperiments() async {
    try {
      final snapshot = await _firestore
          .collection('experiments')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map(ScienceExperiment.fromFirestore).toList();
    } on FirebaseException catch (e) {
      log('❌ Failed to fetch experiments: $e');
      rethrow;
    }
  }

  /// Fetch experiments by class (School + Admin)
  Future<List<ScienceExperiment>> fetchExperimentsByClassLevel({
    required String classLevel,
  }) async {
    final snapshot = await _firestore
        .collection('experiments')
        .where('classLevel', isEqualTo: classLevel)
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map(ScienceExperiment.fromFirestore).toList();
  }

  /// Mark experiment as performed (School)
  Future<void> markExperimentPerformed({
    String? schoolId,
    required String classLevel,
    required String experimentId,
    String? remarks,
  }) async {
    final currentSchoolId = schoolId ?? FirebaseAuth.instance.currentUser!.uid;
    await _firestore
        .collection('schools')
        .doc(currentSchoolId)
        .collection('classes')
        .doc(classLevel)
        .collection('experimentProgress')
        .doc(experimentId)
        .set({
          'isPerformed': true,
          'performedAt': FieldValue.serverTimestamp(),
          'remarks': remarks,
          'teacherId': FirebaseAuth.instance.currentUser?.uid,
        });
  }

  /// Fetch class-wise experiment progress for a school
  Future<Map<String, ClassExperimentProgress>> fetchClassExperimentProgress({
    String? schoolId,
    required String classLevel,
  }) async {
    final currentSchoolId =
        schoolId ?? FirebaseAuth.instance.currentUser?.uid ?? '';
    final snapshot = await _firestore
        .collection('schools')
        .doc(currentSchoolId)
        .collection('classes')
        .doc(classLevel)
        .collection('experimentProgress')
        .get();

    return {
      for (final doc in snapshot.docs)
        doc.id: ClassExperimentProgress.fromFirestore(doc),
    };
  }
}
