import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/styles.dart';
import '../utils/utils.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.onLongPress,
    this.width,
    this.padding,
    this.internalPadding,
    this.backgroundColor,
    this.isLoading = false,
    this.disabled = false,
    this.textStyle,
    this.borderRadius,
    this.icon,
    this.borderColor,
  });
  final String text;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? internalPadding;
  final bool isLoading;
  final bool disabled;
  final TextStyle? textStyle;
  final String? icon;
  final double? borderRadius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? 30.r;

    final textHeight = getTextSize(
      text,
      textStyle ??
          bold.copyWith(
            fontSize: 14,
            letterSpacing: -0.24,
            color: Colors.white,
          ),
    ).height;
    return SizedBox(
      width: width ?? double.infinity,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: disabled ? Colors.grey : backgroundColor ?? AppColors.primaryColor,
            padding: internalPadding ??
                EdgeInsets.symmetric(
                  vertical: icon != null ? 17.h : 17.h,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onLongPress: isLoading || disabled ? null : onLongPress,
          onPressed: isLoading || disabled ? null : onPressed,
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: textHeight,
                    width: textHeight,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          icon!,
                          height: 38.h,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          text,
                          style: textStyle ??
                              bold.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    )
                  : FittedBox(
                      child: Text(
                        text,
                        style: textStyle ??
                            bold.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                      ),
                    ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.padding,
    this.internalPadding,
    this.icon,
    this.svgIcon,
    this.sysIcon,
    this.sysIconSize,
    this.sysIconColor,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.outlined = true,
    this.borderRadius,
    this.borderWidth,
    this.disabled = false,
  });
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? sysIconColor;
  final EdgeInsets? padding;
  final EdgeInsets? internalPadding;
  final bool outlined;
  final TextStyle? textStyle;
  final String? icon;
  final String? svgIcon;
  final IconData? sysIcon;
  final double? sysIconSize;
  final double? borderRadius;
  final bool disabled;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    // final borderRadius = 32.r;

    return SizedBox(
      width: width,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: disabled ? AppColors.lightGreyColor : backgroundColor ?? Colors.transparent,
            padding: internalPadding ??
                EdgeInsets.symmetric(
                  vertical: 12.h,
                ),
            shape: RoundedRectangleBorder(
              side: outlined
                  ? BorderSide(
                      color: backgroundColor ?? borderColor ?? AppColors.borderColor,
                      width: borderWidth ?? 1.w,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: disabled ? null : onPressed,
          child: svgIcon != null || icon != null || sysIcon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    sysIcon != null
                        ? Icon(
                            sysIcon,
                            color: sysIconColor ?? AppColors.primaryColor,
                            size: sysIconSize ?? 32.h,
                          )
                        : svgIcon != null
                            ? SvgPicture.asset(
                                svgIcon!,
                                height: 32.h,
                              )
                            : Image.asset(
                                icon!,
                                height: 32.h,
                              ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      text,
                      style: textStyle ??
                          medium.copyWith(
                            fontSize: 16,
                            color: AppColors.lightTextColor,
                          ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: textStyle ??
                      medium.copyWith(
                        fontSize: 16,
                        color: AppColors.lightTextColor,
                      ),
                ),
        ),
      ),
    );
  }
}

// ! TODO: Use that flutter gen thingy for assets?
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, required this.context, this.onPressed});

  final BuildContext context;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset(
              'assets/svg/arrowRight.svg',
              height: 50.h,
            ),
          ),
        ),
      ),
    );
  }
}
