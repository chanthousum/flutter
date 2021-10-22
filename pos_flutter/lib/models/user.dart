import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

import 'category.dart';

class User {
  late String username;
  late String password;
  static final String access = "";
  final String refresh = "";
  User();
  User.newInstance({required this.username, required this.password});

  Map<Object, dynamic> toJson() {
    final Map<Object, dynamic> data = new Map<Object, dynamic>();
    data["username"] = this.username;
    data["password"] = this.password;
    return data;
  }

  factory User.fromJson(Map<Object, dynamic> json) {
    return User.newInstance(
      username: json['username'],
      password: json['password'],
    );
  }

  Future logIn(BuildContext context, String body) async {
    try {
      var endpoint = Uri.parse("${Categorys.serverIp}/api/v1/login");
      final response = await http.post(endpoint,
          body: body, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var jsonReponse = json.decode(response.body);
        await FlutterSession().set("accessToken", jsonReponse["accessToken"]);
        await FlutterSession().set("refreshToken", jsonReponse["refreshToken"]);
        await FlutterSession().set("id", jsonReponse["id"]);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Successfully")));
        Navigator.pushNamed(context, "/home");
        return false;
      } else {
        var jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${jsonResponse["message"]}")));
        return false;
      }
    } catch (e, stacktrace) {
      return Future.error("Error get data :"+e.toString()+"${stacktrace.toString()}");
    }
  }
}



