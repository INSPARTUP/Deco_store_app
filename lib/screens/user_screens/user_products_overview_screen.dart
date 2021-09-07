import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/widgets/products_grid.dart';
import 'package:deco_store_app/widgets/user_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../cart_screen.dart';
import 'navigation_screen.dart';

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

  int _selectedIndex = 0;

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
        title: Text(' Accueil', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "lib/assets/icons/cart.svg",
              color: Colors.black,
            ),
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
