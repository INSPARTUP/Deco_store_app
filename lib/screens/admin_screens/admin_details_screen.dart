import 'package:deco_store_app/providers/product.dart';
import 'package:deco_store_app/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminDetailsScreen extends StatefulWidget {
  static const routeName = '/admin-details-screen';

  @override
  _AdminDetailsScreenState createState() => _AdminDetailsScreenState();
}

class _AdminDetailsScreenState extends State<AdminDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final products = ModalRoute.of(context).settings.arguments as List<Product>;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              "lib/assets/icons/menu.svg",
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        title: Text(' Produits', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) => Column(
          children: [
            ManageProductItem(
              products[i].id,
              products[i].nom,
              products[i].quantite,
              products[i].prix,
              products[i].imageurl,
              products[i].archived,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
