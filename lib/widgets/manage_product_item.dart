import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/screens/admin_screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductItem extends StatelessWidget {
  final String id;
  final String nom;
  final String imageurl;
  ManageProductItem(this.id, this.nom, this.imageurl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return ListTile(
      title: Text(nom),
      leading: CircleAvatar(
        //circle avatar will do the sizing and so on to size the image into itself
        backgroundImage: NetworkImage(imageurl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog<Null>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Confirmer la Suppression!'),
                    content:
                        Text('êtes-vous sûr de vouloir supprimer ce produit ?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Annuler'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Supprimer'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await Provider.of<Products>(context, listen: false)
                              .deleteProduct(id);
                        },
                      ),
                    ],
                  ),
                );
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
