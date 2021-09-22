import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:pos_flutter/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Categorys {
  final int id;
  final String name;
  // static final serverIp = "http://10.0.0.2:8080";
  static final serverIp = "http://192.168.1.37:8080";
  static final header="";
  static Future checkRefreshToken(BuildContext context) async{
    // Timer(Duration(milliseconds:1), () async {
    print("Yeah, this line is printed after 3 second");
    var access1 =await FlutterSession().get("accessToken");
    var refreshToken =await FlutterSession().get("refreshToken");
    var endpoint1 = Uri.parse("${Categorys.serverIp}/api/v1/refreshtoken");
    var response1 = await http.post(endpoint1,body:jsonEncode(<String, String>{
      'refreshToken': refreshToken,
    }), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$access1',
    });
    var jsonResponse = json.decode(response1.body);
    // print("old Token"+access);
    // print("generate Token"+jsonResponse["accessToken"]);
    await FlutterSession().set("accessToken",jsonResponse["accessToken"]);
    // });
    Timer(Duration(milliseconds:900000), () async {
      Navigator.pushNamed(context, "/");
    });
  }
  static Future Post(BuildContext context, String endpoint, String body) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var access = sharedPreferences.getString("access");
      if (access == null) {
        Navigator.pushNamed(context, "/");
      }
      var endpoint1 = Uri.parse("${Categorys.serverIp}$endpoint");
      final response = await http.post(endpoint1, body: body, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$access',
      });
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
        return false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
        return false;
      }
    } catch (e) {
      return Future.error("Error post data${e}");
    }
  }

  static Future deleteById(
      BuildContext context, String endpoint, int id) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      var access = sharedPreferences.getString("access");
      if (access == null || access == "") {
        Navigator.pushNamed(context, "/");
      }
      var endpoint1 = Uri.parse("${Categorys.serverIp}${endpoint}${id}");
      final response = await http.delete(endpoint1, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$access',
      });
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
      }
    } catch (SocketException) {
      return Future.error("Error delete data");
    }
  }

  // Future deleteCategoryById(String id) async {
  //   var endpoint = Uri.parse("${Categorys.serverIp}/api/category/${id}");
  //   final response = await http
  //       .delete(endpoint, headers: {'Content-Type': 'application/json'});
  //   if (response.statusCode == 200) {
  //     return Categorys.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }

  // Future<Categorys> getCategoryById(String id) async {
  //   try {
  //     var endpoint = Uri.parse("${Categorys.serverIp}/api/category/get/${id}");
  //     final response = await http
  //         .get(endpoint, headers: {'Content-Type': 'application/json'});
  //     if (response.statusCode == 200) {
  //       List jsonResponse = json.decode(response.body);
  //       // print(jsonResponse);
  //       return Categorys.fromJson(json.decode(response.body));
  //     } else {
  //       return Future.error("Server Error");
  //     }
  //   } catch (SocketException) {
  //     return Future.error("Error get data");
  //   }
  // }

  Future getById(String endpoint, String id) async {
    var endpoint1 = Uri.parse("${Categorys.serverIp}${endpoint}${id}");
    final response = await http
        .get(endpoint1, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      var re = jsonDecode(response.body);
      print(re);
      return Categorys.fromJson(json.decode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Categorys({this.id=0,this.name=""});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  // Future updateCategoryById(String body) async {
  //   var endpoint = Uri.parse("${Categorys.serverIp}/api/category/update/${c.id}");
  //   final response = await http.put(endpoint,
  //       body: body, headers: {"Content-Type": "application/json"});
  //   if (response.statusCode == 200) {
  //     return Categorys.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }
 static Future updateById(
      BuildContext context, String endpoint, String body, int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var access = sharedPreferences.getString("access");
    if (access == null || access == "") {
      Navigator.pushNamed(context, "/");
    }
    var endpoint1 = Uri.parse("${Categorys.serverIp}${endpoint}${id}");
    final response = await http.put(endpoint1, body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$access',
    });
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
      return false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
      return false;
    }
  }

  factory Categorys.fromJson(Map<String, dynamic> json) {
    return Categorys(
      id: json['id'],
      name: json['name'],
    );
  }
}