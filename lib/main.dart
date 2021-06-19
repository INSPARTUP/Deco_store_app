import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/count.dart';
import 'package:deco_store_app/providers/orders.dart';
import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:deco_store_app/screens/admin_screens/adminhome.dart';
import 'package:deco_store_app/screens/admin_screens/adminsignup.dart';
import 'package:deco_store_app/screens/admin_screens/manage_products_screen.dart';
import 'package:deco_store_app/screens/admin_screens/products_overview_screen.dart';
import 'package:deco_store_app/screens/cart_screen.dart';
import 'package:deco_store_app/screens/details/details_screen.dart';
import 'package:deco_store_app/screens/login.dart';
import 'package:deco_store_app/screens/orders_screen.dart';
import 'package:deco_store_app/screens/splash%20screen.dart';
import 'package:deco_store_app/screens/superadminscreen.dart';
import 'package:deco_store_app/screens/user_screens/commander_screen.dart';
import 'package:deco_store_app/screens/user_screens/user_products_overview_screen.dart';
import 'package:deco_store_app/screens/user_screens/usersingup.dart';
import 'package:deco_store_app/screens/user_screens/userhome.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/admin_screens/edit_product_screen.dart';
import 'screens/admin_screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ///hado maydiroch rebuild l UI psq homa mchi Listners. Listners rahom f screens lokhrin kima za3ma     final cart = Provider.of<Cart>(context);
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),

          ChangeNotifierProvider(
            create: (ctx) => Products(),
            //madarnach ta3 value psq hna radi ndiro instantiation (create) ta3 Product()
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
            //madarnach ta3 value psq hna radi ndiro instantiation (create) ta3 Product()
          ),
          ChangeNotifierProvider(
            create: (ctx) => Count(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, child
                  /* nakhadmo b child ki ykon 3adna widget dakhal Consumer manach baghyin ndirolha rebuild*/
                  ) =>
              MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: auth.isAuth
                      ? ((auth.roles == 'ROLE_USER')
                          ? UserProductsOverviewScreen()
                          : (auth.roles == 'ROLE_ADMIN')
                              ? ProductsOverwiewScreen()
                              : (auth.roles == 'ROLE_SUPER-ADMIN')
                                  ? SuperAdminScreen()
                                  : UserProductsOverviewScreen())
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : LoginScreen(),
                        ),
                  routes: {
                '/user-screen': (ctx) => UserHome(),
                '/admin-screen': (ctx) => AdminHome(),
                '/superadmin-screen': (ctx) => SuperAdminScreen(),
                '/user-signup': (ctx) => SingupScreen(),
                '/login': (ctx) => LoginScreen(),
                '/admin-signup': (ctx) => AdminSignup(),
                //     ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                UserProductsOverviewScreen.routeName: (ctx) =>
                    UserProductsOverviewScreen(),
                ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                ProductsOverwiewScreen.routeName: (ctx) =>
                    ProductsOverwiewScreen(),
                DetailsScreen.routeName: (ctx) => DetailsScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                CommanderScreen.routeName: (ctx) => CommanderScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
              }),
        ));
  }
}
