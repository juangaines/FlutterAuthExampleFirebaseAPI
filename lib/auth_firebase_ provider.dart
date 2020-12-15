import 'dart:convert';
import 'dart:io';

import 'package:firebase_api_example_auth/firebase_api_constants.dart';
import 'package:firebase_api_example_auth/model/custome_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/error_firebase.dart';

class AuthFirebaseProvider with ChangeNotifier {
  Map<String, String> _getCommonHeaders() {
    return <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    };
  }

  Future<CustomeResponse> signUpUser(String email, String password) async {
    var queryParameters = {
      'key': 'AIzaSyBcQFyKlr43MaXpZRB4aqaaOEhlJq8aSk8',
    };

    var uri = Uri.https("identitytoolkit.googleapis.com", "/v1/accounts:signUp",
        queryParameters);

    final http.Response response = await http.post(uri,
        headers: _getCommonHeaders(),
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true
        }));

    if (response.statusCode == 200) {
      return new CustomeResponse(null, response);
    } else {
      final jsonV = json.decode(response.body);
      final error = ErrorResponse.fromJson(jsonV);
      return new CustomeResponse(error, null);
    }
  }

  Future<CustomeResponse> loginUser(String email, String password) async {
    var queryParameters = {
      'key': 'AIzaSyBcQFyKlr43MaXpZRB4aqaaOEhlJq8aSk8',
    };

    var uri = Uri.https("identitytoolkit.googleapis.com",
        "/v1/accounts:signInWithPassword", queryParameters);

    final http.Response response = await http.post(uri,
        headers: _getCommonHeaders(),
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true
        }));

    if (response.statusCode == 200) {
      return new CustomeResponse(null, response.body);
    } else {
      final jsonV = json.decode(response.body);
      final error = ErrorResponse.fromJson(jsonV);
      return new CustomeResponse(error, null);
    }
  }
}
