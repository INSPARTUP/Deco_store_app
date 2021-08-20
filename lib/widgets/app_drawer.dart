import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/admin_screens/manage_products_screen.dart';
import 'package:deco_store_app/screens/admin_screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
                Text("Bonjour,"),
                Text(
                  nom + ' ' + prenom,
                )
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
            title: Text('Produits'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverwiewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gestion des Produits'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageProductsScreen.routeName);
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
