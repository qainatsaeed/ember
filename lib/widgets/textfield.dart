import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.textInputType,
    this.controller,
    this.focusNode,
    this.textCapitalization,
    this.numOfWords,
    this.hasNextTextField = false,
    this.hideBorder = false,
    this.maxAllowedWords,
    this.isThreeWordsTextField = false,
    this.isLinesTextField = false,
    this.maxLines = 1,
    this.maxLinesForFormatter = 5,
    this.minLines,
    this.hintStyle,
    this.textStyle,
    this.textAlign,
    this.maxLength,
    this.textColor,
    this.textInputAction,
    this.padding,
    this.onChange,
    this.readOnly = false,
    this.text = '',
    this.borderRadius,
    this.onSubmit,
    this.onTap,
    this.onSuffixIconTap,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool obscureText;
  final bool isThreeWordsTextField;
  final bool isLinesTextField;
  final bool hideBorder;
  final bool hasNextTextField;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final int? numOfWords;
  final int? maxAllowedWords;
  final int? maxLines;
  final int maxLinesForFormatter;
  final int? minLines;
  final int? maxLength;
  final Color? textColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;
  final EdgeInsets? padding;
  final void Function(String text)? onChange;
  final bool readOnly;
  final String text;
  final double? borderRadius;
  final void Function(String text)? onSubmit;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixIconTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    hidePassword = widget.obscureText;

    if (widget.text.isNotEmpty && widget.controller != null) {
      widget.controller!.text = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      onSubmitted: widget.onSubmit,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: widget.onChange,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      obscureText: hidePassword,
      obscuringCharacter: '*',
      controller: widget.controller,
      cursorColor: AppColors.primaryColor,
      keyboardType: widget.textInputType,
      textInputAction: widget.hasNextTextField ? TextInputAction.next : widget.textInputAction,
      style: widget.textStyle ??
          regular.copyWith(
            fontSize: 14,
            color: widget.textColor ?? AppColors.primaryColor,
          ),
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.textFieldBgColor,
        contentPadding: widget.padding ??
            EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 16.w,
            ),
        counterStyle: medium.copyWith(
          fontSize: 12,
          color: Colors.white,
        ),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(right: 12.w, left: 12.w),
                child: SvgPicture.asset(
                  widget.prefixIcon!,
                  fit: BoxFit.fitHeight,
                ),
              ),
        prefixIconConstraints: widget.prefixIcon == null
            ? null
            : BoxConstraints(
                maxHeight: 24.h,
                minHeight: 24.h,
              ),
        suffixIcon: widget.suffixIcon != null
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: widget.onSuffixIconTap,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: SvgPicture.asset(
                    widget.suffixIcon!,
                    // color: AppColors.primaryColor,
                    height: 24.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            : !widget.obscureText
                ? null
                : CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: SvgPicture.asset(
                        !hidePassword ? 'assets/svg/show.svg' : 'assets/svg/hide.svg',
                        // color: AppColors.primaryColor,
                        height: !hidePassword ? 24.h : 24.h,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
        suffixIconConstraints: !widget.obscureText && widget.suffixIcon == null
            ? null
            : BoxConstraints(
                maxHeight: 24.h,
                minHeight: 22.h,
              ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            regular.copyWith(
              fontSize: 14,
              color: AppColors.hintTextColor,
            ),
        isDense: true,
        border: widget.hideBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: AppColors.textFieldBorderColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
              ),
        enabledBorder: widget.hideBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: AppColors.textFieldBorderColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
              ),
        focusedBorder: widget.hideBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1.5,
                  color: AppColors.primaryColor,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
              ),
      ),
    );
  }
}
