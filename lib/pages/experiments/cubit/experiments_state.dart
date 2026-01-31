part of 'experiments_cubit.dart';

class ExperimentsState extends Equatable {
  final List<ScienceExperiment> experiments;

  const ExperimentsState({required this.experiments});

  factory ExperimentsState.initial() {
    return ExperimentsState(experiments: dummyExperiments);
  }

  ExperimentsState copyWith({List<ScienceExperiment>? experiments}) {
    return ExperimentsState(experiments: experiments ?? this.experiments);
  }

  @override
  List<Object?> get props => [experiments];
}
