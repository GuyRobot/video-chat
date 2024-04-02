import 'dart:async';

import 'package:chatty/common/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/store/user.dart';
import 'index.dart';

class ChatController extends GetxController {
  final title = "Chatty .";
  final state = ChatState();
  late String docId;
  final TextEditingController editingController = TextEditingController();
  final userToken = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;

  late StreamSubscription<QuerySnapshot<MsgContent>> listener;

  toggleMoreOptions() {
    state.moreOptionsVisible.value = !state.moreOptionsVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    final params = Get.parameters;
    state.setWhomName(params['to_name']);
    state.setWhomAvatar(params['to_avatar']);
    state.setWhomToken(params['to_token']);
    state.setWhomStatus(params['to_online']);
  }

  @override
  void onReady() {
    state.messages.clear();
    final messages = db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: MsgContent.fromFirestore,
            toFirestore: (msg, options) => msg.toFirestore())
        .orderBy("addtime", descending: true)
        .limit(15);

    listener = messages.snapshots().listen((event) {
      List<MsgContent> msgList = <MsgContent>[];
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
    });
  }


  @override
  void onClose() {
    listener.cancel();
    editingController.dispose();
  }

  sendMessage() async {
    final sendMessage = editingController.text;
    final msg = MsgContent(
        token: userToken,
        content: sendMessage,
        type: "text",
        addtime: Timestamp.now());

    await db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: MsgContent.fromFirestore,
            toFirestore: (MsgContent content, options) => content.toFirestore())
        .add(msg)
        .then((value) {
      editingController.clear();
    });

    final messages = await db
        .collection("message")
        .doc(docId)
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (msg, options) => msg.toFirestore())
        .get();

    if (messages.data() != null) {
      final item = messages.data()!;
      int toMsgNum = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int fromMsgNum = item.from_msg_num == null ? 0 : item.from_msg_num!;

      if (item.from_token == userToken) {
        fromMsgNum += 1;
      } else {
        toMsgNum += 1;
      }

      await db.collection("message").doc(docId).update({
        "to_msg_num": toMsgNum,
        "from_msg_num": fromMsgNum,
        "last_message": sendMessage,
        "last_time": Timestamp.now(),
      });
    }
  }
}
