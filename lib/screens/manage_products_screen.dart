import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/screens/edit_product_screen.dart';
import 'package:Deco_store_app/widgets/app_drawer.dart';
import 'package:Deco_store_app/widgets/manage_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
    // the ovewall methode will only be doneonce this is done and only when this Future which is automatically returned will yield (resolve)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Produits'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        //with the FutureBuilder,we will fetch data when (future: _refreshProducts(context),) load
        future: _refreshProducts(context),
        builder: (ctx, snapshot /*like response */) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              ManageProductItem(
                                productsData.items[i].id,
                                productsData.items[i].nom,
                                productsData.items[i].imageurl,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
