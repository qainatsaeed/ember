import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/textfield.dart';
import 'home.dart';

class TimecapsualOpen extends StatefulWidget {
  const TimecapsualOpen({super.key});

  static const String route = '/timecapsual_open';

  @override
  State<TimecapsualOpen> createState() => _TimecapsualOpenState();
}

class _TimecapsualOpenState extends State<TimecapsualOpen> {
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
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
              ),
              Text(
                'TODAY IS THE DAY!',
                textAlign: TextAlign.center,
                style: bold.copyWith(
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Friend Hafsa wants to share this with you today',
                  textAlign: TextAlign.center,
                  style: bold.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h), // Padding around the text
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor), // Border color and width
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the border
                ),
                child: Text(
                  '13-11-2024  12:00 pm',
                  textAlign: TextAlign.center,
                  style: bold.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 54.h,
              ),
              Container(
                height: 262.h,
                width: 304.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                //add picture in this container
              ),
              SizedBox(
                height: 20.h,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 0.6.sw,
                    child: Text(
                      'Happy Birthday Qainat <3',
                      textAlign: TextAlign.center,
                      style: bold.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -1 * ((281 / 512) * 100.h + 10.w),
                    top: 10.h,
                    child: Image.asset(
                      'assets/images/arrow.png',
                      height: 100.h,
                    ),
                  ),
                ],
              ),
              // const Spacer(),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: (1.sw - 304.w) / 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reply To Hafsa',
                        style: bold.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      SizedBox(
                        width: 304.w,
                        child: CustomTextField(
                          hintText: 'Type Something..',
                          onSubmit: (text) {
                            console('Submitted: $text');
                            showToast('Reply sent');
                            Navigator.of(context).pushNamedAndRemoveUntil(Home.route, (_) => false);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().bottomBarHeight + 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
