String emailRegex = r"/^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$/";
String mobileRegex = r'/^([+]\d{2})?\d{10}$/';

String? nameValidator(String? text) {
  if (text!.isEmpty) {
    return "Please enter a name ";
  } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(text)) {
    return "Name should not contain symbols or numerals";
  }
  return null;
}

String? emailValidator(String? text) {
  if (text!.isEmpty) {
    return "Please enter a email ";
  } else if (RegExp(emailRegex).hasMatch(text)) {
    return "Enter Correct email";
  }
  return null;
}

String? mobileValidator(String? text) {
  if (text!.isEmpty) {
    return "Please enter a number ";
  } else if (RegExp(mobileRegex).hasMatch(text)) {
    return "Number should contain only numerals";
  }
  return null;
}

String? passwordValidator(String? text) {
  if (text!.isEmpty) {
    return "Please enter a password ";
  } else if (text.length < 6) {
    return 'Password should be atleast of 6 characters';
  }
  return null;
}
