import 'package:flutter/material.dart';
import 'package:pos_flutter/models/cart.dart';
import 'package:pos_flutter/models/model.dart';
import 'package:pos_flutter/models/product.dart';

import '../main.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail(this.product);

  // const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Detail"),
          centerTitle: true,
          backgroundColor: Colors.red,
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
        body: Center(
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Image.network(
                                "https://rukminim1.flixcart.com/image/332/398/kmwcuq80/shoe/w/u/s/7-444-gry-org-bruton-orange-original-imagfp7fzz5ftzfc.jpeg?q=50")),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${product.name} ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${product.unitPrice}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: FlatButton(
                          onPressed: () {
                            Cart cart = new Cart();
                            cart.addCart(product.id,product.name, product.unitPrice);
                          },
                          child: Text(
                            "Add Qty",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Colors.red,
                        )),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_shopping_cart),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border),
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
