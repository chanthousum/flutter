import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:pos_flutter/models/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Log In"),
      //   centerTitle: true,
      //   actions: [],
      // ),

      body: _myForm(context),
    );
  }

  Widget _myForm(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
        color: Color.fromRGBO(250, 250, 250, 1),
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CircleAvatar(
                    child: Text(""),
                    radius: 70.0,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdS84e1z_z21366wQqF66PYfzNzVbh5GZVaQ&usqp=CAU"),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 50,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                      controller: usernameController,
                      obscureText:false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person,
                          color: Color(0xff6bceff),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 50,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key,
                          color: Color(0xff6bceff),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              child: RaisedButton(
                        color: Color.fromRGBO(29, 180, 255, 1),
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 18),
                        ),
                        textColor: Colors.white,
                        //color: Colors.blue,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a Snackbar.
                            User user = User();
                                user.username=usernameController.text;
                                user.password=passwordController.text;
                            final body = json.encode(user.toJson());
                            var t = await user.logIn(context, body);

                          }
                        },
                      ))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/setec.png",
                          width: 300,
                        )
                      ],
                    ),
                  )
                ])),
      ),
    ));
  }
}

myAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Delete"),
    content: Text("Are you want to delete record?"),
    // shape: CurveBorder(),
    actions: [
      FlatButton(
        onPressed: () {
          myToast(context, "ok");
          Navigator.of(context).pop();
        },
        child: Text("Yes"),
        color: Colors.black12,
      ),
      FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("No"),
        color: Colors.black12,
      )
    ],
  );
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      });
}

myToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      fontSize: 20,
      textColor: Colors.black);
}
