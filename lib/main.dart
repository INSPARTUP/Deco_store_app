import 'package:Deco_store_app/screens/admin_screens/adminhome.dart';
import 'package:Deco_store_app/screens/admin_screens/adminsignup.dart';
import 'package:Deco_store_app/screens/login.dart';
import 'package:Deco_store_app/screens/superadminscreen.dart';
import 'package:Deco_store_app/screens/user_screens/usersingup.dart';
import 'package:Deco_store_app/screens/user_screens/userhome.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        '/user-screen': (ctx) => UserHome(),
        '/admin-screen': (ctx) => AdminHome(),
        '/superadmin-screen': (ctx) => SuperAdminScreen(),
        '/user-signup': (ctx) => SingupScreen(),
        '/login': (ctx) => LoginScreen(),
        '/admin-signup': (ctx) => AdminSignup(),
      },
    );
  }
}
