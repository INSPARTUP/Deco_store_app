import 'package:deco_store_app/screens/admin_screens/manage_admins.dart';
import 'package:deco_store_app/screens/admin_screens/manage_orders.dart';
import 'package:deco_store_app/screens/admin_screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'home_screen.dart';
import 'super_admin_home.dart';

class SuperAdminNavigation extends StatefulWidget {
  static const routeName = '/nav-superAdmin';
  int selectedIndex;

  SuperAdminNavigation(this.selectedIndex);

  @override
  _SuperAdminNavigationState createState() => _SuperAdminNavigationState();
}

class _SuperAdminNavigationState extends State<SuperAdminNavigation> {
  final screens = [
    SuperAdminHome(),
    ProductsOverwiewScreen(),
    ManageOrders(),
    ManageAdmins()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: widget.selectedIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF08090C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: SalomonBottomBar(
          unselectedItemColor: Color(0xFFE4E5E5),
          itemPadding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
          currentIndex: widget.selectedIndex,
          onTap: (int x) {
            setState(() {
              widget.selectedIndex = x;
            });
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Accueil"),
              selectedColor: Colors.white,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.edit),
              title: Text("Produits"),
              selectedColor: Colors.white,
            ),

            /// Order

            SalomonBottomBarItem(
              icon: Icon(Icons.card_giftcard),
              title: Text("Commandes"),
              selectedColor: Colors.white,
            ),

            /// Profile

            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Admins"),
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
