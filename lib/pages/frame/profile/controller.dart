import 'package:chatty/common/store/store.dart';
import 'package:chatty/pages/frame/profile/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  final title = "Chatty .";
  final state = ProfileState();

  logout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
