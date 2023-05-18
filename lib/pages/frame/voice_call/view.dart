import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'index.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "00:00",
                  style: TextStyle(
                    color: AppColors.secondaryElementText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
                Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.state.whomAvatar.value,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 68.w,
                        width: 68.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Image(
                        image: AssetImage('assets/images/account_header.png'),
                      ),
                    ),
                    Text(
                      controller.state.whomName.value,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryElementText,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildIcon(
                      controller.state.isMicrophoneEnable.value,
                      normalIconPath: "assets/icons/a_microphone.png",
                      checkedIconPath: "assets/icons/a_telephone.png",
                      normalText: "Microphone",
                      checkedText: "Microphone",
                    ),
                    _buildIcon(
                      controller.state.isJoined.value,
                      normalIconPath: "assets/icons/a_telephone.png",
                      checkedIconPath: "assets/icons/a_phone.png",
                      normalColor: AppColors.primaryElementBg,
                      checkedColor: AppColors.primaryElementStatus,
                      normalText: "Connect",
                      checkedText: "Disconnect",
                    ),
                    _buildIcon(
                      controller.state.isSpeakerEnable.value,
                      normalIconPath: "assets/icons/a_trumpet.png",
                      checkedIconPath: "assets/icons/b_trumpet.png",
                      normalText: "Speaker",
                      checkedText: "Muted",
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildIcon(
    bool state, {
    Color? normalColor,
    Color? checkedColor,
    String? normalText,
    String? checkedText,
    String? normalIconPath,
    String? checkedIconPath,
  }) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: state
                ? (checkedColor ?? AppColors.primaryElementText)
                : (normalColor ?? AppColors.primaryElementStatus),
            borderRadius: BorderRadius.circular(32.w),
          ),
          child: Image.asset(
            state
                ? (checkedIconPath ?? "assets/icons/a_microphone.png")
                : (normalIconPath ?? "assets/icons/a_microphone.png"),
          ),
        ),
        Text(
          state ? (checkedText ?? "Microphone") : (normalText ?? "Microphone"),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryElementText,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
