import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/screens/home_screen.dart';

class DeleteScreen extends StatefulWidget {
  static const String routeName = '/delete-screen';
  DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

var args = Get.arguments as Map<String, dynamic>;
final id = args['id'];

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Note',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            fontSize: width * .04,
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
                  'Are you sure you want to delete this note?',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: width * .04,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                log("id is $id");
                final response = await supabaseServiceController.deleteNote(
                  id ?? "0",
                );

                if (response) {
                  Get.offAllNamed(HomeScreen.routeName);
                } else {
                  Get.snackbar("Error", "Something went wrong");
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
                    'Delete',
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
