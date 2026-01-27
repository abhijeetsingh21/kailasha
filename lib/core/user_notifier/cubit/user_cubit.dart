import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/core/utils/common_enums.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState.initial());
  void updateUser({required DriverType user}) {
    emit(state.copyWith(user: user));
  }
}
