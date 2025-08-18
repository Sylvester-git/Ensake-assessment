var regex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email field cannot be empty";
    } else if (!regex.hasMatch(email)) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field cannot be empty';
    } else if (password.length < 8) {
      return 'Password must be 8 characters or more';
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(password)) {
      return 'Password must contain at least one letter and one number';
    } else {
      return null;
    }
  }

  static String? validateField(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Field cannot be empty";
    } else {
      return null;
    }
  }

  static String? validatePhonenumber(String? str) {
    RegExp regExp = RegExp(r"^\d{10,11}$");

    if (!regExp.hasMatch(str!)) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword({
    String? confirmPassword,
    required String password,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'This field cannot be empty';
    } else if (confirmPassword != password) {
      return 'Password must be the same';
    } else {
      return null;
    }
  }
}
