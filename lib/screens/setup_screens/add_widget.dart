import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_action/slide_action.dart';

import '../../styles/styles.dart';
import 'add_friends.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({super.key});

  static const String route = '/AddWidget';

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  double _thumbFractionalPosition = 0.0;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) {
        return;
      }
      showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Have you enabled the widget?'),
          content: const Text('Ember doesnt work unless you add it to your home screen'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: const Text('Yes'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    });
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
              height: ScreenUtil().statusBarHeight + 40.h,
            ),
            Text(
              'Finally Add Ember To Your\nHome Screen as a Widget',
              style: bold.copyWith(
                fontSize: 20.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 45.h,
            ),
            Image.asset(
              'assets/images/frame.png',
              width: 220.w,
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Search for Ember and add\nthe Widget Easy Peasy!',
              style: bold.copyWith(
                fontSize: 18.sp,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24.h,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                          width: 50.w,
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            'Enabled Ember as a Widget',
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
                  Navigator.of(context).pushNamed(AddFriends.route);
                },
              ),
            ),
            SizedBox(
              height: ScreenUtil().bottomBarHeight + 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
