import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';
import '../../widgets/textfield.dart';
import 'friends.dart';
import 'home.dart';

class TimeCapsualLock extends StatefulWidget {
  const TimeCapsualLock({super.key});

  static const String route = '/timecapsual_Lock';

  @override
  State<TimeCapsualLock> createState() => _TimeCapsualLockState();
}

class _TimeCapsualLockState extends State<TimeCapsualLock> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? message;

  Future<void> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: DateTime(now.year + 100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
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
            'Time To Lock Your Memories For Special Days',
            textAlign: TextAlign.center,
            style: bold.copyWith(
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 600.h,
            width: 346.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              border: Border.all(
                color: AppColors.borderColor,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Friends',
                  textAlign: TextAlign.left,
                  style: medium.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // const CustomTextField(
                //   hintText: 'Select the friend',
                //   hasNextTextField: true,
                //   prefixIcon: 'assets/svg/person.svg',
                // ),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      gapPadding: 0,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(8.r),
                      isDense: true,
                      isExpanded: true,
                      hint: Row(
                        children: [
                          SizedBox(
                            width: 4.w,
                          ),
                          SvgPicture.asset(
                            'assets/svg/person.svg',
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Select Your Friend',
                            style: regular.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ],
                      ),
                      icon: Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: SvgPicture.asset(
                          'assets/svg/arrowDown.svg',
                        ),
                      ),
                      itemHeight: 80.h,
                      padding: EdgeInsets.zero,
                      items: <String>['A', 'B', 'C', 'D'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Friendwidget(
                            margin: EdgeInsets.zero,
                          ),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'Unlock Date',
                  style: medium.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CupertinoButton(
                  onPressed: () => selectDate(context),
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 13.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.textFieldBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/calender.svg',
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          selectedDate == null
                              ? 'Select a date'
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: regular.copyWith(
                            fontSize: 16.sp,
                            color: selectedDate == null ? AppColors.hintTextColor : AppColors.textColor,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/svg/arrowDown.svg',
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'Unlock Time',
                  style: medium.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CupertinoButton(
                  onPressed: () => selectTime(context),
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 13.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.textFieldBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/clock.png',
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          selectedTime == null ? 'Select a time' : selectedTime!.format(context),
                          style: regular.copyWith(
                            fontSize: 16.sp,
                            color: selectedTime == null ? AppColors.hintTextColor : AppColors.textColor,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/svg/arrowDown.svg',
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'Add a Message (Optional)',
                  style: medium.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const CustomTextField(
                  hintText: 'Type your message',
                  hasNextTextField: true,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(children: [
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: bold.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {
                      showToast('Memory Locked');
                      Navigator.of(context).pushNamedAndRemoveUntil(Home.route, (_) => false);
                    },
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryPinkColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Lock', // TODO: make this txt color black?
                        style: bold.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ]),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
