import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          _buildLogo(controller.title),
          SizedBox(
            height: 48.h,
          ),
          _buildLoginOption("assets/icons/google.png", "Sign in with Google"),
          SizedBox(
            height: 16.h,
          ),
          _buildLoginOption(
              "assets/icons/facebook.png", "Sign in with Facebook"),
          SizedBox(
            height: 16.h,
          ),
          _buildLoginOption("assets/icons/apple.png", "Sign in with Apple"),
          SizedBox(
            height: 48.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 56.0.w),
            child: _buildOr(),
          ),
          SizedBox(
            height: 8.h,
          ),
          _buildLoginOption(null, "Sign in with phone number",
              alignment: MainAxisAlignment.center),
          SizedBox(
            height: 24.h,
          ),
          Text(
            "Already have an account",
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Signup here",
              style: TextStyle(
                  color: AppColors.primaryElement,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOr() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.primarySecondaryElementText,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        const Text("or"),
        SizedBox(
          width: 8.w,
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.primarySecondaryElementText,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 32.0.sp,
          fontFamily: "Montserrat"),
    );
  }

  Widget _buildLoginOption(String? icon, String title,
      {MainAxisAlignment alignment = MainAxisAlignment.start}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 296.w,
        height: 48.h,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            if (icon != null && icon.isNotEmpty)
              Container(
                padding: EdgeInsets.only(left: 42.w, right: 32.w),
                child: Image.asset(icon),
              ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0.sp,
                  fontFamily: "Montserrat"),
            ),
          ],
        ),
      ),
    );
  }
}
