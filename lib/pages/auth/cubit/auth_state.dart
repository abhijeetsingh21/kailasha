import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final int remainingSeconds;
  final bool canResend;
  final int currentForgotPasswordIndex;
  const AuthState({
    required this.remainingSeconds,
    required this.canResend,
    required this.currentForgotPasswordIndex,
  });

  factory AuthState.initial() {
    return const AuthState(
      canResend: false,
      remainingSeconds: 30,
      currentForgotPasswordIndex: 0,
    );
  }

  AuthState copyWith({
    int? remainingSeconds,
    bool? canResend,
    int? currentForgotPasswordIndex,
  }) {
    return AuthState(
      canResend: canResend ?? this.canResend,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      currentForgotPasswordIndex:
          currentForgotPasswordIndex ?? this.currentForgotPasswordIndex,
    );
  }

  @override
  List<Object?> get props => [
    canResend,
    remainingSeconds,
    currentForgotPasswordIndex,
  ];
}
