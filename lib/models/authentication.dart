import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_form/models/error.dart';

class Authentication with ChangeNotifier {
  Future<void> register(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDvo2-OUXQF625qTRgpwu32g8h7aYGhDko';

    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    final responseData = json.decode(response.body);
    print(responseData);
  }

  //login
  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDvo2-OUXQF625qTRgpwu32g8h7aYGhDko';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      //print(responseData);
    } catch (error) {
      throw error;
    }
  }
}
