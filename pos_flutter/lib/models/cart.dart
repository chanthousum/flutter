import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:pos_flutter/models/category.dart';
import 'package:pos_flutter/models/product.dart';
import 'package:http/http.dart' as http;
class Cart {
  late int id;
  late String name;
  late int qauntity;
  late double unitPrice;
  Cart();
  Cart.newInstance({required this.id,required this.name,required this.qauntity,required this.unitPrice});
  Map<Object, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['totalAmount'] =totalAmount();
    // [data['qty'] = qauntity,
    // data['unitPrice'] = unitPrice,
    // data['amount'] =this.amount()];
    var o={
      "totalAmount":Cart.totalAmount(),
      "userId":1,
      "saleDetail": [
        {
          "qty": 60,
          "sellPrice": 1,
          "amount": 60,
          "product": {
            "id": 1
          }
        }
      ]
    };
    return o;
  }
  double amount() {
    return this.unitPrice * this.qauntity;
  }

  static List<Cart> listCart = [];
  void addCart(int id, String name, double unitPrice) {
    Cart cart = new Cart();
    cart.id = id;
    cart.name = name;
    cart.unitPrice = unitPrice;
    cart.qauntity = 1;
    for (var item in listCart) {
      int oldQty = 0;
      if (item.id == id) {
        oldQty = int.parse(item.qauntity.toString()) + 1;
        item.qauntity = oldQty;
        return;
      }
    }
    cart.amount();
    listCart.add(cart);
  }

  static double totalAmount() {
    double total = 0;
    for (var item in listCart) {
      total += double.parse(item.amount().toString());
    }
    return total;
  }

  static int addQty(int id) {
    int oldQty = 0;
    for (var item in listCart) {
      if (item.id == id) {
        oldQty = int.parse(item.qauntity.toString()) + 1;
        item.qauntity = oldQty;
      }
    }
    return oldQty;
  }
  static int removeQty(int id) {
    int oldQty = 0;
    for (var item in listCart) {
      if (item.id == id) {
        listCart.removeWhere((item) => item.id ==id);
        // oldQty = int.parse(item.qty.toString()) - 1;
        // if(oldQty==0){
        //   listCart.remove(item);
        // }
        // item.qty = oldQty;
      }
    }
    return oldQty;
  }
  static List<Cart> generate() {
    return listCart;
  }

  static void romvoveItemAll() {
    listCart.clear();
  }
  static void commitData(){
    for(var item in listCart){
      var cart=new Cart();
      cart.id=item.id;
      cart.qauntity=item.qauntity;
      cart.unitPrice=item.unitPrice;
      // cart.total=item.amount();
      var body = json.encode(cart.toJson());
      print("${body}");
    }
  }
  static Future Post(BuildContext context, String endpoint, String body) async {
    try {
      var access=await FlutterSession().get("accessToken");
      var endpoint1 = Uri.parse("${Categorys.serverIp}$endpoint");
      final response = await http.post(endpoint1, body:body, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$access',
      });
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}")));
        return false;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${response.body}",style:TextStyle(color:Colors.red),)));
        print("${response.body}");
        return false;
      }
    } catch (e) {
      return Future.error("Error post data${e}");
    }
  }

}


class SaleDetail{
  late int qty;
  late double sellPrice;
  late double amount;
  late product products;
 // SaleDetail();
  SaleDetail(this.qty, this.sellPrice, this.amount,this.products);
  Map toJson() => {
    'qty': qty,
    'sellPrice': sellPrice,
    "amount":amount,
    "product":products,
  };

}
class Sale {
  late double totalAmount;
  late int userId;
  List<SaleDetail> saleDetail;
  Sale(this.totalAmount, this.userId,this.saleDetail);
  Map toJson() {
    List<Map>? tags = this.saleDetail != null ? this.saleDetail.map((i) => i.toJson()).toList() : null;
    return {
      'totalAmount': totalAmount,
      'userId': userId,
      'saleDetail': saleDetail,
    };
  }
}
class product{
  late int id;

  product(this.id);

  Map toJson() => {
    'id': id,
  };
}
