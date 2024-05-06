import 'dart:convert';

import 'package:frontend_app/models/model.dart';

class DataPoint implements Model<DataPoint> {
  DataPoint({
    required this.userId,
    required this.name,
    required this.value,
    required this.collectionDate,
    required this.collectionType,
  });

  int userId;
  String? name;
  double? value;
  String? collectionDate;
  int collectionType;
  

  factory DataPoint.fromJson(Map<String, dynamic> json) => DataPoint(
    userId: json["userId"],
    name: json["name"],
    value: json["value"],
    collectionDate: json["collectionDate"],
    collectionType: json["collectionType"], 
  );

  @override
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "value": value,
    "collectionDate": collectionDate,
    "collectionType": collectionType, 
  };

  static List<DataPoint> listFromJson(String str) =>
    List<DataPoint>.from(json.decode(str).map((x) => DataPoint.fromJson(x)));

  static String listToJson(List<DataPoint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

enum CollectionType {
  automatic, manual, document
}