import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test/screen/authorization.dart';

class VoterService {
  static const String _host = "https://api.sebastian.cl";
  static const String _apiTkn = "sebastian.cl";
  static const String _apiKey = "aaa-bbb-ccc-ddd";
  static const String _mime = "application/json";

  static Future<bool> login(BuildContext context) async {
    Uri uri = Uri.parse('$_host/vote/v1/auth/login');
    Map<String, String> headers = {
      'accept': _mime,
      'Content-Type': _mime,
      'X-API-TOKEN': _apiTkn,
      'X-API-KEY': _apiKey
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      final String token = result['token'];
      final String redirectUrl = result['redirectUrl'];
      if (redirectUrl.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AuthorizationScreen(url: redirectUrl, token: token),
            ));
      }
    }
    return false;
  }

  static Future<String> getJwt(String token) async {
    Uri uri = Uri.parse(_host + '/vote/v1/auth/' + token + '/jwt');
    Map<String, String> headers = {
      'accept': _mime,
      'Content-Type': _mime,
      'X-API-TOKEN': _apiTkn,
      'X-API-KEY': _apiKey
    };

    String jwt = "";
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      jwt = result['jwt'];
    }
    return jwt;
  }
}
