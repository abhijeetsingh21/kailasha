import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final int remainingSeconds;
  final String phoneNumber;
  final bool canResend;
  final int currentForgotPasswordIndex;
  final User? userData;
  const AuthState({
    required this.remainingSeconds,
    required this.canResend,
    required this.currentForgotPasswordIndex,
    required this.phoneNumber,
    required this.userData,
  });

  factory AuthState.initial() {
    return const AuthState(
      canResend: false,
      remainingSeconds: 30,
      currentForgotPasswordIndex: 0,
      phoneNumber: '',
      userData: null,
    );
  }

  AuthState copyWith({
    int? remainingSeconds,
    bool? canResend,
    int? currentForgotPasswordIndex,
    String? phoneNumber,
    User? userData,
  }) {
    return AuthState(
      canResend: canResend ?? this.canResend,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      currentForgotPasswordIndex:
          currentForgotPasswordIndex ?? this.currentForgotPasswordIndex,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [
    canResend,
    remainingSeconds,
    currentForgotPasswordIndex,
    phoneNumber,
    userData,
  ];
}
