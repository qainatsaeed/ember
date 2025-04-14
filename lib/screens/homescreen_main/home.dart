import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../styles/styles.dart';
import '../../utils/utils.dart';
import 'friends.dart';
import 'timecapsual_lock.dart';

enum CameraType {
  front,
  back,
}

class Home extends StatefulWidget {
  const Home({super.key});
  static const String route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CameraController? controller;
  late List<CameraDescription> cameras;
  CameraType currentCameraType = CameraType.back;
  String currCameraName = '';
  bool picTaken = false;

  @override
  void initState() {
    super.initState();

    availableCameras().then((List<CameraDescription> cameras) {
      this.cameras = cameras;

      if (cameras.isEmpty) {
        console('No camera found');
        return;
      }

      CameraDescription backCamera = cameras[0];

      console('Camera: ${backCamera.name}');

      if (backCamera.lensDirection != CameraLensDirection.back) {
        backCamera = cameras.firstWhere((CameraDescription camera) => camera.lensDirection == CameraLensDirection.back,
            orElse: () {
          currentCameraType = CameraType.front;
          return cameras.first;
        });
      }

      currCameraName = backCamera.name;

      controller = CameraController(
        backCamera,
        ResolutionPreset.max,
        enableAudio: false,
      );

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              console('The user did not grant the camera permission!');
              // Handle access errors here.
              break;
            default:
              console('Error: ${e.code}');
              // Handle other errors here.
              break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> addCaption() async {
    showMaterialModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 1.sh * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20.w,
                  ),
                  const Spacer(),
                  Text(
                    'Add a Caption',
                    style: bold.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    child: SvgPicture.asset(
                      'assets/svg/cross.svg',
                      height: 20.h,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              CaptionWidget(
                text: 'Morning Fam <3',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CaptionWidget(
                text: 'Rise and shine',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CaptionWidget(
                text: 'Sun’s up, coffee’s brewing ☕',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CaptionWidget(
                text: 'Here’s to a lazy morning 😴',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CaptionWidget(
                text: 'Chill Day ',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CaptionWidget(
                text: 'Bedtime here 🌙 😴',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              CupertinoTextField(
                placeholder: 'Write a caption to add in dictionary',
                placeholderStyle: regular.copyWith(
                  color: AppColors.hintTextColor,
                ),
                style: regular.copyWith(
                  color: AppColors.textColor,
                ),
                decoration: BoxDecoration(
                  color: AppColors.progressBgColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                minLines: 2,
                maxLines: 2,
              ),
              SizedBox(
                height: 20.h,
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                minSize: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Add',
                    style: bold.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.progressBgColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> switchCamera() async {
    CameraDescription newCamera;

    if (currentCameraType == CameraType.back) {
      newCamera = cameras.firstWhere((CameraDescription camera) => camera.lensDirection == CameraLensDirection.front);
      currentCameraType = CameraType.front;
    } else {
      newCamera = cameras.firstWhere((CameraDescription camera) => camera.lensDirection == CameraLensDirection.back);
      currentCameraType = CameraType.back;
    }

    final CameraController newController = CameraController(
      newCamera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    currCameraName = newCamera.name;

    await controller!.dispose();
    controller = newController;

    await controller!.initialize();
    setState(() {});
  }

  Future<void> takePicture() async {
    if (picTaken) {
      // showDialogImage<void>(
      //   context,
      //   title: 'Ember Sent Successfully!',
      //   image: 'assets/images/sent_ember.png',
      // );
      // return;

      showToast('Ember Sent Successfully!');
      return;
    }

    setState(() {
      picTaken = true;
    });

    return;
    try {
      final XFile file = await controller!.takePicture();
      console('File path: ${file.path}');
    } catch (e) {
      console('Error: $e');
    }
  }

  Future<void> togleFlash() async {
    final bool hasFlash = controller!.value.flashMode == FlashMode.off;
    final FlashMode flashMode = hasFlash ? FlashMode.torch : FlashMode.off;

    await controller!.setFlashMode(flashMode);
  }

  void closePicTaken() {
    setState(() {
      picTaken = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().statusBarHeight + 20.h,
              ),
              if (picTaken)
                Row(
                  children: [
                    SizedBox(
                      width: 44.w,
                    ),
                    const Spacer(),
                    Text(
                      'Send To',
                      style: bold.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/pills.png',
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                )
              else
                Row(
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(TimeCapsualLock.route);
                      },
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: SvgPicture.asset(
                        'assets/svg/profile.svg',
                        height: 25.h,
                      ),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Friends.route);
                      },
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 9.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/svg/Add Account.svg',
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              '5 Friends',
                              style: bold.copyWith(
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/svg/location.svg',
                      height: 25.h,
                    ),
                  ],
                ),
              SizedBox(
                height: 65.h,
              ),
              Stack(
                children: [
                  Container(
                    height: 360.h,
                    width: 360.h,
                    decoration: BoxDecoration(
                      color: AppColors.cameraColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: (controller?.value.isInitialized ?? false)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: CameraPreview(
                              controller!,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  if (picTaken || true)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: CupertinoButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Friends.route);
                            },
                            padding: EdgeInsets.zero,
                            minSize: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 9.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: Text(
                                'Add a Caption',
                                style: bold.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              // const Spacer(),

              if (picTaken)
                SizedBox(
                  height: 40.h,
                )
              else
                const Spacer(),
              Row(
                children: <Widget>[
                  CupertinoButton(
                    onPressed: picTaken ? closePicTaken : togleFlash,
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    child: picTaken
                        ? SvgPicture.asset(
                            'assets/svg/cross.svg',
                            height: 30.h,
                          )
                        : Image.asset(
                            'assets/images/flash.png',
                            height: 45.h,
                          ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: takePicture,
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    child: Container(
                      height: 68.h,
                      width: 68.w,
                      decoration: BoxDecoration(
                        color: AppColors.cameraColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2.w,
                        ),
                      ),
                      child: picTaken
                          ? Center(
                              child: SvgPicture.asset(
                                'assets/svg/send.svg',
                                height: 29.h,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: picTaken ? addCaption : switchCamera,
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    child: Image.asset(
                      picTaken ? 'assets/images/text.png' : 'assets/images/switch_camera.png',
                      height: 45.h,
                    ),
                  ),
                ],
              ),
              if (picTaken)
                SizedBox(
                  height: 36.h,
                ),
              if (picTaken)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SendOption(
                      isSelected: true,
                      isAll: true,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    const SendOption(
                      name: 'hafsa',
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    const SendOption(
                      name: 'hafsa',
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    const SendOption(
                      name: 'hafsa',
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    const SendOption(
                      name: 'hafsa',
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    const SendOption(
                      name: 'hafsa',
                    ),
                  ],
                ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CaptionWidget extends StatelessWidget {
  const CaptionWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      minSize: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15.w,
            ),
            Text(
              text,
              style: regular.copyWith(
                fontSize: 16.sp,
              ),
            ),
            const Spacer(),
            CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              minSize: 0,
              child: Icon(
                CupertinoIcons.delete,
                color: Colors.red[900],
                size: 18.w,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
          ],
        ),
      ),
    );
  }
}

class SendOption extends StatelessWidget {
  const SendOption({
    super.key,
    this.isSelected = false,
    this.isAll = false,
    this.name = '',
    this.onTap,
  });

  final bool isSelected;
  final bool isAll;
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    assert(isAll || name.isNotEmpty, 'Name cannot be empty if isAll is false');

    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.h,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.cameraColor,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: AppColors.primaryColor,
                      width: 2.w,
                    )
                  : null,
            ),
            child: Center(
              child: isAll
                  ? Image.asset(
                      'assets/images/all.png',
                      height: 28.h,
                    )
                  : SvgPicture.asset(
                      'assets/svg/profile.svg',
                      height: 18.h,
                    ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            isAll ? 'All' : name,
            style: bold.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
