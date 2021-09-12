import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/admin_screens/admin_navigation_screen.dart';
import 'package:deco_store_app/screens/admin_screens/manage_orders.dart';
import 'package:deco_store_app/screens/admin_screens/manage_products_screen.dart';
import 'package:deco_store_app/screens/admin_screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nom = Provider.of<Auth>(context, listen: false).nom;
    final prenom = Provider.of<Auth>(context, listen: false).prenom;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 70,
          ),
          const Center(
            child: Image(
              width: 120,
              image: AssetImage(
                'lib/assets/images/Logo.png',
              ),
            ),
          ),
          Align(
            child: Column(
              children: [
                Divider(),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("      Bonjour,",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Arial",
                          fontWeight: FontWeight.bold)),
                ),
                Text(nom + ' ' + prenom,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 140,
            height: 2,
            color: Colors.grey[200],
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Accueil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AdminNavigationScreen(0);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gestion des Produits'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AdminNavigationScreen(1);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('Gérer les Commandes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AdminNavigationScreen(3);
                }),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();

              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
