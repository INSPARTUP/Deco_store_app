import 'package:Deco_store_app/providers/auth.dart';
import 'package:Deco_store_app/providers/cart.dart';
import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/widgets/products_grid.dart';
import 'package:Deco_store_app/widgets/user_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../cart_screen.dart';

class UserProductsOverviewScreen extends StatefulWidget {
  static const routeName = "/user-products-overview-screen";

  @override
  _UserProductsOverviewScreenState createState() =>
      _UserProductsOverviewScreenState();
}

class _UserProductsOverviewScreenState
    extends State<UserProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

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
    final email = Provider.of<Auth>(
      context,
    ).email;
    Provider.of<Cart>(context, listen: false).fetchCart(email);
    _isInit = false; // bach ydir hadik l khadma ghi l khatra lawla
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //  final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(' Produits'),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("lib/assets/icons/cart.svg"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CartScreen();
                }),
              );
            },
          ),
          SizedBox(width: 5)
        ],
      ),
      drawer: UserAppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
