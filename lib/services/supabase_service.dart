import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_ai_assignment/bindings/bindings.dart';
import 'package:top_ai_assignment/models/notes_model.dart';

class SupabaseServiceController extends GetxController {
  RxList<NotesModel> notes = <NotesModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getNotes();
  }

  final _client = Supabase.instance.client;
  final table = 'userNotes';
  Future<bool> createNote(NotesModel model) async {
    try {
      final response = await _client.from(table).insert(model.toJson());
      log("response is $response");
      return true;
    } catch (e) {
      log("error is $e");

      return false;
    }
  }

  Future<List<NotesModel>> getNotes() async {
    try {
      isLoading.value = true;

      final response = await _client
          .from('userNotes')
          .select('*')
          .eq("userUid", authController.userId.value);

      final notesList =
          (response as List).map((note) => NotesModel.fromJson(note)).toList();

      isLoading.value = false;
      return notesList;
    } catch (e) {
      log("getNotes error: $e");
      isLoading.value = false;
      return [];
    }
  }

  Future<bool> deleteNote(int id) async {
    try {
      final response = await _client.from(table).delete().eq('id', id);
      log("response is $response");
      return true;
    } catch (e) {
      log("error is $e");
      return false;
    }
  }

  Future<bool> updateNote(NotesModel model) async {
    try {
      final response = await _client
          .from(table)
          .update(model.toJson())
          .eq('id', model.id);
      log("response is $response");
      return true;
    } catch (e) {
      log("error is $e");
      return false;
    }
  }
}
