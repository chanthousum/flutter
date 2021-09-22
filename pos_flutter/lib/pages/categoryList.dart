import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_flutter/login.dart';
import 'package:pos_flutter/main.dart';
import 'package:pos_flutter/models/category.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:http/http.dart' as http;
import 'package:pos_flutter/pages/categoryEditForm.dart';
import 'dart:convert';
import 'package:pos_flutter/pages/categoryForm.dart';
import 'package:flutter_session/flutter_session.dart';
Future<List<Categorys>> getCateggoryAll(BuildContext context) async {
  try {
    Categorys.checkRefreshToken(context);
    var access =await FlutterSession().get("accessToken");
    var endpoint = Uri.parse("${Categorys.serverIp}/api/v1/category/");
    var response = await http.get(endpoint, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$access',
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Categorys.fromJson(data)).toList();
    }  {
      return Future.error("Server Error");
    }
  } catch (SocketException) {
    return Future.error("Error get data");
  }
}

class CategoryList extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<Categorys>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getCateggoryAll(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Category View'),
          backgroundColor:Colors.red,
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){}, icon:Icon(Icons.search_rounded,color:Colors.white,)),
            IconButton(onPressed: (){}, icon:Icon(Icons.shopping_cart))
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
          child: FutureBuilder<List<Categorys>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Categorys>? data = snapshot.data;
                return Container(
                    child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              height: 100,
                              child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    trailing: FlatButton(
                                        onPressed: () {
                                          Categorys.deleteById(context,
                                              "/api/v1/category/", data[index].id);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    leading: Image.asset("assets/2.png"),
                                    title: Text(data[index].name.toString()),
                                    onTap: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CategoryEditForm(data[index]);
                                      }));
                                    },
                                  )));
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

myAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Delete"),
    content: Text("Are you want to delete record?"),
    // shape: CurveBorder(),
    actions: [
      FlatButton(
        onPressed: () {},
        child: Text("Yes"),
        color: Colors.black12,
      ),
      FlatButton(
        onPressed: () {},
        child: Text("No"),
        color: Colors.black12,
      )
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
