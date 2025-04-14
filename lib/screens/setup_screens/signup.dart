import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_action/slide_action.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/signup_controller.dart';
import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/buttons.dart';
import '../../widgets/textfield.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const String route = '/signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double _thumbFractionalPosition = 0.0;

  late AuthController authController;
  late SignupController signupController;

  @override
  void initState() {
    super.initState();
    authController = AuthController.instance;
    signupController = SignupController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().statusBarHeight + 20.h,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20.w,
                  ),
                  AppBackButton(
                    context: context,
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Text(
                'Type In Your Username &\nSecret Password\nTo continue (๑ > ᴗ < ๑)',
                textAlign: TextAlign.center,
                style: bold.copyWith(
                  height: 1,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email',
                      style: medium.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      hintText: 'Enter your email',
                      prefixIcon: 'assets/svg/email.svg',
                      controller: signupController.emailController,
                      hasNextTextField: true,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'Username',
                      style: medium.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      hintText: 'Enter your username',
                      controller: signupController.usernameController,
                      prefixIcon: 'assets/svg/person.svg',
                      hasNextTextField: true,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      'Password',
                      style: medium.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      hintText: 'Enter your password',
                      controller: signupController.passwordController,
                      prefixIcon: 'assets/svg/key.svg',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Login.route);
                      },
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: Text(
                        'already have an account?',
                        style: bold.copyWith(
                          fontSize: 13.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: SlideAction(
                        stretchThumb: true,
                        trackHeight: 66.h,
                        trackBuilder: (BuildContext context,
                            SlideActionStateMixin state) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: Colors.white,
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 10.w,
                                ),
                                const Spacer(),
                                Center(
                                  child: Text(
                                    'Continue',
                                    style: bold.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          );
                        },
                        thumbBuilder: (BuildContext context,
                            SlideActionStateMixin state) {
                          if (_thumbFractionalPosition !=
                              state.thumbFractionalPosition) {
                            _thumbFractionalPosition =
                                state.thumbFractionalPosition;
                          }

                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation<double>(
                                  state.thumbFractionalPosition),
                              child: SvgPicture.asset(
                                'assets/svg/arrowRight.svg',
                                width: 50.w,
                              ),
                            ),
                          );
                        },
                        action: () {
                          // Navigator.of(context).pushNamed(AddWidget.route);

                          // show a snackbar

                          showCustomDialog(
                            context,
                            title: 'Error',
                            description: 'Sign up failed',
                          );

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //       'Sign up successful',
                          //       style: medium.copyWith(
                          //         fontSize: 14.sp,
                          //       ),
                          //     ),
                          //     backgroundColor: AppColors.secondaryPinkColor,
                          //     behavior: SnackBarBehavior.floating,
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
