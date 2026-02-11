part of 'experiments_cubit.dart';

class ExperimentsState extends Equatable {
  final ApiStatus experimentApiStatus;
  final List<MergedExperiment> experiments;
  final String currentClass;
  final String schoolId;

  const ExperimentsState({
    required this.experiments,
    required this.experimentApiStatus,
    required this.currentClass,
    required this.schoolId,
  });

  factory ExperimentsState.initial() {
    return ExperimentsState(
      experiments: [],
      experimentApiStatus: ApiStatus.int,
      currentClass: '',
      schoolId: '',
    );
  }

  ExperimentsState copyWith({
    List<MergedExperiment>? experiments,
    ApiStatus? experimentApiStatus,
    String? currentClass,
    String? schoolId,
  }) {
    return ExperimentsState(
      experiments: experiments ?? this.experiments,
      experimentApiStatus: experimentApiStatus ?? this.experimentApiStatus,
      currentClass: currentClass ?? this.currentClass,
      schoolId: schoolId ?? this.schoolId,
    );
  }

  @override
  List<Object?> get props => [
    experiments,
    experimentApiStatus,
    currentClass,
    schoolId,
  ];
}
