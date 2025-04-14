import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/buttons.dart';
import 'edit_user_deets.dart';
import 'friends.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  static const route = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool notificationsEnabled = true;

  Future<void> showMyFriendsList() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 0.6.sh,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'My Friends',
                      style: bold.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Friendwidget(
                        showRightArrow: true,
                        margin: EdgeInsets.only(bottom: 10.h),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: ScreenUtil().statusBarHeight + 10.h,
                ),
                Text(
                  'My Profile',
                  style: bold.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CupertinoButton(
                  onPressed: () => pickImage(context),
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: Container(
                    height: 110.h,
                    width: 110.h,
                    decoration: BoxDecoration(
                      color: AppColors.cameraColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'QS',
                        style: bold.copyWith(
                          fontSize: 26.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Qainat',
                  style: medium.copyWith(fontSize: 18.sp),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 21.h,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 18.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Profile',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(EditUserDeets.route);
                        },
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.boxBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/edit.svg',
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Text(
                                'Edit User Deets',
                                style: regular.copyWith(
                                  fontSize: 15.sp,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.chevron_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Edit Profile',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          setState(() {
                            notificationsEnabled = !notificationsEnabled;
                          });
                        },
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.boxBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              FlutterSwitch(
                                width: 34.w,
                                height: 18.h,
                                toggleSize: 15.h,
                                value: notificationsEnabled,
                                borderRadius: 30.0,
                                padding: 2,
                                inactiveColor: AppColors.white,
                                activeColor: AppColors.white,
                                switchBorder: Border.all(
                                  width: 1.5,
                                ),
                                toggleBorder: Border.all(
                                  width: 1.5,
                                ),
                                onToggle: (val) {
                                  setState(() {
                                    notificationsEnabled = val;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Text(
                                'Notifications Enabled',
                                style: regular.copyWith(
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Block/Remove Friends',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CupertinoButton(
                        onPressed: showMyFriendsList,
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.boxBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/cancel.svg',
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Text(
                                '3 Friends ',
                                style: regular.copyWith(
                                  fontSize: 15.sp,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.chevron_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Delete Account',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.erroMessage,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          showDialogImage(
                            context,
                            title: 'Are You Sure?',
                            image: 'assets/images/delete_account.png',
                            primaryButtonText: 'Delete',
                            description: 'This Action can not be undone',
                            onPrimaryButtonTap: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.boxBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.delete,
                                color: AppColors.erroMessage,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Text(
                                'Delete Account',
                                style: regular.copyWith(
                                  fontSize: 15.sp,
                                  color: AppColors.erroMessage,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.chevron_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Sign Out',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          showDialogImage(
                            context,
                            title: 'Are You Sure?',
                            image: 'assets/images/logout.png',
                            primaryButtonText: 'Sign out',
                            description: 'This Action can not be undone',
                            onPrimaryButtonTap: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.boxBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/bye.png',
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Text(
                                'Sign Out',
                                style: regular.copyWith(
                                  fontSize: 15.sp,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.chevron_forward,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: ScreenUtil().statusBarHeight + 10.h,
              left: 20.w,
              child: AppBackButton(
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void pickImage(BuildContext context) {
  showModalBottomSheet<void>(
    // backgroundColor: Colors.grey[900],
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().bottomBarHeight, top: 20.h),
        child: Wrap(
          children: <Widget>[
            Center(
              child: Text(
                'Set a Profile Picture like cool Kids',
                style: regular.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Camera',
                style: regular.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              onTap: () async {
                // final pickedFile = await ImagePicker().pickImage(
                //   source: ImageSource.camera,
                //   preferredCameraDevice: CameraDevice.front,
                //   imageQuality: 75,
                // );

                // Navigator.pop(context, pickedFile);

                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.collections,
                color: AppColors.primaryColor,
              ),
              title: Text(
                'Gallery',
                style: regular.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              onTap: () async {
                // final pickedFile = await ImagePicker().pickImage(
                //   source: ImageSource.gallery,
                //   preferredCameraDevice: CameraDevice.rear,
                //   imageQuality: 75,
                // );

                // Navigator.pop(context, pickedFile);

                Navigator.of(context).pop();
              },
            ),
            const Divider(),
          ],
        ),
      );
    },
  );
}
