import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_action/slide_action.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/buttons.dart';
import '../../widgets/textfield.dart';
import '../homescreen_main/home.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});
  static const String route = '/AddFriends';

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  double _thumbFractionalPosition = 0.0;
  final SearchController searchController = SearchController();
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
                AppBackButton(
                  context: context,
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            Text(
              'Add Your Friends!',
              textAlign: TextAlign.center,
              style: bold.copyWith(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 400.h,
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.boxBorderColor,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: CustomTextField(
                      hintText: 'Search Friends',
                      hintStyle: regular.copyWith(
                        fontSize: 16,
                        color: AppColors.hintTextColor,
                      ),
                      textStyle: regular.copyWith(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                      controller: searchController,
                      prefixIcon: 'assets/svg/search.svg',
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
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
                          'Qainat Saeed',
                          style: bold.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                        const Spacer(),
                        CupertinoButton(
                          onPressed: () {
                            showToast('Friend added');
                          },
                          minSize: 0,
                          padding: EdgeInsets.zero,
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
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  Navigator.of(context).pushNamed(Home.route);
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
