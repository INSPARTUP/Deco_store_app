import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/screens/admin_screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

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
                SweetAlertV2.show(context,
                    subtitle: 'êtes-vous sûr de vouloir supprimer ce produit ?',
                    subtitleTextAlign: TextAlign.center,
                    style: SweetAlertV2Style.confirm,
                    cancelButtonText: 'Annuler',
                    confirmButtonText: 'Confirmer',
                    showCancelButton: true, onPress: (bool isConfirm) {
                  if (isConfirm) {
                    SweetAlertV2.show(context,
                        subtitle: "Suppression...",
                        style: SweetAlertV2Style.loading);
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(id)
                        .then((value) => SweetAlertV2.show(context,
                            subtitle: "Succés!",
                            style: SweetAlertV2Style.success));
                  } else {
                    SweetAlertV2.show(context,
                        subtitle: "Annulé!", style: SweetAlertV2Style.error);
                  }

                  // return false to keep dialog
                  return false;
                });
                /*     showDialog<Null>(
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
           
           */
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
