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

  Future<void> fetchClassExperiments({
    String? schoolId,
    required String classLevel,
  }) async {
    emit(
      state.copyWith(
        experimentApiStatus: ApiStatus.loading,
        currentClass: classLevel,
        schoolId: schoolId,
      ),
    );

    try {
      final experiments = await _experimentRepository
          .fetchExperimentsByClassLevel(classLevel: classLevel);

      final progressMap = await _experimentRepository
          .fetchClassExperimentProgress(
            schoolId: state.schoolId,
            classLevel: classLevel,
          );

      final merged = experiments.map((exp) {
        final progress = progressMap[exp.id];

        return MergedExperiment(
          experiment: exp,
          isPerformed: progress?.isPerformed ?? false,
          performedAt: progress?.performedAt,
        );
      }).toList();

      emit(
        state.copyWith(
          experiments: merged,
          experimentApiStatus: ApiStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(experimentApiStatus: ApiStatus.failed));
    }
  }

  Future<bool> markExperimentPerformed({
    String? schoolId,
    required String classLevel,
    required String experimentId,
    String? remarks,
  }) async {
    try {
      await _experimentRepository.markExperimentPerformed(
        schoolId: schoolId,
        classLevel: classLevel,
        experimentId: experimentId,
      );

      fetchClassExperiments(classLevel: classLevel);

      return true;
    } catch (e) {
      log('erro in mark exp done - $e');
    }
    return false;
  }
}
