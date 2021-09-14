import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/screens/admin_screens/edit_product_screen.dart';
import 'package:deco_store_app/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:deco_store_app/widgets/bar_widget.dart';

enum Choice {
  all,
  archived,
  disarchived,
}

class ManageProductsScreen extends StatefulWidget {
  static const routeName = '/manage-products';
/*
  List<Product> products;
  ManageProductsScreen(products);
  */

  String type;
  ManageProductsScreen(this.type);

  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  String rech;

  List<String> labels = ["Tous", "Archivés", "Non Archivés"];
  int currentIndex = 0;
  var ch = Choice.all;
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
        elevation: 8.5,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              "lib/assets/icons/arrow-long-left.svg",
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(),
        child: Consumer<Products>(
          builder: (ctx, productsData, _) => Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                ToggleBar(
                  labels: labels,
                  backgroundColor: Colors.grey[800],
                  selectedTabColor: Colors.blue,
                  onSelectionUpdated: (index) => setState(() {
                    currentIndex = index;
                    if (index == 0)
                      ch = Choice.all;
                    else if (index == 1)
                      ch = Choice.archived;
                    else if (index == 2) ch = Choice.disarchived;
                  }),
                ),
                Divider(color: Colors.black),
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
                              .where((pr) =>
                                  pr.type.toLowerCase().contains(widget.type))
                              .toList()
                              .length ==
                          0
                      ? Center(
                          child: Text(
                            "il n'existe aucun produit ",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: ch == Choice.all
                              ? productsData.items
                                  .where((pr) => pr.type
                                      .toLowerCase()
                                      .contains(widget.type))
                                  .toList()
                                  .length
                              : ch == Choice.archived
                                  ? productsData.archivedItems
                                      .where((pr) => pr.type
                                          .toLowerCase()
                                          .contains(widget.type))
                                      .toList()
                                      .length
                                  : ch == Choice.disarchived
                                      ? productsData.disarchivedItems
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()
                                          .length
                                      : productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()
                                          .length,
                          addAutomaticKeepAlives: true,
                          cacheExtent: 100000000.0,
                          itemBuilder: (_, i) => Column(
                            children: [
                              ch == Choice.all
                                  ? ManageProductItem(
                                      productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()[i]
                                          .id,
                                      productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()[i]
                                          .nom,
                                      productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()[i]
                                          .quantite,
                                      productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()[i]
                                          .prix,
                                      productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()[i]
                                          .imageurl,
                                      productsData.items
                                          .where((pr) => pr.type
                                              .toLowerCase()
                                              .contains(widget.type))
                                          .toList()[i]
                                          .archived,
                                    )
                                  : ch == Choice.archived
                                      ? ManageProductItem(
                                          productsData.archivedItems
                                              .where((pr) => pr.type
                                                  .toLowerCase()
                                                  .contains(widget.type))
                                              .toList()[i]
                                              .id,
                                          productsData.archivedItems
                                              .where((pr) => pr.type
                                                  .toLowerCase()
                                                  .contains(widget.type))
                                              .toList()[i]
                                              .nom,
                                          productsData.archivedItems
                                              .where((pr) => pr.type
                                                  .toLowerCase()
                                                  .contains(widget.type))
                                              .toList()[i]
                                              .quantite,
                                          productsData.archivedItems
                                              .where((pr) => pr.type
                                                  .toLowerCase()
                                                  .contains(widget.type))
                                              .toList()[i]
                                              .prix,
                                          productsData.archivedItems
                                              .where((pr) => pr.type
                                                  .toLowerCase()
                                                  .contains(widget.type))
                                              .toList()[i]
                                              .imageurl,
                                          productsData.archivedItems
                                              .where((pr) => pr.type
                                                  .toLowerCase()
                                                  .contains(widget.type))
                                              .toList()[i]
                                              .archived,
                                        )
                                      : ch == Choice.disarchived
                                          ? ManageProductItem(
                                              productsData.disarchivedItems
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .id,
                                              productsData.disarchivedItems
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .nom,
                                              productsData.disarchivedItems
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .quantite,
                                              productsData.disarchivedItems
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .prix,
                                              productsData.disarchivedItems
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .imageurl,
                                              productsData.disarchivedItems
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .archived,
                                            )
                                          : ManageProductItem(
                                              productsData.items
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .id,
                                              productsData.items
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .nom,
                                              productsData.items
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .quantite,
                                              productsData.items
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .prix,
                                              productsData.items
                                                  .where((pr) => pr.type
                                                      .toLowerCase()
                                                      .contains(widget.type))
                                                  .toList()[i]
                                                  .imageurl,
                                              productsData.items
                                                  .where((pr) => pr.type
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
    );
  }
}
