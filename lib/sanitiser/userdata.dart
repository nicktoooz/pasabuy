import 'package:pasabuy/models/userdata.dart';

class UserDataSanitise {
  static Map<String, String> sanitiseSignUp(UserData data) {
    Map<String, String> errors = {};

    if (data.name.isEmpty) errors['name-error'] = 'Name required';

    if (data.age < 1) errors['age-error'] = 'Invalid age';

    if (data.phone.isEmpty) {
      errors['phone-error'] = 'Phone number required';
    } else if (data.phone.length != 13) {
      errors['phone-error'] = 'Phone number must be 13 characters long';
    }

    if (data.email.isEmpty) {
      errors['email-error'] = 'Email required';
    } else if (!_isValidEmail(data.email)) {
      errors['email-error'] = 'Invalid email format';
    }

    if (data.password.isEmpty) {
      errors['password-error'] = 'Password required';
    } else if (data.password.length < 6) {
      errors['password-error'] = 'Password must be at least 6 characters long';
    }

    if (data.confirmPassword.isEmpty) {
      errors['confirm-password-error'] = 'Confirm Password required';
    } else if (data.password != data.confirmPassword) {
      errors['confirm-password-error'] = 'Passwords do not match';
    }

    return errors;
  }

  static Map<String, String> sanitiseSignIn(UserData data) {
    Map<String, String> errors = {};

    // Validate email
    if (data.email.isEmpty) {
      errors['email-error'] = 'Email required';
    } else if (!_isValidEmail(data.email)) {
      errors['email-error'] = 'Invalid email format';
    }

    // Validate password
    if (data.password.isEmpty) {
      errors['password-error'] = 'Password required';
    } else if (data.password.length < 6) {
      errors['password-error'] = 'Password must be at least 6 characters long';
    }

    return errors;
  }

  static bool _isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}
