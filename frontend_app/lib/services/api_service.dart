import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend_app/models/datapoint.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/user.dart';

class ApiService {
  static Dio httpConnection = Dio();
  static final ApiService _service = ApiService._internal();

  factory ApiService() {
    return _service;
  }

  ApiService._internal() {
    httpConnection = Dio();
  }

  Future<List<User>?> getUsers() async {
    try {
      Uri uri = Uri.https(ApiConstants.baseUrl, "/user");
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        List<User> modelResponse = User.listFromJson(response.body);
        return modelResponse;
      } 
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> getUser(int id) async {
    try {
      Uri uri = Uri.https(ApiConstants.baseUrl, "/user/id/$id");
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        User modelResponse = User.fromJson(json.decode(response.body));
        return modelResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> putUser(int id, User user) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, "/user/id/$id");
      var response = await http.post(
        url, 
        headers: {"Content-Type": "text/json"},
        body: json.encode(user)
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      Uri uri = Uri.https(ApiConstants.baseUrl, "/user/email/$email");
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        User modelResponse = User.fromJson(json.decode(response.body));
        return modelResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<DataPoint?> getUserAttribute(int id, String name) async {
    try {
      Uri uri = Uri.https(ApiConstants.baseUrl, "/user/data/$id/$name");
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        DataPoint modelResponse = DataPoint.fromJson(json.decode(response.body));
        return modelResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<DataPoint>?> getUserData(int id) async {
    try {
      Uri uri = Uri.https(ApiConstants.baseUrl, "/user/data/$id");
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        List<DataPoint> modelResponse = DataPoint.listFromJson(response.body);
        return modelResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> putData(int id, DataPoint data) async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, "/user/data/$id");
      var response = await http.post(
        url, 
        headers: {"Content-Type": "text/json"},
        body: json.encode(data)
        );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}