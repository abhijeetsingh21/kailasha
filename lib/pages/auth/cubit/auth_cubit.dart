import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/preference/preference.dart';
import 'package:kailasha/core/preference/preference_helper.dart';
import 'package:kailasha/models/user_data/user_data.dart' hide User;
import 'package:kailasha/pages/home/view/home_page.dart';
import 'package:kailasha/repository/auth_repo.dart';
import 'package:kailasha/core/utils/custom_toast.dart';
import 'package:kailasha/pages/auth/cubit/auth_state.dart';

@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  AuthRepository repository;

  AuthCubit(this.repository) : super(AuthState.initial()) {
    chackAuth();
  }

  Timer? _timer;
  void chackAuth() async {
    final user = await repository.fetchCurrentUser();
    if (user != null) {
      emit(state.copyWith(userData: user));
    }
  }

  void onPhoneNumberChanged({required String phoneNumber}) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final creds = await repository.signInWithEmail(
        email: email,
        password: password,
      );

      if (creds.user != null) {
         emit(state.copyWith(userData: creds.user));
        if (email == 'abhi@gmail.com') {
          appRouter.replaceAll([DashBoardRoute()]);
        } else {
          appRouter.replaceAll([HomeRoute(params: HomePageParams())]);
        }
        // await PreferenceHelper.setUserData(
        //   User(
        //     email: email,
        //     userId: creds.user?.uid ?? '-',
        //     password: password,
        //   ),
        // );
       
      }
    } on FirebaseAuthException catch (e) {
      log('error in email sign in -- ${e.message}');
    }
  }

  Future<void> signUp() async {
    try {} catch (e) {
      log('error in sign in -- $e');
      AppUtils.customToast(message: e.toString());
    }
  }

  Future<void> signOut() async {
    await repository.signOut();
    PreferenceHelper.clearAllPreferences();
    Preferences().init();
    appRouter.replaceAll([SignInForm()]);
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

  Future<void> createSchoolAccount({
    required String email,
    required String password,
    required String schoolName,
    required String board,
    required String city,
    required String state,
    required String contactPerson,
    // required List<String> classes,
  }) async {
    try {
      final user = await repository.createSchoolAccount(
        email: email,
        password: password,
        schoolName: schoolName,
        board: board,
        city: city,
        state: state,
        contactPerson: contactPerson,
        // classes: classes,
      );
      // PreferenceHelper.setUserData(
      //   User(email: email, userId: user?.uid ?? '', password: password),
      // );
      appRouter.replaceAll([HomeRoute(params: HomePageParams())]);
    } catch (e) {
      AppUtils.customToast(message: e.toString());
      log('❌ createSchool failed: $e');
    }
  }
}
