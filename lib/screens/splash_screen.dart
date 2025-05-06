import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/screens/home_screen.dart';
import 'package:top_ai_assignment/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      final auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        final userData = auth.currentUser;
        authController.userName.value = userData?.displayName ?? '';
        authController.userEmail.value = userData?.email ?? '';
        authController.userImage.value = userData?.photoURL ?? '';
        authController.userId.value = userData?.uid ?? '';
        Get.offAndToNamed(HomeScreen.routeName);
      } else {
        Get.offAndToNamed(LoginScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: zoomInAnimationController.build(
          context: context,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(IonIcons.bug, size: 50, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
