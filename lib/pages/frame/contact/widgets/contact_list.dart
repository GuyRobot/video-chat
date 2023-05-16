import 'package:chatty/common/entities/contact.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../index.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = controller.state.contactItems[index];
              return _buildContactItem(item);
            }, childCount: controller.state.contactItems.length),
          ),
        )
      ],
    );
  }

  Container _buildContactItem(ContactItem item) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom:
              BorderSide(width: 1, color: AppColors.primarySecondaryBackground),
        ),
      ),
      child: InkWell(
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.primarySecondaryBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(24.w),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1)),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: item.avatar!,
                height: 48.w,
                width: 48.w,
                imageBuilder: (context, provider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: provider),
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.w),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${item.name}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.thirdElement,
                    fontSize: 16.sp,
                    fontFamily: "Avenir",
                  ),
                ),
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: Image.asset(
                    "assets/icons/ang.png",
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
