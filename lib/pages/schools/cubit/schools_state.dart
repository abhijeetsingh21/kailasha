part of 'schools_cubit.dart';

class SchoolsState extends Equatable {
  final ApiStatus schoolsApiStatus;
  final List<SchoolModel> schools;

  const SchoolsState({required this.schools, required this.schoolsApiStatus});

  factory SchoolsState.initial() {
    return SchoolsState(schools: [], schoolsApiStatus: ApiStatus.int);
  }

  SchoolsState copyWith({
    List<SchoolModel>? schools,
    ApiStatus? schoolsApiStatus,
  }) {
    return SchoolsState(
      schools: schools ?? this.schools,
      schoolsApiStatus: schoolsApiStatus ?? this.schoolsApiStatus,
    );
  }

  @override
  List<Object?> get props => [schools, schoolsApiStatus];
}
