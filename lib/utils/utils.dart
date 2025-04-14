import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../styles/styles.dart';
import '../widgets/ars_progress_dialog.dart';
import '../widgets/buttons.dart';

// For pretty printing
Logger _logger = Logger(
  printer: PrettyPrinter(),
);
void console(dynamic msg) {
  _logger.d(msg);
}

void warn(dynamic msg) {
  _logger.w(msg);
}

void error(dynamic msg) {
  _logger.e(msg);
}

Uint8List hexStringToUint8List(String hexString) {
  // Ensure that the hex string has an even length
  if (hexString.length % 2 != 0) {
    throw Exception('Hex string must have an even length');
  }

  final List<int> bytes = <int>[];
  for (int i = 0; i < hexString.length; i += 2) {
    final String hexPair = hexString.substring(i, i + 2);
    final int byte = int.parse(hexPair, radix: 16);
    bytes.add(byte);
  }

  return Uint8List.fromList(bytes);
}

// Regular expression for validating an phone number
bool isPhoneNumberValid(String number) {
  console(number);
  return RegExp(r'(^(?:[+0]9)?[0-9]{9,18}$)').hasMatch(
    number.replaceAll('+', ''),
  );
}

// Regular expression for validating an email address
bool isEmailValid(String email) {
  return RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(
    email.toLowerCase(),
  );
}

bool isWebsiteValid(String website) {
  return RegExp(
    r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$",
  ).hasMatch(
    website.toLowerCase(),
  );
}

bool isReferralCodeValid(String code) {
  return RegExp(r'^[0-9A-Z]{8}$').hasMatch(code);
}

Future<bool> launchURL(String url) async {
  if (!url.startsWith('http') && !url.startsWith('https')) {
    url = 'https://$url';
  }

  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    console('Launching $url');
    return launchUrl(
      uri,
      // mode: isWhatsApp ? LaunchMode.externalNonBrowserApplication : LaunchMode.inAppBrowserView,
    );
  } else {
    throw Exception('Could not launch $url');
  }
}

/// MM:SS
String printDurationInMins(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
}

/// HH:MM:SS
String printFullDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

/// HH:MM
String printDurationInHours(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
}

// For getting the size (width and height) of a text
Size getTextSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

Size getFixedTextSize(String text, TextStyle style, double width) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    // maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: 0, maxWidth: width);
  return textPainter.size;
}

