part of 'experiments_cubit.dart';

class ExperimentsState extends Equatable {
  final ApiStatus experimentApiStatus;
  final List<ScienceExperiment> experiments;

  const ExperimentsState({
    required this.experiments,
    required this.experimentApiStatus,
  });

  factory ExperimentsState.initial() {
    return ExperimentsState(
      experiments: [],
      experimentApiStatus: ApiStatus.int,
    );
  }

  ExperimentsState copyWith({
    List<ScienceExperiment>? experiments,
    ApiStatus? experimentApiStatus,
  }) {
    return ExperimentsState(
      experiments: experiments ?? this.experiments,
      experimentApiStatus: experimentApiStatus ?? this.experimentApiStatus,
    );
  }

  @override
  List<Object?> get props => [experiments, experimentApiStatus];
}
