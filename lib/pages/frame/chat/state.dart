import 'package:chatty/common/entities/entities.dart';
import 'package:get/get.dart';

class ChatState {
  RxList<MsgContent> messages = RxList();

  final whomName = "".obs;
  final whomAvatar = "".obs;
  final whomStatus = "".obs;
  final whomToken = "".obs;

  setWhomName(String? name) => whomName.value = name ?? whomName.value;
  setWhomAvatar(String? avatar) => whomAvatar.value = avatar ?? whomAvatar.value;
  setWhomToken(String? token) => whomToken.value = token ?? whomToken.value;
  setWhomStatus(String? status) => whomStatus.value = status ?? whomStatus.value;

  final moreOptionsVisible = false.obs;
}
