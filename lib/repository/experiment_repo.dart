import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kailasha/core/utils/custom_toast.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';

class ExperimentRepository {
  final FirebaseFirestore _firestore;

  ExperimentRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // Add experiment (Admin only)
  Future<void> addExperiment(ScienceExperiment experiment) async {
    final docRef = _firestore.collection('experiments').doc(experiment.id);

    await docRef.set({
      ...experiment.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': 'admin', // later: auth uid
      'isActive': true,
    });
  }

  /// Fetch all experiments
  Future<List<ScienceExperiment>?> fetchAllExperiments() async {
    try {
      final snapshot = await _firestore
          .collection('experiments')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ScienceExperiment.fromJson(doc.data()..['id'] = doc.id))
          .toList();
    } on FirebaseException catch (e) {
      log('❌ Failed to fetch experiments: $e');
    }
    return null;
  }
}
