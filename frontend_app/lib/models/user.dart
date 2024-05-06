import 'dart:convert';

import 'package:frontend_app/models/model.dart';

class User implements Model<User> {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  int id;
  String? name;
  String? username;
  String? email;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    password: json["password"], //maybe don't send passwords over plaintext?
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "password": password,
  };

  static List<User> listFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

  static String listToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
