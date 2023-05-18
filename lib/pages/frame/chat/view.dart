import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryElement,
      appBar: _buildHeadTitle(),
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              Positioned(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primarySecondaryElementText,
                        ),
                        color: AppColors.primaryBackground,
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Row(
                        children: [
                          TextField(
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: "Message ...",
                              contentPadding: EdgeInsets.only(left: 16.w),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              hintStyle: const TextStyle(
                                color: AppColors.primarySecondaryElementText,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              width: 48.w,
                              height: 48.w,
                              child: Image.asset("assets/icons/send.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(left: 8.w),
                        padding: EdgeInsets.all(4.w),
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryElement,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Image.asset("assets/icons/add.png"),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.state.moreOptionsVisible.value)
                Positioned(
                  right: 24.w,
                  bottom: 76.h,
                  height: 200.h,
                  width: 40.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIcon("assets/icons.file.png"),
                      _buildIcon("assets/icons.photo.png"),
                      _buildIcon("assets/icons.phone.png"),
                      _buildIcon("assets/icons.video.png"),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildHeadTitle() {
    return AppBar(
      title: Obx(
        () => Text(
          controller.state.whomName.value,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: AppColors.primaryElementText,
            fontWeight: FontWeight.bold,
            fontSize: 45.0.sp,
            fontFamily: "Montserrat",
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.w),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: controller.state.whomAvatar.value,
                  imageBuilder: (_, provider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.w),
                      ),
                      image: DecorationImage(
                        image: provider,
                      ),
                    ),
                  ),
                  errorWidget: (_, __, ___) =>
                      Image.asset("assets/images/account_header.png"),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 5.w,
                height: 16.w,
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: controller.state.whomStatus.value == "1"
                        ? AppColors.primaryElementStatus
                        : AppColors.primarySecondaryElementText,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                    border: Border.all(
                      color: AppColors.primaryElementText,
                      width: 2.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildIcon(String iconPath) {
    return GestureDetector(
      child: Container(
        width: 48.w,
        height: 48.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(24.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Image.asset(iconPath),
      ),
    );
  }
}
