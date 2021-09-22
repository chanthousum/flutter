import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:pos_flutter/login.dart';
import 'package:pos_flutter/main.dart';
import 'package:pos_flutter/models/cart.dart';
import 'package:pos_flutter/models/category.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:pos_flutter/models/product.dart';
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
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: MyDrawer(context),
      body: _myCategoryList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CategoryForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget _myCategoryList(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, index) {
              return Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://rukminim1.flixcart.com/image/332/398/kmwcuq80/shoe/w/u/s/7-444-gry-org-bruton-orange-original-imagfp7fzz5ftzfc.jpeg?q=50"),
                      radius: 40,
                    ),
                    SizedBox(width:20,),
                    Text("Show\n12",style:TextStyle(fontSize:16,fontWeight:FontWeight.bold),),
                    SizedBox(width:50,),
                    IconButton(onPressed:(){},icon:Icon(Icons.remove_circle),),
                    Text("0",style:TextStyle(fontSize:16,fontWeight:FontWeight.bold)),
                    IconButton(onPressed:(){

                    },icon:Icon(Icons.add_circle),),
                  ]
              );
            }),

      ),
    );
  }

}

