import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:plus_interview/models/api_model.dart';

class ApiService {
  final Dio dio =
      Dio(BaseOptions(baseUrl: "https://interview.sanjaysanthosh.me"));

  // register new user
  Future<String?> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      Response response = await dio.post(
        "/api/register",
        data: jsonEncode({"name": name, "email": email, "password": password}),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.data["token"];
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  // login
  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(
        "/api/login",
        data: jsonEncode({"email": email, "password": password}),
      );
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.data["token"];
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  // protected route
  Future<String?> protectedRoute(String token) async {
    try {
      Response response = await dio.get(
        "/api/protected",
        options: Options(
          headers: {"x-access-token": token},
        ),
      );
      if (response.statusCode == 200) {
        return response.data["message"];
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  // update password
  Future<bool> updatedPassword(String token, String password) async {
    try {
      Response response = await dio.put(
        "/api/update-user",
        options: Options(
          headers: {"x-access-token": token},
        ),
        data: jsonEncode(
          {"name": "name", "password": password},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> deleteAccount(String token) async {
    try {
      Response response = await dio.delete(
        "/api/delete-user",
        options: Options(
          headers: {"x-access-token": token},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return false;
  }

  // items api
  Future<List<ApiModel>?> getItems() async {
    try {
      Response response = await dio.get("/api/items");
      log("getItems ${response.statusCode} ${response.data}");
      if (response.statusCode == 200) {
        String jsonResponse = jsonEncode(response.data);
        return apiModelFromJson(jsonResponse);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }
}
