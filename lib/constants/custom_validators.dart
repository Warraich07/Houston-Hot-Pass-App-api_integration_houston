class CustomValidator {
  static String? email(String? value) {
    if (value!.isEmpty) {
      return ' Email address is required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return ' Please enter valid email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value!.isEmpty) {
      return 'Enter password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // else if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one capital letter';
    // }
    // else if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one numerical digit';
    // } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }
    return null;
  }

  static String? newPassword(String? value) {
    if (value!.isEmpty) {
      return 'Enter new password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // else if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one capital letter';
    // } else if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one numerical digit';
    // } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }
    return null;
  }


  static String? oldPassword(String? value) {
    if (value!.isEmpty) {
      return 'Enter old password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // else if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one capital letter';
    // } else if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one numerical digit';
    // } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }
    return null;
  }

  static String? confirmPassword(String? value, String oldPassword) {
    if (value!.isEmpty) {
      return ' Confirm password is required';
    } else if (value.length < 8) {
      return ' Password must be at least 8 characters';
    }
    else if (value != oldPassword) {
      return ' Confirm password is not matched';
    }
    // else if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one capital letter';
    // } else if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one numerical digit';
    // } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password must contain at least one special character';
    // }
    return null;
  }

  static String? firstName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your First Name';
    }
    return null;
  }
  static String? isEmptyFirstName(String? value) {
    // Check if the value is empty
    if (value!.isEmpty) {
      return "First name is required";
    }

    // Check if the value contains any digits
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return "First name cannot contain numbers";  // Add this message in Languages
    }

    return null;
  }


  static String? isEmptyLocation(String? value) {
    if (value!.isEmpty) {
      return 'Please add your location';
    }
    return null;
  }
  static String? selectGenderRange(String? value) {
    // Ensure value is not null or empty
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }

    // Check if the input contains any digits
    final RegExp numberRegex = RegExp(r'[0-9]');
    if (numberRegex.hasMatch(value)) {
      return 'Gender cannot contain numbers';
    }

    return null; // No errors
  }

  static String? isEmptyWorkArea(String? value) {
    if (value!.isEmpty) {
      return 'Please add your work area';
    }
    return null;
  }

  static String? dineOutTime(String? value) {
    if (value!.isEmpty) {
      return 'Please add dine out times';
    }
    return null;
  }
  static String? date(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your date of birth';
    }
    return null;
  }

  static String? fullName(String? value) {
    if (value!.isEmpty) {
      return ' Please enter your full name';
    }
    return null;
  }

  static String? confirmAccessCode(String? value, String accessCode) {
    if (value != accessCode) {
      return " ACCESS CODE DOESN'T MATCH";
    }
    return null;
  }

  // static String? isEmpty(String? value) {
  //   if (value!.isEmpty ) {
  //     return ' Field cannot not be empty';
  //   }
  //   return null;
  // }
  static String? isEmptyCuisine(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? isEmptyTitle(String? value) {
    if (value!.isEmpty) {
      return ' Title is required';
    }
    return null;
  }

  static String? isEmptyReason(String? value) {
    if (value!.isEmpty) {
      return ' Reason is required';
    }
    return null;
  }

  static String? challengeFee(String? value) {
    if (value!.isEmpty) {
      return ' Challenge fee is required';
    }
    return null;
  }

  // static String? isEmptyUserName(String? value) {
  //   if (value!.isEmpty) {
  //     return ' Username is required';
  //   }
  //   return null;
  // }

  static String? description(String? value) {
    if (value!.isEmpty) {
      return ' Description is required';
    }
    return null;
  }

  static String? number(String? value) {
    if (value!.isEmpty) {
      return ' Phone number is required';
    } else if (value.length < 6) {
      return 'Phone number should be at least 6 digits';
    }
    return null;
  }

  static String? lessThen2(String? value) {
    return (value!.length < 2) ? ' Enter more then 1 characters' : null;
  }

  static String? lessThen3(String? value) {
    return (value!.length < 3) ? ' Enter more then 2 characters' : null;
  }

  static String? lessThen4(String? value) {
    return (value!.length < 4) ? ' Enter more then 3 characters' : null;
  }

  static String? lessThen5(String? value) {
    return (value!.length < 5) ? ' Enter more then 4 characters' : null;
  }

  static String? greaterThen(String? input, double compareWith) {
    return (double.parse(input ?? '0') < compareWith)
        ? ' New input must be greater'
        : null;
  }


}
