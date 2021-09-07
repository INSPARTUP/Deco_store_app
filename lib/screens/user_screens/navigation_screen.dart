import 'package:deco_store_app/screens/user_screens/user_products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../cart_screen.dart';
import '../cherche_screen.dart';
import '../orders_screen.dart';

class NavigationScreenUser extends StatefulWidget {
  static const routeName = '/nav-user';
  int selectedIndex;

  NavigationScreenUser(this.selectedIndex);
  @override
  _NavigationScreenUserState createState() => _NavigationScreenUserState();
}

class _NavigationScreenUserState extends State<NavigationScreenUser> {
  final screens = [
    UserProductsOverviewScreen(),
    CartScreen(),
    ChercheScreen(),
    OrdersScreen()
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
              icon: Icon(Icons.shopping_cart),
              title: Text("Panier"),
              selectedColor: Colors.white,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Recherche"),
              selectedColor: Colors.white,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.card_giftcard),
              title: Text("Commande"),
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),

      // First Navigation Bar
      /* bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Accueil',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Panier',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Recherche',
                  textStyle: TextStyle(fontSize: 11.5),
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),  */
    );
  }
}
