import 'package:deco_store_app/providers/product.dart';
import 'package:flutter/material.dart';

import 'add_to_cart.dart';
import 'counter_with_fav_btn.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /*    Container(
            height: 300,
            width: double.infinity,
            child: Hero(
                tag: "${product.id}",
                child: Image.network(
                  product.imageurl,
                  fit: BoxFit.fill,
                )),
          ),  */
//SizedBox(
          //   height: size.height,
          //  height: 500,
          // child:
          SingleChildScrollView(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  height: product.description.length == 0
                      ? 800
                      : product.description.length * 0.25 + 800.0,
                  width: double.infinity,
                ),
                Positioned(
                  top: 0,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    child: Hero(
                        tag: "${product.id}",
                        child: Image.network(
                          product.imageurl,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Positioned(
                  top: 280,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    //   margin: EdgeInsets.only(top: size.height * 0.3),
                    // height: 900,
                    height: product.description.length == 0
                        ? 520
                        : product.description.length * 10000 + 120.0,
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 10,
                      right: 10,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),

                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.nom,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Type:  ${product.type}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FittedBox(
                              child: Text(
                                "Description:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Description(product: product),
                          ],
                        ),
                        Row(
                          children: [
                            CounterWithFavBtn(),
                            SizedBox(
                              width: 60,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Prix\n"),
                                  TextSpan(
                                    text: "\$${product.prix}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10 / 2),
                        AddToCart(product: product, ctx: context),
                      ],
                    ),
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
