class AppErrors {
  static const String unknownErrorDetails =
      'Something went wrong. Please try again later.';

  static const String noInternet = 'No Internet Connection.';
  static const String emailNotAuthorisedError =
      'Email Address Not Authorized. Please contact your administrator or recapture correct email address';
  static const String emailAlredyRegisteredError =
      'Email Address has already been registered. Please contact your administrator';
  static const String invalidCodeError =
      'Incorrect Verification code. Re-Input Verification Code or click on Re-send Verification Code to have it resent';
  static const String deregisterCodeFaiError =
      'Deregistration verification failed. The verification email could not be sent.';
  static const String invalidDeregisterError =
      'Incorrect Verification code. Re-Input Verification Code or click on Re-send Verification Code to have it resent';
  static const String invalidDeregisterOtpLengthError =
      'Input otp must be of length 8';
}
