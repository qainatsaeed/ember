import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});
  static const String route = '/Friends';

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
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
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 338.h,
              width: 352.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Text(
                    'My Friends',
                    textAlign: TextAlign.center,
                    style: bold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 256.h,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Friendwidget(),
                        Friendwidget(),
                        Friendwidget(),
                        Friendwidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 338.h,
              width: 352.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Text(
                    'Search Up Friends With Username',
                    textAlign: TextAlign.center,
                    style: bold.copyWith(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 250.h,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        AddFriendWidget(),
                        AddFriendWidget(),
                        AddFriendWidget(),
                        AddFriendWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddFriendWidget extends StatelessWidget {
  const AddFriendWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 13.h,
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 47.h,
            width: 47.w,
            decoration: BoxDecoration(
              color: AppColors.profileIconBgColor,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                color: AppColors.primaryColor,
              ),
            ),
            child: Center(
              child: Text(
                'QS',
                style: bold.copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            'Friend 1',
            style: regular.copyWith(
              fontSize: 16.sp,
            ),
          ),
          const Spacer(),
          CupertinoButton(
            onPressed: () {
              showToast('Friend Added');
            },
            padding: EdgeInsets.zero,
            minSize: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.secondaryPinkColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '+ Add',
                style: bold.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Friendwidget extends StatelessWidget {
  const Friendwidget({
    super.key,
    this.margin,
    this.showRightArrow = false,
  });

  final EdgeInsets? margin;
  final bool showRightArrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.boxBorderColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.5.h,
      ),
      margin: margin ??
          EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 6.h,
          ),
      child: Row(
        children: <Widget>[
          Container(
            height: 47.h,
            width: 47.w,
            decoration: BoxDecoration(
              color: AppColors.profileIconBgColor,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(
                color: AppColors.primaryColor,
              ),
            ),
            child: Center(
              child: Text(
                'QS',
                style: bold.copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 13.w,
          ),
          Text(
            'Friend 1',
            style: regular.copyWith(
              fontSize: 16.sp,
            ),
          ),
          const Spacer(),
          if (showRightArrow)
            Icon(
              Icons.arrow_forward_ios,
              size: 20.w,
            ),
        ],
      ),
    );
  }
}
