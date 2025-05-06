import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/screens/login_screen.dart';

class LogoutScreen extends StatefulWidget {
  static const String routeName = '/logout';
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logout',
          style: GoogleFonts.nunito(
            fontSize: width * .035,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * .05),
            Container(
              margin: EdgeInsets.only(top: height * .05),
              child: Center(
                child: Text(
                  'Are you sure you want to Logout ?',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: width * .04,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final logout = await authController.signOut();
                if (logout) {
                  Get.offAllNamed(LoginScreen.routeName);
                } else {
                  Get.snackbar('Error', 'Something went wrong');
                }
              },
              child: Container(
                height: height * .06,
                width: width * .3,
                margin: EdgeInsets.only(top: height * .05),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Center(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: width * .04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
