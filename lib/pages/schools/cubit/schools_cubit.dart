import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/common/app_debouncer.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/models/school_model/school_model.dart';
import 'package:kailasha/repository/schools_repo.dart';

part 'schools_state.dart';

class SchoolsCubit extends Cubit<SchoolsState> {
  SchoolsCubit() : super(SchoolsState.initial()) {
    _appDeBouncer = AppDeBouncer(delay: Duration(milliseconds: 500));
  }
  late AppDeBouncer _appDeBouncer;

  Future<void> fetchAllSchoolsAsAdmin() async {
    emit(state.copyWith(schoolsApiStatus: ApiStatus.loading));

    final schools = await SchoolsRepo.fetchAllSchoolsAsAdmin();

    emit(state.copyWith(schools: schools, schoolsApiStatus: ApiStatus.success));
  }

  Future<void> searchSchool({required String searchQuery}) async {
    emit(state.copyWith(schoolsApiStatus: ApiStatus.loading));

    final schools = await SchoolsRepo.fetchAllSchoolsAsAdmin(
      searchQuery: searchQuery,
    );

    emit(state.copyWith(schools: schools, schoolsApiStatus: ApiStatus.success));
  }

  void onSearchChanged({required String searchQuery}) {
    _appDeBouncer.call(() {
      searchSchool(searchQuery: searchQuery);
    });
  }

  void callInit() {
    emit(SchoolsState.initial());
  }
}
