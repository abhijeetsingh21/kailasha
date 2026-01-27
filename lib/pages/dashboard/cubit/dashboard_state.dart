part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final int selectedIndex;

  const DashboardState({
    required this.selectedIndex,
  });

  factory DashboardState.initial() {
    return const DashboardState(selectedIndex: 0);
  }

  DashboardState copyWith({
    int? selectedIndex,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
