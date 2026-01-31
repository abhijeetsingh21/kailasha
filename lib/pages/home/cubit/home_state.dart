part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<String> classes;

  const HomeState({required this.classes});

  factory HomeState.initial() {
    return HomeState(
      classes: [
        'Class 6\'th',
        'Class 7\'th',
        'Class 8\'th',
        'Class 9\'th',
        'Class 10\'th',
      ],
    );
  }

  HomeState copyWith({List<String>? classes}) {
    return HomeState(classes: classes ?? this.classes);
  }

  @override
  List<Object?> get props => [classes];
}
