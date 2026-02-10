import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';
import 'package:kailasha/repository/experiment_repo.dart';

part 'experiments_state.dart';

class ExperimentsCubit extends Cubit<ExperimentsState> {
  ExperimentsCubit() : super(ExperimentsState.initial());
  final _experimentRepository = ExperimentRepository();

  // Future<void> onAddExperiment({required ScienceExperiment experiment}) async {
  //   try {
  //     await _experimentRepository.addExperiment(experiment);
  //     await fetchAllExperiments(classLevel: state.currentClass);
  //   } catch (e) {
  //     log('error in add experiment -->$e');
  //   }
  // }

  Future<void> fetchAllExperiments({required String classLevel}) async {
    emit(
      state.copyWith(
        experimentApiStatus: ApiStatus.loading,
        currentClass: classLevel,
      ),
    );
    final experiments = await _experimentRepository
        .fetchExperimentsByClassLevel(classLevel: classLevel);
    emit(
      state.copyWith(
        experiments: experiments,
        experimentApiStatus: ApiStatus.success,
      ),
    );
  }
}
