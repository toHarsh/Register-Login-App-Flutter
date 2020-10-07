import 'package:flutter/material.dart';
import 'package:login_form/Screens/home.dart';
import 'package:login_form/Screens/login.dart';
import 'package:login_form/models/authentication.dart';
import 'package:provider/provider.dart';
import 'Screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Provider applications
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Register\ Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),

        //routing method
        routes: {
          RegisterScreen.routeName: (context) => RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        },
      ),
    );
  }
}
