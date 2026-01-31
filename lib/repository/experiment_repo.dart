import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';

class ExperimentRepository {
  final FirebaseFirestore _firestore;

  ExperimentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Add experiment (Admin only)
  Future<void> addExperiment(ScienceExperiment experiment) async {
    final docRef = _firestore
        .collection('experiments')
        .doc(experiment.id);

    await docRef.set({
      ...experiment.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': 'admin', // later: auth uid
      'isActive': true,
    });
  }
}
