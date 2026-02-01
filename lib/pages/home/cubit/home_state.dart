part of 'home_cubit.dart';

class HomeState extends Equatable {
  final ApiStatus homeApiStatus;
  final List<SchoolClassModel> classes;

  const HomeState({required this.classes, required this.homeApiStatus});

  factory HomeState.initial() {
    return HomeState(classes: [], homeApiStatus: ApiStatus.int);
  }

  HomeState copyWith({
    List<SchoolClassModel>? classes,
    ApiStatus? homeApiStatus,
  }) {
    return HomeState(
      classes: classes ?? this.classes,
      homeApiStatus: homeApiStatus ?? this.homeApiStatus,
    );
  }

  @override
  List<Object?> get props => [classes, homeApiStatus];
}
