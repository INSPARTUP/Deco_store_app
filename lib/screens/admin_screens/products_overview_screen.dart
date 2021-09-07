import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'admin_details_screen.dart';
import 'manage_products_screen.dart';

enum FilterOptions { Favorites, All }

class ProductsOverwiewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _ProductsOverwiewScreenState createState() => _ProductsOverwiewScreenState();
}

class _ProductsOverwiewScreenState extends State<ProductsOverwiewScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false; // bach ydir hadik l khadma ghi l khatra lawla
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
        context); //we add <>to let it know which type of data you actually want to listening to.

    final List<Color> clr = [Colors.red, Colors.green, Colors.blue];
    final names = ['Tous Les Produits', 'Armoires', 'Lits'];
    final types = ['', 'armoire', 'lit'];
    final icons = [
      'lib/assets/icons/house.svg',
      'lib/assets/icons/wardrobe.svg',
      'lib/assets/icons/bed.svg'
    ];
    final productsList = [
      productData.items,
      productData.items
          .where((pr) => pr.nom.toLowerCase().contains('armoire'))
          .toList(),
      productData.items
          .where((pr) => pr.nom.toLowerCase().contains('lit'))
          .toList(),
    ];

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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2,
                childAspectRatio: 1,
              ),
              itemCount: 3,
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ManageProductsScreen(types[i]);
                    }),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(left: 12),
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  decoration: BoxDecoration(
                    color: clr[i],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        icons[i],
                        width: 100,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        names[i],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text('Le Nombre est: ${productsList[i].length}',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
