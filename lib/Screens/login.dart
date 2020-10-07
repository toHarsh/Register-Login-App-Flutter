import 'package:flutter/material.dart';
import 'package:login_form/Screens/home.dart';
import 'package:provider/provider.dart';
import 'package:login_form/models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _loginData = {'email': '', 'password': ''};

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
          .login(_loginData['email'], _loginData['password']);
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
          backgroundColor: Colors.orange,
          title: Text("Login Screen!"),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
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
                  height: MediaQuery.of(context).size.height * 0.5,
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
                                  _loginData['email'] = value;
                                },
                              ),

                              //password
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Password"),
                                obscureText: true, //to hide the password
                                validator: (value) {
                                  if (value.isEmpty || value.length <= 5) {
                                    return 'Invalid Password!';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _loginData['password'] = value;
                                },
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
                                      color: Colors.orange,
                                      textColor: Colors.white,
                                      child: Text("Submit!"),
                                      onPressed: () {
                                        _submit();
                                      })),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.2),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/register');
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Register!",
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
