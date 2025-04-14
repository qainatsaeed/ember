import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';
import '../../widgets/buttons.dart';
import '../../widgets/textfield.dart';

class EditUserDeets extends StatefulWidget {
  const EditUserDeets({super.key});

  static const String route = '/EditUserDeets';

  @override
  State<EditUserDeets> createState() => _EditUserDeetsState();
}

class _EditUserDeetsState extends State<EditUserDeets> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();

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
                  'Edit User Deets',
                  style: bold.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
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
                        'UserName',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CustomTextField(
                        text: 'Qainat',
                        hintText: 'UserName',
                        prefixIcon: 'assets/svg/person.svg',
                        controller: userNameController,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Password',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      const CustomTextField(
                        hintText: '***********',
                        prefixIcon: 'assets/svg/key.svg',
                        obscureText: true,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'Email',
                        style: medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CustomTextField(
                        text: 'qainat@gmail.com',
                        hintText: 'Email',
                        prefixIcon: 'assets/svg/email.svg',
                        readOnly: true,
                        controller: emailController,
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
