import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/models/notes_model.dart';
import 'package:top_ai_assignment/screens/home_screen.dart';
import 'package:top_ai_assignment/widgets/form_fields.dart';

class AddNotes extends StatelessWidget {
  static const String routeName = '/add_notes';
  const AddNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Notes',
          style: GoogleFonts.nunito(fontSize: width * .04, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: width * .05,
          right: width * .05,
          top: height * .02,
          bottom: height * .02,
        ),
        child: FormFields(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Obx(
          () => Container(
            height: height * .07,
            width: width,
            decoration: BoxDecoration(
              color:
                  validationServiceController.isButtonEnabled.value
                      ? Colors.blue
                      : Colors.grey,
              borderRadius: BorderRadius.circular(width * .05),
            ),
            child: GestureDetector(
              onTap: () async {
                if (validationServiceController.isButtonEnabled.value) {
                  final id = DateTime.now().millisecondsSinceEpoch;
                  final model = NotesModel(
                    userUid: authController.userId.value,
                    id: id,
                    address: validationServiceController.address.text,
                    number: int.parse(
                      validationServiceController.phoneNumber.text,
                    ),
                    age: validationServiceController.dropValue.value,
                    userNote: validationServiceController.userNotes.text,
                  );
                  await supabaseServiceController.createNote(model);
                  Get.offAllNamed(HomeScreen.routeName);
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: Center(
                child: Text(
                  'Save',
                  style: GoogleFonts.nunito(
                    fontSize: width * .05,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
