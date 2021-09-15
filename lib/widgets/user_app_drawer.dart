import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:deco_store_app/screens/profile_screen.dart';
import 'package:deco_store_app/screens/user_screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UserAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nom = Provider.of<Auth>(context, listen: false).nom;
    final prenom = Provider.of<Auth>(context, listen: false).prenom;

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 130.0,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: SvgPicture.asset('lib/assets/icons/Logo.svg',
                  color: Colors.white),
            ),
          ),
          Align(
            child: Column(
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("      Bonjour,",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Arial",
                      )),
                ),
                Text(nom + ' ' + prenom + ' ',
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(),
          ListTile(
            leading: Icon(Icons.chair),
            title: Text('Produits'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NavigationScreenUser(0);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Mon Panier'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NavigationScreenUser(1);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Mes Commandes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NavigationScreenUser(3);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Recherche'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NavigationScreenUser(2);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Déconnecter'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Cart>(context, listen: false).vider = '';
              Provider.of<Auth>(context, listen: false).logout(context);

              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
