import 'package:flutter/material.dart';
import 'package:login_form/Screens/login.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
        ),
        centerTitle: true,
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Text("This is My HomeScreen"),
      ),
    );
  }
}
