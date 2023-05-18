import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatty/common/store/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

import 'index.dart';

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
    state.setWhomName(params['to_name']);
    state.setWhomAvatar(params['to_avatar']);

    initEngine();
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
  }

  joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);

    await engine.joinChannel(
      token: "token",
      channelId: 'channelId',
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
