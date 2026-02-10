part of 'admin_profile_cubit.dart';

class AdminProfileState extends Equatable {
  final ApiStatus experimentApiStatus;
  final String currentClass;

  const AdminProfileState({
    required this.experimentApiStatus,
    required this.currentClass,
  });

  factory AdminProfileState.initial() {
    return AdminProfileState(
      experimentApiStatus: ApiStatus.int,
      currentClass: '',
    );
  }

  AdminProfileState copyWith({
    ApiStatus? experimentApiStatus,
    String? currentClass,
  }) {
    return AdminProfileState(
      experimentApiStatus: experimentApiStatus ?? this.experimentApiStatus,
      currentClass: currentClass ?? this.currentClass,
    );
  }

  @override
  List<Object?> get props => [experimentApiStatus, currentClass];
}
