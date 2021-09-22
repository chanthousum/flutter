import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_flutter/login.dart';
import 'package:pos_flutter/main.dart';
import 'package:pos_flutter/models/category.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:pos_flutter/pages/categoryList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({Key? key}) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  TextEditingController categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //
  // Future<Categorys> createCategory(String body) async {
  //   var endpoint = Uri.parse("${Categorys.serverIp}/api/category");
  //   final response = await http.post(endpoint,
  //       body: body, headers: {"Content-Type": "application/json"});
  //   if (response.statusCode == 200) {
  //     return Categorys.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Form"),
        backgroundColor:Colors.red,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon:Icon(Icons.search_rounded,color:Colors.white,)),
          IconButton(onPressed: (){}, icon:Icon(Icons.shopping_cart))
        ],
      ),
      drawer: MyDrawer(context),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: _myForm(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CategoryList()));
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _myForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
              controller: categoryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CategoryName',
                  hintText: "CategoryName"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            child: Text("Create"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Categorys category =
                    Categorys(id: 1, name: categoryController.text);
                var body = json.encode(category.toJson());
                var category1 = await Categorys.Post(context,"/api/v1/category/", body);
              }
            },
          )
        ]));
  }
}
