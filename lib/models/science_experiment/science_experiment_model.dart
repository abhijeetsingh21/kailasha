import 'package:cloud_firestore/cloud_firestore.dart';

class ScienceExperiment {
  final String id;
  final String title;
  final String subject;
  final String classLevel;
  final String aim;
  final String theory;
  final List<String> materials;
  final List<Observation> observations;
  final String conclusion;
  final List<String> precautions;

  ScienceExperiment({
    required this.id,
    required this.title,
    required this.subject,
    required this.classLevel,
    required this.aim,
    required this.theory,
    required this.materials,
    required this.observations,
    required this.conclusion,
    required this.precautions,
  });

  /// 🔥 Firestore constructor
  factory ScienceExperiment.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    return ScienceExperiment(
      id: doc.id, // ✅ always correct
      title: data['title'] ?? '',
      subject: data['subject'] ?? '',
      classLevel: data['classLevel'] ?? '',
      aim: data['aim'] ?? '',
      theory: data['theory'] ?? '',
      materials: List<String>.from(data['materials'] ?? []),
      observations: (data['observations'] as List? ?? [])
          .map((e) => Observation.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      conclusion: data['conclusion'] ?? '',
      precautions: List<String>.from(data['precautions'] ?? []),
    );
  }

  /// Keep this for write / local usage
  factory ScienceExperiment.fromJson(Map<String, dynamic> json) {
    return ScienceExperiment(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      classLevel: json['classLevel'],
      aim: json['aim'],
      theory: json['theory'],
      materials: List<String>.from(json['materials']),
      observations: (json['observations'] as List)
          .map((e) => Observation.fromJson(e))
          .toList(),
      conclusion: json['conclusion'],
      precautions: List<String>.from(json['precautions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subject': subject,
      'classLevel': classLevel,
      'aim': aim,
      'theory': theory,
      'materials': materials,
      'observations': observations.map((e) => e.toJson()).toList(),
      'conclusion': conclusion,
      'precautions': precautions,
    };
  }
}

class Observation {
  final String observation;
  // final String lightIntensity;
  // final int oxygenBubblesPerMinute;

  Observation({
    required this.observation,
    // required this.lightIntensity,
    // required this.oxygenBubblesPerMinute,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      observation: json['observation'],
      // lightIntensity: json['lightIntensity'],
      // oxygenBubblesPerMinute: json['oxygenBubblesPerMinute'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'observation': observation,
      // 'lightIntensity': lightIntensity,
      // 'oxygenBubblesPerMinute': oxygenBubblesPerMinute,
    };
  }
}
