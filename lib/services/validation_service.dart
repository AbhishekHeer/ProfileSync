import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/models/notes_model.dart';

class ValidationServiceController extends GetxController {
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  RxInt dropValue = 1.obs;
  final TextEditingController userNotes = TextEditingController();
  final isLoading = false.obs;
  RxBool isButtonEnabled = false.obs;

  @override
  void onInit() {
    address.addListener(_enabledButton);
    phoneNumber.addListener(_enabledButton);
    userNotes.addListener(_enabledButton);

    super.onInit();
  }

  @override
  void onClose() {
    address.clear();
    phoneNumber.clear();
    userNotes.clear();
    super.onClose();
  }

  void _enabledButton() {
    if (address.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        dropValue.value != 1 &&
        userNotes.text.isNotEmpty) {
      isButtonEnabled.value = true;
      isLoading.value = true;
    } else {
      isButtonEnabled.value = false;
      isLoading.value = false;
    }
  }

  void changeDropValue(int value) {
    dropValue.value = value;
  }

  Future<bool> validateForm({required NotesModel notesModel}) async {
    final response = await supabaseServiceController.createNote(notesModel);
    return response;
  }
}
