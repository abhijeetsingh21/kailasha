import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/repository/auth_repo.dart';
import 'package:kailasha/core/utils/custom_toast.dart';
import 'package:kailasha/pages/auth/cubit/auth_state.dart';

@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  AuthRepository repository;

  AuthCubit(this.repository) : super(AuthState.initial());

  Timer? _timer;

  Future<void> signIn({
    required String phoneNumber,
    required void Function(String) onCodeSent,
    required void Function(String) onError,
  }) async {
    try {
     await repository.sendOtp(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onError: onError,
      );
      
      appRouter.replaceAll([HomeRoute()]);
    } catch (e) {
      log('error in sign in -- $e');
      AppUtils.customToast(message: e.toString());
    }
  }

  Future<void> signUp() async {
    try {} catch (e) {
      log('error in sign in -- $e');
      AppUtils.customToast(message: e.toString());
    }
  }

  //  Start OTP timer
  void startOtpTimer() {
    _timer?.cancel();

    emit(state.copyWith(remainingSeconds: 30, canResend: false));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        timer.cancel();
        emit(state.copyWith(remainingSeconds: 0, canResend: true));
      } else {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    return;
  }

  // Resend OTP
  void resendOtp() {
    if (!state.canResend) return;

    //  Call resend OTP API here

    startOtpTimer();
  }

  void onForgotPageChanged({required int index}) {
    emit(state.copyWith(currentForgotPasswordIndex: index));
  }
}
