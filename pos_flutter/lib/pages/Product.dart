import 'package:flutter/material.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:pos_flutter/pages/productDetail.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list=ProductItem.generate();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        centerTitle: true,
        actions: [],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount:list.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 100,
                  child: Card(
                      child: ListTile(
                    leading:CircleAvatar(backgroundImage:NetworkImage(list[index].photo),radius:50,),
                    title: Text("${list[index].prouctName}"),
                        onTap:(){
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                             return ProductDetail(list[index]);
                           }));
                        },
                  )));
            },
          ),
        ),
      ),
    );
  }
}
