import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_form/models/error.dart';

class Authentication with ChangeNotifier {
  Future<void> register(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]';

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
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]';

//Register-Login-App-Flutter
//
//Simple Register/Login app in flutter/firebase Step 1: Clone this file in your desired folder
//
//Step2: pub get
//
//Step 3: Make a project in Firebase console
//
//Step 4: Copy the API_KEY and place in it [API_KEY] in authentication.dart
//
//step 5: run the app

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
