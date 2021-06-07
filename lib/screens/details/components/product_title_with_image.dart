import 'package:Deco_store_app/providers/product.dart';
import 'package:flutter/material.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*    Hero(
                tag: "${product.id}",
                child: Image.network(
                  product.imageurl,
                  fit: BoxFit.fill,
                )),
            SizedBox(height: 10),
*/
            /*   Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Prix\n"),
                      TextSpan(
                        text: "${product.prix} DA",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  product.type,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  product.nom,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            )
*/
          ],
        ),
      ),
    );
  }
}
