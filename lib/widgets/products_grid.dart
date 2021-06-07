import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/widgets/ProductItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
        context); //we add <>to let it know which type of data you actually want to listening to.
    final products = productData.items;

    //.reversed.toList();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //number of columns
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      addAutomaticKeepAlives: true,
      cacheExtent: 100000000.0,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (ctx) => products[i], madarnach hadi psq products[i] already existing, manas7a9och ndiro create (instantiatin) l products[i]
        //using value is the right approach you should use if you for example use a provider on something that's part of a list or a grid
        value: products[i],
        //darna kol product ro7ah bach kol wa7ad ywali 3andah provider (w kol wa7ad dayar ta3 isFavorite ta3ah)
        //mana7toch n3awdo ndiro re instantiate product objects psq sayi darnaha f Products class
        //return single product item as it's store in the products class

        child: ProductItem(),
      ),
    );
  }
}
