import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:pos_flutter/login.dart';
import 'package:pos_flutter/models/cart.dart';
import 'package:pos_flutter/pages/cartList.dart';
import 'package:pos_flutter/pages/categoryForm.dart';
import 'package:pos_flutter/pages/categoryList.dart';
import 'package:pos_flutter/pages/productList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(
    MaterialApp(
      // home: Login(),

      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => MyApp(),
        '/categoryList': (context) => CategoryList(),
        '/categoryForm': (context) => CategoryForm(),
        '/productList': (context) => ProductList(),
        '/cart': (context) => CartList(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fashion App"),
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
      body: myHomeScreen(context),
      drawer: MyDrawer(context),
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () {}, child: Icon(Icons.navigation)),
    );
  }
}

Widget myHomeScreen(BuildContext context) {
  return Container(
    color:Color.fromRGBO(2, 68, 102, 1),
    padding: EdgeInsets.all(10),
    child: GridView.count(
      crossAxisCount: 3,
      // crossAxisSpacing: 4.0,
      // mainAxisSpacing: 8.0,
      children: [
        myBox(context, Icons.shopping_cart, "Shopping Cart", "/productList"),
        myBox(context, Icons.phone, "Category List", "/categoryList"),
        myBox(context, Icons.supervised_user_circle_outlined, "Category List", "/categoryList")
      ],
    ),
  );
}

myBox(BuildContext context, IconData myIcon, String text, String routeName) {
  return Card(
      // decoration:
      //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child:Container(child: Center(
          child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context,"${routeName}");
                },
                icon: Icon(
                  myIcon,
                  size: 70,
                  color:Colors.teal,
                )),
          ),
        ],
      ),
      SizedBox(
        height: 30,
      ),
      Row(
        children: [
          Expanded(
            child: Align(alignment: Alignment.center, child: Text("${text}",style:TextStyle(color:Colors.teal),)),
          ),
        ],
      )
    ],
  ))));
}

Widget MyDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.red),
          accountName: Text("sum chanthou"),
          accountEmail: Text("chanthousum2017@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(
              "A",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, "/home");
          },
        ),
        ListTile(
          leading: Icon(Icons.accessible_sharp),
          title: Text("Category List"),
          onTap: () {
            Navigator.pushNamed(context, "/categoryList");
          },
        ),
        ListTile(
          leading: Icon(Icons.accessible_sharp),
          title: Text("Product List"),
          onTap: () {
            Navigator.pushNamed(context, "/productList");
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text("Sing Out"),
          onTap: () async {
            Navigator.pushNamed(context, "/");
            await FlutterSession().set("accessToken", "");
          },
        ),
      ],
    ),
  );
}
