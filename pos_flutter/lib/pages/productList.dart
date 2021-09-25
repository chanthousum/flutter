import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:pos_flutter/login.dart';
import 'package:pos_flutter/main.dart';
import 'package:pos_flutter/models/category.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:pos_flutter/models/product.dart';
import 'package:pos_flutter/pages/categoryEditForm.dart';
import 'dart:convert';
import 'package:pos_flutter/pages/categoryForm.dart';
import 'package:pos_flutter/pages/productDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Product>> getProductAll(BuildContext context) async {
  try {
    Categorys.checkRefreshToken(context);
    var access = await FlutterSession().get("accessToken");
    var endpoint = Uri.parse("${Categorys.serverIp}/api/v1/product/");
    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$access',
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      return jsonResponse.map((data) => new Product.fromJson(data)).toList();
    } else {
      return Future.error("Server Error");
    }
  } catch (SocketException) {
    return Future.error("Error get data");
  }
}

class ProductList extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getProductAll(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
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
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<List<Product>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product>? data = snapshot.data;
                return Container(
                    child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 150,
                              child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                      leading: Image.asset("assets/2.png"),
                                      title: Text(
                                        "${data[index].name.toString() + "\n" + data[index].unitPrice.toString()}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onTap: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ProductDetail(data[index]);
                                        }));
                                      })));
                        }));
              } else if (snapshot.hasError) {
                return Text("not Record");
              }
              // By default show a loading spinner.
              return CircularProgressIndicator();
            },
          )),
    );
  }
}
