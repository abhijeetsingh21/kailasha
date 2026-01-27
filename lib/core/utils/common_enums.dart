enum ApiStatus { int, loading, success, failed }

enum DriverType { ride, rescue }

enum DocumentUploadState { pending, uploaded }

enum OnlineStatus { init, offline, online }

enum FilePickStatus { init, success, cancelled, validationFailed, error }

enum ChatSender { driver, customer, system }

enum ForgotPasswordStep { enterEmail, verifyOtp, resetPassword }

enum Languages { en, pt }

enum HouseType { owned, rented }

extension LanguageExtn on Languages {
  String get value {
    switch (this) {
      case Languages.en:
        return "English";
      case Languages.pt:
        return "Portuguese";
    }
  }

  static Languages fromString(String value) {
    switch (value) {
      case "en":
        return Languages.en;
      case "pt":
        return Languages.pt;
      default:
        throw ArgumentError("Invalid language code: $value");
    }
  }
}

enum DeleteAccountReasonEnum {
  dontWantToUse,
  usingDifferentAccount,
  requestDelete,
  other,
}

extension DeleteAccountReasonExt on DeleteAccountReasonEnum {
  String get label {
    switch (this) {
      case DeleteAccountReasonEnum.dontWantToUse:
        return "I don't want to use this app anymore";
      case DeleteAccountReasonEnum.usingDifferentAccount:
        return "I'm using a different account";
      case DeleteAccountReasonEnum.requestDelete:
        return "Request to delete account";
      case DeleteAccountReasonEnum.other:
        return "Other";
    }
  }

  String get subLabel {
    switch (this) {
      case DeleteAccountReasonEnum.dontWantToUse:
        return "I no longer find the app useful and wish to delete my account.";
      case DeleteAccountReasonEnum.usingDifferentAccount:
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ";
      case DeleteAccountReasonEnum.requestDelete:
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ";
      case DeleteAccountReasonEnum.other:
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ";
    }
  }
}
