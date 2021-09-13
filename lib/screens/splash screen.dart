import 'dart:async';
import 'dart:ui';
import 'package:deco_store_app/screens/admin_screens/admin_navigation_screen.dart';
import 'package:deco_store_app/screens/user_screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/login.dart';
import 'package:deco_store_app/screens/superadminscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
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
                Color(0xFF45A8F2),
                Color(0xFF45A8F2),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  "lib/assets/icons/Logo.svg",
                  color: Colors.white,
                ),
                /*Image.asset(
                  "lib/assets/images/Logo.png",
                  height: 300.0,
                  width: 300.0,
                ),*/
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
            /*   CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),*/
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
                  ? NavigationScreenUser(0)
                  : (auth.roles == 'ROLE_ADMIN')
                      ? AdminNavigationScreen(0)
                      : (auth.roles == 'ROLE_SUPER-ADMIN')
                          ? SuperAdminScreen()
                          : NavigationScreenUser(0))
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
