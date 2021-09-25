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
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 100.0,
              ),
              CircleAvatar(
                child: Text(""),
                radius: 70.0,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdS84e1z_z21366wQqF66PYfzNzVbh5GZVaQ&usqp=CAU"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: "Username"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  }),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  style: TextStyle(fontSize: 20),
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  }),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text(
                  "Log In",
                  style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.black,
                //color: Colors.blue,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a Snackbar.
                    User objUser = User(
                        username: usernameController.text,
                        password: passwordController.text);
                    final body = json.encode(objUser.toJson());
                    var t = await logIn(context, body);
                    setState(() {});
                  }
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "forget password",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                color:Colors.white,
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