// Shows a dialog box with a message
Future<void> showCustomDialog(
  BuildContext context, {
  required String title,
  required String description,
  VoidCallback? onPressed,
  bool dismissable = true,
  bool selectableText = false,
  String? buttonText,
  Color? buttonColor,
}) {
  return showGeneralDialog<void>(
    barrierLabel: 'Barrier',
    barrierDismissible: dismissable,
    barrierColor: AppColors.barrierColor,
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (ctx, __, ___) {
      return PopScope(
        canPop: dismissable,
        child: Align(
          child: Container(
            width: 318.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              top: 25.h,
              bottom: 25.h,
            ),
            child: Material(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: bold.copyWith(
                      fontSize: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (selectableText)
                    SelectableText(
                      description,
                      style: medium.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    )
                  else
                    Text(
                      description,
                      style: medium.copyWith(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(
                    height: 60.h,
                  ),
                  PrimaryButton(
                    width: double.infinity,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      if (onPressed != null) {
                        onPressed();
                      }
                    },
                    text: buttonText ?? 'Ok',
                    backgroundColor: buttonColor,
                    textStyle: bold.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showToast(String text) async {
  final fToast = FToast();
  fToast.init(navigatorKey.currentContext!);

  final toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check,
        ),
        SizedBox(
          width: 12.w,
        ),
        Text(
          text,
          style: regular.copyWith(
            color: Colors.black,
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  );

  await Fluttertoast.cancel();

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    positionedToastBuilder: (context, child) {
      return Positioned(
        top: 0.1.sh,
        child: SizedBox(
          width: 1.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              child,
            ],
          ),
        ),
      );
    },
    toastDuration: const Duration(seconds: 1),
  );
}

// Shows a dialog box with a message
Future<void> showDialogImage(
  BuildContext context, {
  required String title,
  required String image,
  String? description,
  String? primaryButtonText,
  VoidCallback? onPrimaryButtonTap,
}) {
  return showGeneralDialog(
    barrierLabel: 'Barrier',
    barrierColor: AppColors.barrierColor,
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (ctx, __, ___) {
      return Align(
        child: Stack(
          children: [
            Container(
              width: 326.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
              ),
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 22.h,
                bottom: 47.h,
              ),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      image,
                      height: 150.h,
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Text(
                      title,
                      style: bold.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (description != null) ...[
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: regular.copyWith(
                          fontSize: 16.sp,
                          height: 1,
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            child: Container(
                              width: 108.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1.w,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: regular.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          CupertinoButton(
                            onPressed: onPrimaryButtonTap,
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            child: Container(
                              width: 108.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.erroMessage,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.erroMessage,
                                  width: 1.w,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  primaryButtonText ?? 'Yes',
                                  style: regular.copyWith(
                                    fontSize: 16.sp,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ),
            if (description == null)
              Positioned(
                left: 20.w,
                top: 22.h,
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: SvgPicture.asset(
                    'assets/svg/cross.svg',
                    height: 20.h,
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}

ArsProgressDialog? _progressDialog;
void showLoadingIndicator(BuildContext context) {
  _progressDialog = ArsProgressDialog(
    context,
    dismissable: false,
    blur: 2,
    backgroundColor: const Color(0x33000000),
    animationDuration: const Duration(milliseconds: 200),
    loadingWidget: Container(
      padding: const EdgeInsets.all(10.0),
      height: 100.0,
      width: 100.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
      ),
    ),
  );
  _progressDialog!.show();
}

void hideLoadingIndicator([bool rootNavigator = false]) {
  _progressDialog?.dismiss(rootNavigator);
}

// Future<XFile?> pickImage(BuildContext context) async {
//   return await showModalBottomSheet<XFile?>(
//     backgroundColor: Colors.white,
//     useRootNavigator: true,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(24.r),
//         topRight: Radius.circular(24.r),
//       ),
//     ),
//     builder: (BuildContext ctx) {
//       return SizedBox(
//         width: 1.sw,
//         child: Padding(
//           padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 27.h,
//               ),
//               Row(
//                 children: [
//                   const Spacer(),
//                   CupertinoButton(
//                     padding: EdgeInsets.zero,
//                     minSize: 0,
//                     onPressed: () {
//                       Navigator.pop(ctx);
//                     },
//                     child: SvgPicture.asset(
//                       'assets/svg/close.svg',
//                       width: 12.w,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 19.w,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 13.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     'assets/svg/gallery.svg',
//                     width: 25.w,
//                   ),
//                   SizedBox(
//                     width: 13.w,
//                   ),
//                   Text(
//                     'Go To Your Gallery',
//                     style: regular.copyWith(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 22.h,
//               ),
//               PrimaryButton(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20.w,
//                 ),
//                 text: 'Continue',
//                 onPressed: () async {
//                   final pickedFile = await ImagePicker().pickImage(
//                     source: ImageSource.gallery,
//                     imageQuality: 75,
//                   );
//                   if (!ctx.mounted) return;

//                   Navigator.of(ctx).pop(pickedFile);
//                 },
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

// // Shows a dialog box with a message
// void showChangePasswordDialog(
//   BuildContext context, {
//   Future<String> Function(String currentPassword, String newPassword)? onPressed,
//   bool dismissable = false,
// }) {
//   final currentPasswordController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   bool isLoading = false;
//   showGeneralDialog(
//     useRootNavigator: true,
//     barrierLabel: "Barrier",
//     barrierDismissible: dismissable,
//     barrierColor: AppColors.barrierColor,
//     transitionDuration: const Duration(milliseconds: 300),
//     context: context,
//     pageBuilder: (ctx, __, ___) {
//       return StatefulBuilder(builder: (context, setState) {
//         return Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             margin: EdgeInsets.only(
//               top: ScreenUtil().statusBarHeight + 70.h,
//               left: 15.w,
//               right: 15.w,
//             ),
//             width: 1.sw,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             padding: EdgeInsets.only(
//               left: 20.w,
//               right: 20.w,
//               top: 24.h,
//               bottom: 24.h,
//             ),
//             child: Material(
//               color: Colors.white,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'Change Password',
//                     style: bold.copyWith(
//                       fontSize: 18,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   CustomTextField(
//                     controller: currentPasswordController,
//                     hasNextTextField: true,
//                     obscureText: true,
//                     onChange: (val) {
//                       setState(() {});
//                     },
//                     hintText: 'Type Current Password...',
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   CustomTextField(
//                     hintText: 'New Password...',
//                     controller: newPasswordController,
//                     hasNextTextField: true,
//                     obscureText: true,
//                     onChange: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   SizedBox(
//                     height: 9.h,
//                   ),
//                   CustomTextField(
//                     hintText: 'Retype Your New Password...',
//                     controller: confirmPasswordController,
//                     obscureText: true,
//                     onChange: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   SizedBox(
//                     height: 14.h,
//                   ),
//                   Text(
//                     newPasswordController.text.isEmpty
//                         ? 'Enter new password'
//                         : newPasswordController.text.length < 8
//                             ? 'Password must be at least 8 characters'
//                             : 'Your new password is good!',
//                     style: medium.copyWith(
//                       fontSize: 14,
//                       color: newPasswordController.text.isEmpty
//                           ? AppColors.textColor
//                           : newPasswordController.text.length < 8
//                               ? Colors.red
//                               : AppColors.greenColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 16.h,
//                   ),
//                   SecondaryButton(
//                     text: 'Cancel',
//                     internalPadding: EdgeInsets.symmetric(vertical: 17.h),
//                     width: double.infinity,
//                     borderColor: AppColors.primaryColor,
//                     borderRadius: 28.r,
//                     textStyle: semiBold.copyWith(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context, rootNavigator: true).pop();
//                     },
//                   ),
//                   SizedBox(
//                     height: 8.h,
//                   ),
//                   PrimaryButton(
//                     isLoading: isLoading,
//                     onPressed: () async {
//                       final currentPassword = currentPasswordController.text;
//                       final newPassword = newPasswordController.text;
//                       final confirmPassword = confirmPasswordController.text;

//                       if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
//                         showCustomDialog(
//                           context,
//                           title: 'Error',
//                           description: 'Please fill all the fields',
//                         );
//                         return;
//                       } else if (newPassword != confirmPassword) {
//                         showCustomDialog(
//                           context,
//                           title: 'Error',
//                           description: 'New password and confirm password do not match',
//                         );
//                         return;
//                       } else if (newPassword.length < 8) {
//                         showCustomDialog(
//                           context,
//                           title: 'Error',
//                           description: 'New Password must be at least 8 characters',
//                         );
//                         return;
//                       }

//                       if (onPressed != null) {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         final res = await onPressed(currentPassword, newPassword);
//                         if (res == 'ok') {
//                           if (!context.mounted) return;
//                           Navigator.of(context, rootNavigator: true).pop();
//                           Future.delayed(
//                             const Duration(milliseconds: 500),
//                             () {
//                               showCustomDialog(
//                                 context,
//                                 title: 'Success',
//                                 description: 'Password changed successfully',
//                               );
//                             },
//                           );
//                         } else {
//                           setState(() {
//                             isLoading = false;
//                           });
//                           if (!context.mounted) return;
//                           showCustomDialog(
//                             context,
//                             title: 'Error',
//                             description: res,
//                           );
//                         }
//                       }
//                     },
//                     text: 'Submit',
//                     backgroundColor: AppColors.primaryColor,
//                     textStyle: bold.copyWith(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
//     },
//   );
// }

// iOS like scroll physics accross all platforms
class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();
}
