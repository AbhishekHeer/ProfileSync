import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: height * 0.05,
            children: <Widget>[
              SizedBox(width: 0.0, height: height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .03),
                child: TextField(
                  maxLength: 10,

                  controller: authController.phoneController,
                  style: GoogleFonts.nunito(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: GoogleFonts.nunito(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * .05),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              Obx(() {
                if (authController.showOTPField.value) {
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * .03,
                          ),
                          child: TextField(
                            maxLength: 6,
                            controller: authController.otpController,
                            style: GoogleFonts.nunito(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'OTP',
                              labelStyle: GoogleFonts.nunito(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  width * .05,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await authController.verifyOTP();
                        },
                        child: Container(
                          height: height * .05,
                          width: width * .1,
                          margin: EdgeInsets.only(
                            right: height * .02,
                            bottom: height * .02,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(width * .05),
                          ),
                          child: Center(child: const Text('Verify')),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              Obx(
                () => InkWell(
                  onTap: () {
                    authController.signInWithPhone();
                  },
                  child: Container(
                    height: height * .055,
                    width: width * .2,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(width * .05),
                    ),
                    child: Center(
                      child:
                          authController.isLoading.value
                              ? CircularProgressIndicator()
                              : Text('Send OTP'),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 0.0, height: height * .05),
              InkWell(
                onTap:
                    () => authController.signInWithGoogle().then((val) {
                      authController.userName.value =
                          val?.user?.displayName ?? 'User';
                      authController.userEmail.value = val?.user?.email ?? '';
                      authController.userImage.value =
                          val?.user?.photoURL ?? '';
                      authController.phoneNumber.value =
                          val?.user?.phoneNumber ?? '';
                      authController.address.value = val?.user?.email ?? '';
                      authController.userId.value = val?.user?.uid ?? '';
                      Get.offAllNamed(HomeScreen.routeName);
                    }),
                child: Brand(Brands.google, size: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
