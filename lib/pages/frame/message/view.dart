import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryElement,
      body: Center(
        child: Container(
          height: 48.h,
          margin: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: AppColors.primarySecondaryBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24.h),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 6,
                              blurRadius: 16,
                              offset: const Offset(0, 1)),
                        ],
                      ),
                      child: controller.state.headDetail.value.avatar == null
                          ? const Image(
                              image: AssetImage(
                                  "assets/images/account_header.png"),
                            )
                          : const Text("Hi"),
                    ),
                  ),
                  Positioned(
                    bottom: 5.w,
                    right: 0,
                    height: 16.w,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.w,
                            color: AppColors.primaryElementText,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12.w)),
                          color: AppColors.primaryElementStatus),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.primaryElementText,
          fontWeight: FontWeight.bold,
          fontSize: 45.0.sp,
          fontFamily: "Montserrat"),
    );
  }
}
