import 'package:flutter/material.dart';

class AppColors {
  /// Primary Dark Purple
  static const Color primaryColor = Color(0xFF4A154B);

  /// Secondary Pink
  static const Color secondaryColor = Color(0xFFE089CE);
  static const Color secondaryPinkColor = Color(0xFFFCB3B3);
  static const Color pinkColor = Color(0xFFED0ECC);
  static const Color lightRedColor = Color(0xFFF06969);
  static const Color lightPinkColor = Color(0xFFFCF2FA);

  static const Color bgColor = Color(0xFFF3E6E0);
  static const Color textColor = Color(0xFF1E1E1E);

  static const Color textFieldBgColor = Color(0xFFFFFFFF);
  static const Color textFieldBorderColor = Color(0xFFE6E6E6);
  static const Color hintTextColor = Color(0xFF808080);

  static const Color profileIconBgColor = Color(0xFFD9D9D9);
  static const Color boxBorderColor = Color(0xFFE6E6E6);
  static const Color cameraColor = Color(0xFFEEDFED);
  static const Color white = Color(0xFFFFFFFF);
  static const Color erroMessage = Color(0xFFBF0404);

  /// ! TODO: Review below
  static const Color lightTextColor = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFE6E6E6);
  static const Color greyColor = Color(0xFF9EA1AE);
  static const Color borderColor = Color(0xFFBDC4CD);
  static const Color greyTextColor = Color(0xFF838BA1);
  static const Color smokeTextColor = Color(0xFFDAD8D8);
  static const Color progressBgColor = Color(0xFFEEEEEE);
  static const Color progressFgColor = Color(0xFF4D5DFA);
  static const Color greenColor = Color(0xFF4CD964);
  static const Color redColor = Color(0xFFFF1F00);
  static const Color darkGreenColor = Color(0xFF31A05F);

  // Barrier Color for dialogs/alert messages popups
  static final Color barrierColor = const Color(0xFF151515).withOpacity(0.62);
  static final Color secondaryBarrierColor = const Color(0xFF101117).withOpacity(0.9);
}

const TextStyle regular = TextStyle(
  fontFamily: 'Comfortaa',
  fontSize: 18,
  color: AppColors.textColor,
  fontWeight: FontWeight.w400,
);

/// 300 font weight
const TextStyle light = TextStyle(
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w300,
  fontSize: 18,
  color: AppColors.textColor,
);

/// 500 font weight
const TextStyle medium = TextStyle(
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w500,
  fontSize: 18,
  color: AppColors.textColor,
);

/// 600 font weight
const TextStyle semiBold = TextStyle(
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w600,
  fontSize: 18,
  color: AppColors.textColor,
);

/// 700 font weight
const TextStyle bold = TextStyle(
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w700,
  fontSize: 18,
  color: AppColors.textColor,
);

// /// 800 font weight
// const TextStyle extraBold = TextStyle(
//   fontFamily: 'Comfortaa',
//   fontWeight: FontWeight.w800,
//   fontSize: 18,
//   color: AppColors.textColor,
// );
