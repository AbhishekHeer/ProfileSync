import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';

class FormFields extends StatelessWidget {
  const FormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      spacing: 16.0,
      children: [
        TextField(
          controller: validationServiceController.address,
          style: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Address',
            labelStyle: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * .05),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: validationServiceController.phoneNumber,
          keyboardType: TextInputType.number,
          style: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
          decoration: InputDecoration(
            labelText: 'number',
            labelStyle: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * .05),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
        ),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38, width: 1.5),
              borderRadius: BorderRadius.circular(width * .05),
            ),
            child: DropdownButton(
              value: validationServiceController.dropValue.value,
              isExpanded: true,
              hint: const Text('text'),
              underline: const SizedBox(), // Hide default underline
              borderRadius: BorderRadius.circular(10.0),
              style: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
              items: [
                for (var i = 1; i <= 100; i++)
                  DropdownMenuItem(value: i, child: Text(i.toString())),
              ],
              onChanged: (val) async {
                validationServiceController.changeDropValue(val ?? 1);
              },
            ),
          ),
        ),

        TextField(
          controller: validationServiceController.userNotes,
          style: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter your notes',
            hintStyle: GoogleFonts.nunito(fontSize: 16.0, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * .05),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
