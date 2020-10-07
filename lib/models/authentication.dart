import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_form/models/error.dart';

class Authentication with ChangeNotifier {
  Future<void> register(String email, String password) async {
    const url = 'post_url[API_KEY]';

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
    const url = 'get_url[API_KEY]';

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
