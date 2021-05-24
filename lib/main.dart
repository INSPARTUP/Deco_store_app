import 'package:Deco_store_app/models/userdata.dart';
import 'package:Deco_store_app/providers/auth.dart';
import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/screens/admin_screens/adminhome.dart';
import 'package:Deco_store_app/screens/admin_screens/adminsignup.dart';
import 'package:Deco_store_app/screens/edit_product_screen.dart';
import 'package:Deco_store_app/screens/login.dart';
import 'package:Deco_store_app/screens/manage_products_screen.dart';
import 'package:Deco_store_app/screens/products_overview_screen.dart';
import 'package:Deco_store_app/screens/splash%20screen.dart';
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
            create: (ctx) => Auth(),
          ),

          ChangeNotifierProvider(
            create: (ctx) => Products(),
            //madarnach ta3 value psq hna radi ndiro instantiation (create) ta3 Product()
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
                          ? UserHome()
                          : (auth.roles == 'ROLE_ADMIN')
                              ? ProductsOverwiewScreen()
                              : (auth.roles == 'ROLE_SUPER-ADMIN')
                                  ? SuperAdminScreen()
                                  : UserHome())
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
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                ProductsOverwiewScreen.routeName: (ctx) =>
                    ProductsOverwiewScreen(),
              }),
        ));
  }
}
