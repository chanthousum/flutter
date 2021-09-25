import 'package:flutter/cupertino.dart';
import 'package:pos_flutter/models/product.dart';

class Cart extends Product {
  late int qty;
  late int price;
  Cart();
  Cart.newInstance(this.qty);
  double amount() {
    return this.unitPrice * this.qty;
  }

  static List<Cart> listCart = [];

  void addCart(int id, String name, double unitPrice) {
    Cart cart = new Cart();
    cart.id = id;
    cart.name = name;
    cart.unitPrice = unitPrice;
    cart.qty = 1;
    for (var item in listCart) {
      int oldQty = 0;
      if (item.id == id) {
        oldQty = int.parse(item.qty.toString()) + 1;
        item.qty = oldQty;
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
        oldQty = int.parse(item.qty.toString()) + 1;
        item.qty = oldQty;
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
}
