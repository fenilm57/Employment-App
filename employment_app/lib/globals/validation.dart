import 'package:firebase_auth/firebase_auth.dart';

///mobile number validation***********************************************************************
String validateMobile(String value) {
  if (value.length == 0) return "Enter mobile number";
  if (value.length != 10)
    return "Mobile number must be 10 digit";
  else
    return null;
}

///Password validation ***************************************************************************
String validatePassword(String value) {
  if (value.length == 0) return "Enter password number";
  if (value.length <= 6) {
    return "Password must be atleast 6 character";
  } else {
    return null;
  }
}

///Name Validation********************************************************************************
String validateName(String value) {
  if (value.isEmpty)
    return "Enter Name";
  else
    return null;
}

///Email Validation*********************************************************************************
String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty) return 'Enter email Address';
  if (!regExp.hasMatch(value))
    return 'Enter valid email Address';
  else
    return null;
}

///Address Validation********************************************************************************
String validateAddress(String value) {
  if (value.isEmpty)
    return "Enter Address";
  else
    return null;
}

String validateJob(String value) {
  if (value.isEmpty)
    return "Enter JOb Type";
  else
    return null;
}

String validatePinCode(String value) {
  if (value.isEmpty)
    return "Enter PinCode";
  else if (value.length != 6)
    return "Enter 6 digit PinCode";
  else
    return null;
}

String validateDropDown(String value) {
  if (value.isEmpty)
    return "Please select";
  else
    return null;
}
