import 'package:flutter/material.dart';
import 'package:login_form/models/authentication.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  //to save a password in a variable
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("An Error Occured!"),
              content: Text(msg),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                    child: Text("Okay!")),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .register(_authData['email'], _authData['password']);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      var errorMessage = 'Authentification Failed!';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text("Register Screen!"),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35.0),
                  topLeft: Radius.circular(35.0),
                )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              //email
                              TextFormField(
                                decoration: InputDecoration(labelText: "Email"),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty || !value.contains('@')) {
                                    return 'Invalid Email!';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                              ),

                              //password
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Password"),
                                obscureText: true, //to hide the password
                                controller: _passwordController,
                                validator: (value) {
                                  if (value.isEmpty || value.length <= 5) {
                                    return 'Invalid Password!';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _authData['password'] = value;
                                },
                              ),

                              //confirm password
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: "Confirm Password"),
                                obscureText: true, //to hide the password
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value != _passwordController.text) {
                                    return 'Invalid Password!';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {},
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                  height: 40.0,
                                  width: 150.0,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0),
                                      )),
                                      elevation: 0.0,
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: Text("Submit!"),
                                      onPressed: () {
                                        _submit();
                                      })),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.20),
                                child: FlatButton(
                                  onPressed: () {
                                    //Navigate using routes
                                    Navigator.of(context)
                                        .pushReplacementNamed('/login');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Login!",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.person),
                                          onPressed: () {}),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
