import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/screens/admin_screens/edit_product_screen.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:deco_store_app/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = '/manage-products';

  String type;
  ManageProductsScreen(this.type);
  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  String rech;
  Future<void> _refreshProducts() async {
    await Provider.of<Products>(context, listen: false).fetchProducts(rech);
    // the ovewall methode will only be doneonce this is done and only when this Future which is automatically returned will yield (resolve)
  }

  Function _recherche() {
    _refreshProducts();
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Liste des Produits',
            style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        //with the FutureBuilder,we will fetch data when (future: _refreshProducts(context),) load
        future: _refreshProducts(),
        builder: (ctx, snapshot /*like response */) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            FittedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: TextField(
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: 'Recherche',
                                      ),
                                      onChanged: (val) {
                                        rech = val;
                                      },
                                      //  onSubmitted:
                                      // _recherche(), //  hadi ida bghit ydir recherche directement
                                    ),
                                  ),
                                  TextButton(
                                    child: Container(
                                      height: 35.0,
                                      width: 110,
                                      child: Center(
                                        child: Text(
                                          'Rechercher',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: _recherche,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: productsData.items
                                          .where((pr) => pr.nom
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()
                                          .length ==
                                      0
                                  ? Center(
                                      child: Text(
                                        "il n'existe pas un produit avec ce nom ",
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: productsData.items
                                          .where((pr) => pr.nom
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()
                                          .length,
                                      addAutomaticKeepAlives: true,
                                      cacheExtent: 100000000.0,
                                      itemBuilder: (_, i) => Column(
                                        children: [
                                          ManageProductItem(
                                            productsData.items
                                                .where((pr) => pr.nom
                                                    .toLowerCase()
                                                    .contains(widget.type))
                                                .toList()[i]
                                                .id,
                                            productsData.items
                                                .where((pr) => pr.nom
                                                    .toLowerCase()
                                                    .contains(widget.type))
                                                .toList()[i]
                                                .nom,
                                            productsData.items
                                                .where((pr) => pr.nom
                                                    .toLowerCase()
                                                    .contains(widget.type))
                                                .toList()[i]
                                                .imageurl,
                                            productsData.items
                                                .where((pr) => pr.nom
                                                    .toLowerCase()
                                                    .contains(widget.type))
                                                .toList()[i]
                                                .archived,
                                          ),
                                          Divider(),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
