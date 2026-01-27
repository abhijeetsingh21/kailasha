import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());
  void setIndex(int index) {
    if (index == state.selectedIndex) return;
    emit(state.copyWith(selectedIndex: index));
  }
}
