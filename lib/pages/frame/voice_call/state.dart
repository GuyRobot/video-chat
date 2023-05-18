import 'package:get/get.dart';

class VoiceCallState {
  final isJoined = false.obs;
  final isMicrophoneEnable = false.obs;
  final isSpeakerEnable = false.obs;

  final whomName = "".obs;
  final whomAvatar = "".obs;
  final whomStatus = "".obs;
  final whomToken = "".obs;

  setWhomName(String? name) => whomName.value = name ?? whomName.value;
  setWhomAvatar(String? avatar) => whomAvatar.value = avatar ?? whomAvatar.value;
  setWhomToken(String? token) => whomToken.value = token ?? whomToken.value;
  setWhomStatus(String? status) => whomStatus.value = status ?? whomStatus.value;
}