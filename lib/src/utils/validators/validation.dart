
class AppValidator {
  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required.';
    }

    // Regular expression for email and phone validation
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegExp = RegExp(r'^(\+88|0088)?(01)[3456789](\d){8}$');

    if ((phoneRegExp.hasMatch(value)) || emailRegExp.hasMatch(value)){
      return null;
    } else{
      return 'Invalid Phone';
    }

  }


  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)){
      return 'Invalid email';
    }
    return null;
  }


  static String? validatePassword(String? value) {
    if (value != null || value!.isNotEmpty) {
      // Check for minimum password length
      if (value.length < 6) {
        return 'Password must be at least 6 characters long.';
      }
    }

    // Check for uppercase letters
    // if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one uppercase letter.';
    // }

    // Check for numbers
    // if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one number.';
    // }

    // Check for special characters
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character.';
    // }

    return null;
  }

  static String? validateConfirmPassword(String? confirmValue, passwordValue){
    if(confirmValue != passwordValue){
      return 'Confirm Password must be match with Password.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^(\+88|0088)?(01)[3456789](\d){8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? validateOtp(String? value){
    if(value == null || value.isEmpty){
      return 'Otp is required';
    }
    return null;
  }

// Add more custom validators as needed for your specific requirements.

  static String? validateAmount(String? value){
    final amount = RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');
    if ((amount.hasMatch(value!))){
      return null;
    } else{
      return 'Invalid email or phone';
    }
  }
}
