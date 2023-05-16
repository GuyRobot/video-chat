import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/utils/logger.dart';
import 'package:chatty/common/widgets/toast.dart';
import 'package:chatty/pages/frame/signin/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final title = "Chatty .";
  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      "openid",
    ],
  );

  handleSignIn(String type) async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        LoginRequestEntity requestEntity = LoginRequestEntity();
        requestEntity.avatar = user.photoUrl ?? "";
        requestEntity.name = user.displayName;
        requestEntity.email = user.email;
        requestEntity.open_id = user.id;
        requestEntity.type = 2;

        restSignIn(requestEntity);
      }
    } catch (_) {}
  }

  restSignIn(LoginRequestEntity requestEntity) async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);

    final response = await UserAPI.Login(params: requestEntity);
    Logger.write(response.toString());
    if (response.code == 0) {
      await UserStore.to.saveProfile(response.data!);
    } else {
      toastInfo(msg: "Internet error");
    }
    EasyLoading.dismiss();
    Get.offAllNamed(AppRoutes.Message);
  }
}
