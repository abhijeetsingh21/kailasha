part of 'experiments_cubit.dart';

class ExperimentsState extends Equatable {
  final ApiStatus experimentApiStatus;
  final List<ScienceExperiment> experiments;
  final String currentClass;

  const ExperimentsState({
    required this.experiments,
    required this.experimentApiStatus,
    required this.currentClass,
  });

  factory ExperimentsState.initial() {
    return ExperimentsState(
      experiments: [],
      experimentApiStatus: ApiStatus.int,
      currentClass: '',
    );
  }

  ExperimentsState copyWith({
    List<ScienceExperiment>? experiments,
    ApiStatus? experimentApiStatus,
    String? currentClass,
  }) {
    return ExperimentsState(
      experiments: experiments ?? this.experiments,
      experimentApiStatus: experimentApiStatus ?? this.experimentApiStatus,
      currentClass: currentClass ?? this.currentClass,
    );
  }

  @override
  List<Object?> get props => [experiments, experimentApiStatus, currentClass];
}
