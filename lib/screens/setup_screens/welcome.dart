import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:slide_action/slide_action.dart';

import '../../controllers/auth_controller.dart';
import '../../providers/user_provider.dart';
import '../../styles/styles.dart';
import '../../widgets/valuelistenablebuilder2.dart';
import '../homescreen_main/home.dart';
import '../../controllers/welcome_controller.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  static const String route = '/welcome';

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late AuthController authController;
  late WelcomeController welcomeController;

  @override
  void initState() {
    super.initState();
    authController = AuthController.instance;
    welcomeController = WelcomeController();

    if (!authController.isLoggedIn) {
      FlutterNativeSplash.remove();
    } else {
      authController.fetchUserProfile().then((_) {
        if (authController.currentUser != null) {
          // check if friends are added or not
          // Navigator.of(context).pushNamed(AddWidget.route);

          // ! Notes:
          // * mounted is used because the widget could be disposed before the Future completes
          // * and then context becomes null
          if (!mounted) return;

          Navigator.of(context).pushNamedAndRemoveUntil(
              Home.route, (Route<dynamic> route) => false);
        } else {
          FlutterNativeSplash.remove();
        }
      });
    }
  }

  @override
  void dispose() {
    welcomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().statusBarHeight + 80.h,
            ),
            // TODO: Make this animate smoother
            ValueListenableBuilder2(
                first: welcomeController.currentSanrioImage,
                second: welcomeController.thumbFractionalPosition,
                builder: (context, sanrioImage, position, _) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    transform: position > 0
                        ? Matrix4.translationValues(position * 0.5.sw, 0, 0)
                        : Matrix4.rotationZ(
                            welcomeController.index.isEven ? -0.01 : 0.01,
                          ),
                    transformAlignment: Alignment.center,
                    child: Image.asset(
                      sanrioImage,
                      width: 200.w,
                      key: ValueKey<int>(welcomeController.index),
                    ),
                  );
                }),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Ember - Embracing Wholesome Connections',
                style: bold.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Connection with your loved ones made easy',
                style: medium.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 39.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SlideAction(
                stretchThumb: true,
                trackHeight: 66.h,
                trackBuilder:
                    (BuildContext context, SlideActionStateMixin state) {
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
                          width: 50.w,
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            'Swipe To Set Up Your Ember',
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
                thumbBuilder:
                    (BuildContext context, SlideActionStateMixin state) {
                  if (welcomeController.thumbFractionalPositionValue !=
                      state.thumbFractionalPosition) {
                    /// WidgetsBinding used becahse the thumbFractionalPositionValue is set after the build method is called
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      welcomeController.thumbFractionalPositionValue =
                          state.thumbFractionalPosition;
                    });
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
                  welcomeController.onContinue(context);
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().bottomBarHeight + 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
