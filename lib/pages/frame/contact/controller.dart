import 'dart:convert';

import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/contact.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'index.dart';

class ContactController extends GetxController {
  final title = "Chatty .";
  final state = ContactState();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();

    asyncLoadContacts();
  }

  goChat(ContactItem contact) async {
    final sentMessages = await db
        .collection("message")
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: contact.token)
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .get();

    final receivedMessages = await db
        .collection("message")
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: contact.token)
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .get();

    if (sentMessages.docs.isEmpty && receivedMessages.docs.isEmpty) {
      final profile = UserStore.to.profile;
      final msg = Msg(
          from_token: profile.token,
          to_token: contact.token,
          from_avatar: profile.avatar,
          to_avatar: contact.avatar,
          from_name: profile.name,
          to_name: contact.name,
          from_online: profile.online,
          to_online: contact.online,
          msg_num: 0);

      final doc = await db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msg);

      Get.offAllNamed("/chat", parameters: {
        "doc_id": doc.id,
        "to_token": contact.token!,
        "to_avatar": contact.avatar!,
        "to_name": contact.name!,
        "to_online": contact.online.toString()
      });
    }
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
