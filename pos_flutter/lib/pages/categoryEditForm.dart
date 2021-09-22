import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pos_flutter/login.dart';
import 'package:pos_flutter/main.dart';
import 'package:pos_flutter/models/category.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pos_flutter/pages/categoryList.dart';

class CategoryEditForm extends StatefulWidget {
  // const CategoryEditForm({Key? key}) : super(key: key);
  final Categorys c;
  CategoryEditForm(this.c);
  @override
  _CategoryEditFormState createState() => _CategoryEditFormState(c);
}

class _CategoryEditFormState extends State<CategoryEditForm> {
  final Categorys c;
  _CategoryEditFormState(this.c);
  TextEditingController categoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    categoryController.text = c.name;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Edit Form"),
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
            child: Text("Update"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Categorys category =
                    Categorys(name: categoryController.text);
                var body = json.encode(category.toJson());
                final c=await Categorys.updateById(context,"/api/v1/category/",body,widget.c.id);
              }
            },
          )
        ]));
  }
}
