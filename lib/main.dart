import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/count.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'providers/cart.dart';
import 'screens/admin_screens/adminsignup.dart';
import 'screens/admin_screens/manage_products_screen.dart';
import 'screens/admin_screens/products_overview_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/login.dart';
import 'screens/orders_screen.dart';
import 'screens/splash%20screen.dart';
import 'screens/superadminscreen.dart';
import 'screens/user_screens/commander_screen.dart';
import 'screens/user_screens/user_products_overview_screen.dart';
import 'screens/user_screens/usersingup.dart';

import 'package:google_fonts/google_fonts.dart';
import 'screens/admin_screens/edit_order.dart';
import 'screens/admin_screens/edit_product_screen.dart';
import 'screens/admin_screens/manage_admins.dart';
import 'screens/admin_screens/manage_orders.dart';
import 'screens/user_screens/navigation_screen.dart';

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
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kagu',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            // Here we set DM Sans as our default fonts
            // Now we also apply out text color to all flutter textTheme
            textTheme: GoogleFonts.dmSansTextTheme()
                .apply(displayColor: Color(0xFF171717)),
            // Almost all of our app bar have this style
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0,
              brightness: Brightness.light,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
          routes: {
            '/superadmin-screen': (ctx) => SuperAdminScreen(),
            '/user-signup': (ctx) => SingupScreen(),
            '/login': (ctx) => LoginScreen(),
            '/admin-signup': (ctx) => AdminSignup(),
            UserProductsOverviewScreen.routeName: (ctx) =>
                UserProductsOverviewScreen(),
            ManageProductsScreen.routeName: (ctx) => ManageProductsScreen(''),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            ProductsOverwiewScreen.routeName: (ctx) => ProductsOverwiewScreen(),
            DetailsScreen.routeName: (ctx) => DetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            CommanderScreen.routeName: (ctx) => CommanderScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            NavigationScreenUser.routeName: (ctx) => NavigationScreenUser(0),
            ManageAdmins.routeName: (ctx) => ManageAdmins(),
            ManageOrders.routeName: (ctx) => ManageOrders(),
            EditOrder.routeName: (ctx) => EditOrder(null),
          }),
    );
  }
}
