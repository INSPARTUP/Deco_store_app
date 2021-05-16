import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/screens/admin_screens/adminhome.dart';
import 'package:Deco_store_app/screens/admin_screens/adminsignup.dart';
import 'package:Deco_store_app/screens/edit_product_screen.dart';
import 'package:Deco_store_app/screens/login.dart';
import 'package:Deco_store_app/screens/manage_products_screen.dart';
import 'package:Deco_store_app/screens/products_overview_screen.dart';
import 'package:Deco_store_app/screens/superadminscreen.dart';
import 'package:Deco_store_app/screens/user_screens/usersingup.dart';
import 'package:Deco_store_app/screens/user_screens/userhome.dart';
import 'package:Deco_store_app/screens/product_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          create: (ctx) => Products(),
          //madarnach ta3 value psq hna radi ndiro instantiation (create) ta3 Product()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverwiewScreen(),
        routes: {
          '/user-screen': (ctx) => UserHome(),
          '/admin-screen': (ctx) => AdminHome(),
          '/superadmin-screen': (ctx) => SuperAdminScreen(),
          '/user-signup': (ctx) => SingupScreen(),
          '/login': (ctx) => LoginScreen(),
          '/admin-signup': (ctx) => AdminSignup(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          ProductsOverwiewScreen.routeName: (ctx) => ProductsOverwiewScreen(),
        },
      ),
    );
  }
}
