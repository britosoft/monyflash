import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mf/src/api/environmen.dart';
import 'package:mf/src/page/models/user_models.dart';
import '../page/models/Response_api.dart';
import 'package:http/http.dart' as http;

class UsersProvider {
  String _url = Environment.Api_App;

  String _api = 'api/users';

  BuildContext context;

  Future init(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = jsonEncode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = jsonDecode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);

      return responseApi;
    } catch (e) {
      print('Error: $e');

      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
