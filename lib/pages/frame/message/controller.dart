import 'package:chatty/pages/frame/message/state.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final title = "Chatty .";
  final state = MessageState();

  @override
  void onReady() {
    super.onReady();

  }
}