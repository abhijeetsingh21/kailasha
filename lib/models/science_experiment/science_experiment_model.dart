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
      'id': id,
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
  final int distanceCm;
  final String lightIntensity;
  final int oxygenBubblesPerMinute;

  Observation({
    required this.distanceCm,
    required this.lightIntensity,
    required this.oxygenBubblesPerMinute,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      distanceCm: json['distanceCm'],
      lightIntensity: json['lightIntensity'],
      oxygenBubblesPerMinute: json['oxygenBubblesPerMinute'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distanceCm': distanceCm,
      'lightIntensity': lightIntensity,
      'oxygenBubblesPerMinute': oxygenBubblesPerMinute,
    };
  }
}

final List<ScienceExperiment> dummyExperiments = [
  // Photosynthesis
  ScienceExperiment(
    id: 'EXP001',
    title: 'Effect of Light Intensity on Photosynthesis',
    subject: 'Science',
    classLevel: 'Class 8',
    aim:
        'To study the effect of light intensity on the rate of photosynthesis.',
    theory:
        'Photosynthesis is the process by which green plants prepare food using sunlight.',
    materials: [
      'Beaker',
      'Hydrilla plant',
      'Funnel',
      'Test tube',
      'Table lamp',
      'Sodium bicarbonate',
    ],
    observations: [
      Observation(
        distanceCm: 10,
        lightIntensity: 'Very High',
        oxygenBubblesPerMinute: 32,
      ),
      Observation(
        distanceCm: 20,
        lightIntensity: 'High',
        oxygenBubblesPerMinute: 24,
      ),
      Observation(
        distanceCm: 30,
        lightIntensity: 'Medium',
        oxygenBubblesPerMinute: 16,
      ),
      Observation(
        distanceCm: 40,
        lightIntensity: 'Low',
        oxygenBubblesPerMinute: 9,
      ),
      Observation(
        distanceCm: 50,
        lightIntensity: 'Very Low',
        oxygenBubblesPerMinute: 4,
      ),
    ],
    conclusion:
        'Rate of photosynthesis increases with increase in light intensity.',
    precautions: ['Use fresh green plant', 'Avoid external light variations'],
  ),

  // Ohm’s Law
  ScienceExperiment(
    id: 'EXP002',
    title: 'Verification of Ohm’s Law',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To verify the relationship between voltage and current.',
    theory:
        'Ohm’s Law states that current is directly proportional to voltage at constant temperature.',
    materials: [
      'Battery',
      'Ammeter',
      'Voltmeter',
      'Resistor',
      'Connecting wires',
    ],
    observations: [
      Observation(
        distanceCm: 1,
        lightIntensity: '1V',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 2,
        lightIntensity: '2V',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 3,
        lightIntensity: '3V',
        oxygenBubblesPerMinute: 0,
      ),
    ],
    conclusion:
        'Voltage and current are directly proportional, verifying Ohm’s Law.',
    precautions: ['Connections should be tight', 'Do not exceed voltage limit'],
  ),

  // Separation of Mixtures
  ScienceExperiment(
    id: 'EXP003',
    title: 'Separation of Salt and Sand',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To separate salt and sand mixture.',
    theory: 'Salt dissolves in water while sand does not, allowing separation.',
    materials: ['Salt', 'Sand', 'Water', 'Filter paper', 'Beaker'],
    observations: [
      Observation(
        distanceCm: 0,
        lightIntensity: 'Before filtration',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 0,
        lightIntensity: 'After evaporation',
        oxygenBubblesPerMinute: 0,
      ),
    ],
    conclusion:
        'Salt and sand can be separated using filtration and evaporation.',
    precautions: ['Filter properly', 'Heat gently during evaporation'],
  ),

  // Laws of Reflection
  ScienceExperiment(
    id: 'EXP004',
    title: 'Verification of Laws of Reflection',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To verify laws of reflection using a plane mirror.',
    theory: 'Angle of incidence is equal to angle of reflection.',
    materials: ['Plane mirror', 'Ray box', 'Protractor', 'Drawing sheet'],
    observations: [
      Observation(
        distanceCm: 30,
        lightIntensity: '30° incidence',
        oxygenBubblesPerMinute: 30,
      ),
      Observation(
        distanceCm: 45,
        lightIntensity: '45° incidence',
        oxygenBubblesPerMinute: 45,
      ),
      Observation(
        distanceCm: 60,
        lightIntensity: '60° incidence',
        oxygenBubblesPerMinute: 60,
      ),
    ],
    conclusion: 'Angle of incidence equals angle of reflection.',
    precautions: ['Mirror should be clean', 'Measure angles carefully'],
  ),

  // Chemical Change
  ScienceExperiment(
    id: 'EXP005',
    title: 'Chemical Reaction Between Iron and Copper Sulphate',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To study a displacement reaction.',
    theory:
        'More reactive metals displace less reactive metals from their compounds.',
    materials: ['Iron nails', 'Copper sulphate solution', 'Beaker'],
    observations: [
      Observation(
        distanceCm: 0,
        lightIntensity: 'Initial',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 0,
        lightIntensity: 'After 30 min',
        oxygenBubblesPerMinute: 0,
      ),
    ],
    conclusion: 'Iron displaces copper from copper sulphate solution.',
    precautions: ['Use clean iron nails', 'Handle chemicals carefully'],
  ),

  // Sound Vibrations
  ScienceExperiment(
    id: 'EXP006',
    title: 'Sound is Produced by Vibrations',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To show that sound is produced by vibrating objects.',
    theory: 'Vibrations produce sound which travels through a medium.',
    materials: ['Tuning fork', 'Water', 'Rubber hammer'],
    observations: [
      Observation(
        distanceCm: 0,
        lightIntensity: 'Struck fork',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 0,
        lightIntensity: 'Water splashes',
        oxygenBubblesPerMinute: 0,
      ),
    ],
    conclusion: 'Sound is produced due to vibrations.',
    precautions: ['Strike gently', 'Do not bend tuning fork'],
  ),

  // Force and Pressure
  ScienceExperiment(
    id: 'EXP007',
    title: 'Pressure Depends on Area',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To show that pressure depends on area.',
    theory: 'Pressure increases when force is applied over a smaller area.',
    materials: ['Brick', 'Sand tray'],
    observations: [
      Observation(
        distanceCm: 0,
        lightIntensity: 'Flat surface',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 0,
        lightIntensity: 'Edge surface',
        oxygenBubblesPerMinute: 0,
      ),
    ],
    conclusion: 'Smaller area produces greater pressure.',
    precautions: ['Place brick carefully', 'Avoid spilling sand'],
  ),

  // Combustion
  ScienceExperiment(
    id: 'EXP008',
    title: 'Air is Necessary for Combustion',
    subject: 'Science',
    classLevel: 'Class 8',
    aim: 'To show that air is necessary for burning.',
    theory: 'Oxygen supports combustion.',
    materials: ['Candle', 'Glass jar', 'Matchstick'],
    observations: [
      Observation(
        distanceCm: 0,
        lightIntensity: 'Candle burning',
        oxygenBubblesPerMinute: 0,
      ),
      Observation(
        distanceCm: 0,
        lightIntensity: 'Jar covered',
        oxygenBubblesPerMinute: 0,
      ),
    ],
    conclusion: 'Candle stops burning without air.',
    precautions: ['Handle fire carefully', 'Perform under supervision'],
  ),
];
