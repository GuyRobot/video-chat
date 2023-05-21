import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/base.dart';
import 'package:chatty/pages/frame/message/state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final title = "Chatty .";
  final state = MessageState();

  @override
  void onReady() {
    super.onReady();
    firebaseMessageSetup();
  }

  firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      BindFcmTokenRequestEntity requestEntity = BindFcmTokenRequestEntity(fcmtoken: fcmToken);

      await ChatAPI.bind_fcmtoken(params: requestEntity);
    }
  }
}