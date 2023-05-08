import 'package:chatty/pages/frame/signin/state.dart';
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
        String? displayName = user.displayName;
        String email = user.email;
        String id = user.id;
      }
    } catch (_) {}
  }
}
