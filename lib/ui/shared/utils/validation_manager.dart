class ValidationManager {
  static String? passwordValidator({String? value, int minimumLength = 8}) {
    if (value == "") {
      return null;
    } else if (value != null && value.length < minimumLength) {
      return "Password should have min $minimumLength characters";
    } else if (value != null &&
        !value.contains(RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%&\><*~])'))) {
      return "Password must be 8 digits and must contain an uppercase letter and at least a number and a special character.";
    }
    return null;
  }

  static String? confirmPasswordValidator(
      {String? value, String? newPasswordValue, int? minimumLength}) {
    if (value == "") {
      return null;
    } else if (value != null && newPasswordValue != value) {
      return "Passwords did not match";
    }
    return null;
  }

  static String? emailValidator({
    String? value,
  }) {
    String emailPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp emailRegExp = RegExp(emailPattern);
    if (value == null || value.isEmpty) {
      return null;
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? firstNameValidator({String? value}) {
    if (value == "") {
      return null;
    } else if (value!.length < 3) {
      return "First name should be at least 3 characters long";
    }
    return null;
  }

  static String? lastNameValidator({String? value}) {
    if (value == "") {
      return null;
    } else if (value!.length < 3) {
      return "Last name should be at least 3 characters long";
    }
    return null;
  }
}
