import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/login.dart';
import 'package:deco_store_app/screens/superadminscreen.dart';
import 'package:deco_store_app/screens/user_screens/user_products_overview_screen.dart';
import 'package:deco_store_app/screens/admin_screens/products_overview_screen.dart';

import 'admin_screens/products_overview_screen.dart';

/*
void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(),
    );
  }
}
*/
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF0c64f6),
                Color(0xFF0c64a7),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "lib/assets/images/Logo.png",
                  height: 300.0,
                  width: 300.0,
                ),
                Text(
                  "Bienvenue Dans Notre Magasin",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, child
              /* nakhadmo b child ki ykon 3adna widget dakhal Consumer manach baghyin ndirolha rebuild*/
              ) =>
          auth.isAuth
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
    );
  }
}
