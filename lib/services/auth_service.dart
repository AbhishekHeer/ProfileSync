import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_ai_assignment/screens/home_screen.dart';

class AuthController extends GetxController {
  RxString messege = ''.obs;
  RxBool isLoading = false.obs;
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userImage = ''.obs;
  RxString userId = ''.obs;
  RxString address = ''.obs;
  RxString phoneNumber = ''.obs;
  var showOTPField = false.obs;
  var verficationID = "".obs;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.clear();
    otpController.clear();
  }

  Future<bool> signInWithPhone() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",

        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Get.offAllNamed(HomeScreen.routeName);
        },
        verificationFailed: (error) {},
        codeSent: (verificationId, resendToken) async {
          verficationID.value = verificationId;
          showOTPField.value = true;
          isLoading.value = false;
        },

        codeAutoRetrievalTimeout: (verificationId) {},
      );
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> verifyOTP() async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verficationID.value,
        smsCode: otpController.text,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      isLoading.value = false;
      Get.offAllNamed(HomeScreen.routeName);
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await GoogleSignIn().currentUser?.clearAuthCache();

      await FirebaseAuth.instance.signOut();

      messege.value = 'Sign out success';
      return true;
    } catch (e) {
      log(e.toString());
      messege.value = 'Sign out failed: ${e.toString()}';
      return false;
    }
  }
}
