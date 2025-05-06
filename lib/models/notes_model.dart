import 'dart:convert';

class NotesModel {
  final int id;
  final String address;
  final int number;
  final int age;
  final String userNote;
  final String userUid;

  NotesModel({
    required this.id,
    required this.address,
    required this.number,
    required this.age,
    required this.userNote,
    required this.userUid,
  });

  factory NotesModel.fromRawJson(String str) =>
      NotesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    id: json["id"],
    address: json["Address"],
    number: json["phonenumber"],
    age: json["Age"],
    userNote: json["UserNote"],
    userUid: json["userUid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Address": address,
    "phonenumber": number,
    "Age": age,
    "UserNote": userNote,
    "userUid": userUid,
  };
}
