bool isEmailValid(String email) {
  email = email.toLowerCase();
  const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  if (RegExp(emailPattern).hasMatch(email) ) {
    return true;
  } else {
    return false;
  }
}
bool passwordValidate(String password){
  var response= false;
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
   if (password.length < 8 || !regExp.hasMatch(password)) {
    response=false;
  }else{
    response= true;
  }
  return response;
}
bool isPhoneValid(String phoneNumber) {
  // Check if the phone number is exactly 10 digits long
  if (phoneNumber.length < 10) {
    return false;
  }

  // Check if the phone number contains only digits
  String pattern = r'^\d{10,}$';
  RegExp regExp = RegExp(pattern);

  return regExp.hasMatch(phoneNumber);
}


bool validatePassword(String password) {
  // Check if the password has at least 8 characters
  if (password.length < 8) {
    return false;
  }

  // Check if the password contains at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    return false;
  }

  // Check if the password contains at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    return false;
  }

  // Check if the password contains at least one digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    return false;
  }

  // Check if the password contains at least one special character
  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return false;
  }

  // All conditions met, return true
  return true;
}



String validateAndConvertOtp(String text) {
  final otpPattern = RegExp(r'otp', caseSensitive: false);

  // Find all occurrences of "otp" (case-insensitive)
  final matches = otpPattern.allMatches(text);

  // Replace occurrences iterating from the end
  var newText = text;
  for (var i = matches.length - 1; i >= 0; i--) {
    final match = matches.elementAt(i);
    newText = newText.replaceRange(match.start, match.end, "OTP");
  }

  return newText;
}


