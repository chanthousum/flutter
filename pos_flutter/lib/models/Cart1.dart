import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pos_flutter/models/category.dart';
class Card1 {
  int id;
  int userId;
  double subTotal;
  Card1(this.id,this.userId,this.subTotal);

  // Cart1.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   userId = json['userId'];
  //   saleDate = json['saleDate'];
  //   subTotal = json['subTotal'];
  // }

  Map<Object, dynamic> toJson() {
    final Map<Object, dynamic> data = new Map<Object, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['subTotal'] = this.subTotal;
    return data;
  }
  static Future Post(BuildContext context, String endpoint, String body) async {
    try {
      var endpoint1 = Uri.parse("${Categorys.serverIp}$endpoint");
      final response = await http.post(endpoint1, body:body, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      });
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
        return false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
        print("${response.body}");
        return false;
      }
    } catch (e) {
      return Future.error("Error post data${e}");
    }
  }
}