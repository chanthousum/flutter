import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:pos_flutter/main.dart';
import 'package:pos_flutter/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:pos_flutter/pages/categoryEditForm.dart';
import 'dart:convert';
import 'package:pos_flutter/pages/categoryForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartList extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: MyDrawer(context),
      body: _myCategoryList(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => CategoryForm()));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget _myCategoryList(BuildContext context) {
    var list = Cart.generate();
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, index) {
                      return Card(
                          child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://rukminim1.flixcart.com/image/332/398/kmwcuq80/shoe/w/u/s/7-444-gry-org-bruton-orange-original-imagfp7fzz5ftzfc.jpeg?q=50"),
                                radius: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${list[index].name}\n${list[index].unitPrice}",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  Cart.removeQty(list[index].id);
                                  setState(() {
                                    Cart.generate();
                                  });
                                },
                                icon: Icon(Icons.remove_circle),
                              ),
                              Text("${list[index].qauntity}",
                                  style: TextStyle(fontSize: 16)),
                              IconButton(
                                onPressed: () {
                                  Cart.addQty(list[index].id);
                                  setState(() {
                                    Cart.generate();
                                  });
                                  //Navigator.pushNamed(context,"/cart");
                                },
                                icon: Icon(Icons.add_circle),
                              ),
                              Text("${list[index].amount().toString()}")
                            ]),
                      ));
                    })),
            checkOut()
          ],
        ));
  }
  Widget checkOut(){
    return Container(
        child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8.0),
                          child: Text(
                            "Total :",
                            style: TextStyle(fontSize: 18),
                          )),
                      Text(
                        "${Cart.totalAmount()}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: RaisedButton(
                            onPressed: () async {
                              var listItem=[];
                              SaleDetail saleDetail;
                              for(var item in Cart.listCart){
                                product products=new product(item.id);
                                saleDetail= new SaleDetail(item.qauntity,item.unitPrice,item.amount(),products);
                                listItem.add(saleDetail);
                              }
                              var userId=await FlutterSession().get("id");
                              Sale sale=new Sale(Cart.totalAmount(),userId,List.from(listItem));
                              var body = jsonEncode(sale);
                              print(body);
                              Cart.Post(context, "/api/v1/sale/", body);
                             setState(() {
                               Cart.listCart.clear();
                             });
                            },
                            child: Text(
                              "Check Out",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            color: Colors.green,
                          )),
                    ],
                  )
                ],
              ),
            )));
  }
}
