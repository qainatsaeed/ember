import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_action/slide_action.dart';

import '../../styles/styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const String route = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  double _thumbFractionalPosition = 0.0;

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
                'Login To Your Existing Account',
                textAlign: TextAlign.center,
                style: bold.copyWith(
                  height: 1,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 50.h,
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
                      controller: _emailController,
                      hasNextTextField: true,
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: 'assets/svg/person.svg',
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
                      controller: _passwordController,
                      obscureText: true,
                      prefixIcon: 'assets/svg/key.svg',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: SlideAction(
                        stretchThumb: true,
                        trackHeight: 66.h,
                        trackBuilder: (BuildContext context, SlideActionStateMixin state) {
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
                                    'Login',
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
                        thumbBuilder: (BuildContext context, SlideActionStateMixin state) {
                          if (_thumbFractionalPosition != state.thumbFractionalPosition) {
                            _thumbFractionalPosition = state.thumbFractionalPosition;
                          }

                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation<double>(state.thumbFractionalPosition),
                              child: SvgPicture.asset(
                                'assets/svg/arrowRight.svg',
                                width: 50.w,
                              ),
                            ),
                          );
                        },
                        action: () {
                          // Navigator.of(context).pushNamed(AddWidget.route);
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
