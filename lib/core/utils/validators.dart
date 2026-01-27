String? validatePhoneNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Phone number is required';
  }

  final phone = value.trim();

  // Allow only digits
  if (!RegExp(r'^\d+$').hasMatch(phone)) {
    return 'Phone number must contain only digits';
  }

  // International valid length range (E.164 without country code)
  // Most national numbers are between 7 and 15 digits
  if (phone.length < 7 || phone.length > 15) {
    return 'Enter a valid phone number';
  }

  return null;
}

String? nameValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Name cannot be empty';
  return null;
}

String? dobValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Date of Birth cannot be empty';
  }

  // match DD/MM/YYYY
  final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!regex.hasMatch(v.trim())) {
    return 'Enter date in DD/MM/YYYY format';
  }

  try {
    final parts = v.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    // simple range sanity checks
    if (month < 1 || month > 12) return 'Invalid month';
    if (day < 1 || day > 31) return 'Invalid day';
    if (year < 1900) return 'Invalid year';

    final date = DateTime(year, month, day);

    // ensure date actually exists (handles 30/31/Feb/Leap year etc.)
    if (date.day != day || date.month != month || date.year != year) {
      return 'Enter a valid calendar date';
    }

    final now = DateTime.now();

    // must not be in future
    if (date.isAfter(now)) return 'Date cannot be in the future';

    // OPTIONAL: age limit check (example: 18+)
    final age =
        now.year -
        year -
        ((now.month < month || (now.month == month && now.day < day)) ? 1 : 0);
    if (age < 18) return 'You must be at least 18 years old';
  } catch (_) {
    return 'Enter a valid date';
  }

  return null;
}

String? fullAddressValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Address cannot be empty';
  }

  final value = v.trim();

  // minimum length
  if (value.length < 6) {
    return 'Please enter a more detailed address';
  }

  // must contain letters
  if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
    return 'Address must contain letters';
  }

  // must contain at least one number (house / flat / street no.)
  if (!RegExp(r'\d').hasMatch(value)) {
    return 'Add house or building number';
  }

  // reject addresses that are only symbols
  if (RegExp(r'^[^A-Za-z0-9]+$').hasMatch(value)) {
    return 'Enter a valid address';
  }

  return null;
}

String? licenseNumberValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'License number cannot be empty';
  }

  final value = v.trim();

  if (value.length < 6 || value.length > 20) {
    return 'Enter a valid license number';
  }

  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9\-]+$').hasMatch(value)) {
    return 'License must contain letters and numbers';
  }

  return null;
}

String? vehicleTypeValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Please select a vehicle type';
  }
  return null;
}

String? vehicleYearValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Manufacturing year is required';
  }

  final value = v.trim();

  if (!RegExp(r'^\d{4}$').hasMatch(value)) {
    return 'Enter a valid 4-digit year';
  }

  final year = int.tryParse(value);
  final currentYear = DateTime.now().year;

  if (year == null || year < 1980 || year > currentYear) {
    return 'Enter a valid manufacturing year';
  }

  return null;
}

String? vehicleRegistrationValidator(String? v) {
  if (v == null || v.trim().isEmpty) {
    return 'Registration number cannot be empty';
  }

  final value = v.trim();

  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z0-9\- ]+$').hasMatch(value)) {
    return 'Enter a valid registration number';
  }

  if (value.length < 6) {
    return 'Registration number is too short';
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  final email = value.trim();
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (!regex.hasMatch(email)) {
    return 'Please enter a valid email address.';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Password is required';
  }

  final password = value.trim();

  if (password.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  final regex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&_#]).{8,}$',
  );
  if (!regex.hasMatch(password)) {
    return 'Password must include uppercase, lowercase, number, and special character.';
  }

  return null;
}

String? validateConfirmPassword(String? value, String? originalPassword) {
  if (value == null || value.trim().isEmpty) {
    return 'Please confirm your password';
  }

  if (value.trim() != originalPassword?.trim()) {
    return 'Passwords do not match';
  }

  return null;
}
