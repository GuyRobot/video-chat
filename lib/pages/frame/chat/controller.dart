import 'package:get/get.dart';

import 'index.dart';

class ChatController extends GetxController {
  final title = "Chatty .";
  final state = ChatState();

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
}
