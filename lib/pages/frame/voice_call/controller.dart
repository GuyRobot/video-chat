import "package:agora_rtc_engine/agora_rtc_engine.dart";
import "package:chatty/common/apis/apis.dart";
import "package:chatty/common/entities/chat.dart";
import "package:chatty/common/store/store.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";
import "package:just_audio/just_audio.dart";
import "package:permission_handler/permission_handler.dart";

import "index.dart";

class VoiceCallController extends GetxController {
  final state = VoiceCallState();

  final player = AudioPlayer();
  final db = FirebaseFirestore.instance;
  final profileToken = UserStore.to.profile.token;
  late RtcEngine engine;
  final ChannelProfileType channelProfileType =
      ChannelProfileType.channelProfileCommunication;

  @override
  void onInit() {
    super.onInit();

    final params = Get.parameters;
    state.setWhomName(params["to_name"]);
    state.setWhomAvatar(params["to_avatar"]);
    state.setCallRole(params["call_type"]);
    state.setDocId(params["doc_id"]);

    initEngine();
  }

  Future<String> getToken() async {
    if (state.callRole.value == "anchor") {
      state.channelId.value = "${profileToken}_${state.whomToken.value}";
    } else {
      state.channelId.value = "${state.whomToken.value}_$profileToken";
    }

    final requestParams =
        CallTokenRequestEntity(channel_name: state.channelId.value);
    final res = await ChatAPI.call_token(params: requestParams);
    if (res.code == 0) {
      return res.data!;
    }
    return "";
  }

  initEngine() async {
    await player.setAsset("assets/Sound_Horizon.mp3");

    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: "appid",
    ));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (ErrorCodeType error, msg) {},
        onJoinChannelSuccess: (connection, status) {
          state.isJoined.value = true;
        },
        onLeaveChannel: (connection, stats) {
          state.isJoined.value = false;
        },
        onRtcStats: (connection, stats) {},
        onUserJoined: (connection, remoteId, elapsed) async {
          await player.pause();
        },
      ),
    );

    await engine.enableAudio();
    await engine.setAudioProfile(
        profile: AudioProfileType.audioProfileDefault,
        scenario: AudioScenarioType.audioScenarioGameStreaming);
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await joinChannel();

    if (state.callRole.value == "anchor") {
      await sendNotification("voice");
      await player.play();
    }
  }

  sendNotification(String callType) async {
    final callRequestEntity = CallRequestEntity(
      call_type: callType,
      to_token: state.whomToken.value,
      to_name: state.whomName.value,
      to_avatar: state.whomAvatar.value,
      doc_id: state.docId.value,
    );
  }

  joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);

    final token = await getToken();
    await engine.joinChannel(
      token: token,
      channelId: "channelId",
      uid: 0,
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: channelProfileType,
      ),
    );

    EasyLoading.dismiss();
  }

  leaveChannel() async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );

    await player.pause();
    state.isJoined.value = false;
    EasyLoading.dismiss();
    Get.back();
  }

  _dispose() async {
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.dispose();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}
