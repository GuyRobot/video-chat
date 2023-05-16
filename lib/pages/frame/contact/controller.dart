import 'dart:convert';

import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'index.dart';

class ContactController extends GetxController {
  final title = "Chatty .";
  final state = ContactState();

  @override
  void onReady() {
    super.onReady();

    asyncLoadContacts();
  }

  asyncLoadContacts() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    state.contactItems.clear();
    final result = await ContactAPI.post_contact();

    Logger.write(jsonEncode(result));
    if (result.code == 0) {
      state.contactItems.addAll(result.data ?? []);
    }

    EasyLoading.dismiss();
  }
}
