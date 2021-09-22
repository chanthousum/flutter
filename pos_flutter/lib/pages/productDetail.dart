import 'package:flutter/material.dart';
import 'package:pos_flutter/models/model.dart';

class ProductDetail extends StatelessWidget {
  final ProductItem product;
  ProductDetail(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Name :${product.prouctName}"),
          centerTitle: true,
          actions: [],
        ),
        body: Column(
          children: [
            Image(image: NetworkImage(product.photo)),
            SizedBox(
              height: 10.0,
            ),
            Text("Name :${product.prouctName}")
          ],
        ));
  }
}
