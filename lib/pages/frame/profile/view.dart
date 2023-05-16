import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(60.w),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Image.asset("assets/images/account_header.png"),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8.w),
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.w),
                ),
              ),
              child: Image.asset("assets/icons/edit.png"),
            ),
          ),
        )
      ],
    );
  }

  _buildCompleteBtn() {
    return Container(
      width: 296.w,
      height: 42.h,
      decoration: BoxDecoration(
        color: AppColors.primaryElement,
        borderRadius: BorderRadius.all(
          Radius.circular(5.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "Complete",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryElementText,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  _buildLogoutBtn() {
    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: "Are you sure to logout?",
          onConfirm: () {
            controller.logout();
          },
          onCancel: () {},
          textConfirm: "Confirm",
          textCancel: "Cancel",
          content: Container(),
        );
      },
      child: Container(
        width: 296.w,
        height: 42.h,
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryElementText,
          borderRadius: BorderRadius.all(
            Radius.circular(5.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryElement,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildProfilePhoto(),
                  _buildCompleteBtn(),
                  _buildLogoutBtn()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
