import 'package:chalet_spot/core/utils/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../config/routes/routes.dart';

class FirebaseFunctions {
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null; // User cancelled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      // Handle any errors here
      print('Error signing in with Google: $e');
      return null;
    }
  }

  static Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      print(appleCredential.identityToken);
    } catch (e) {
      print("Sign In with Apple failed: $e");
      // Handle specific error cases here if needed
    }
  }

  static Future<void> googleLogOut(BuildContext context) async {
    googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeData('accessToken');
    Navigator.pushNamed(context, Routes.login);
  }
}
