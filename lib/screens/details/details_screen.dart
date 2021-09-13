import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:deco_store_app/providers/product.dart';
import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/screens/user_screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../cart_screen.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  static const routeName = '/product-detail';

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final role = Provider.of<Auth>(context, listen: false).roles;

    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      // each product have a color
      backgroundColor: Colors.blueGrey,
      appBar: buildAppBar(context),
      body: Body(product: loadedProduct),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final email = Provider.of<Auth>(
      context,
    ).email;
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Text('Details'),
      actions: <Widget>[
        /*   IconButton(
          icon: Image.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),*/
        IconButton(
          icon: SvgPicture.asset("lib/assets/icons/cart.svg"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return NavigationScreenUser(1);
              }),
            );
          },
        ),
        SizedBox(width: 5)
      ],
    );
  }
}
