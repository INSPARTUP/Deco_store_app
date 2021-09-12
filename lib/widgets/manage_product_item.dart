import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/screens/admin_screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class ManageProductItem extends StatefulWidget {
  final String id;
  final String nom;
  final String imageurl;
  bool archived;
  ManageProductItem(this.id, this.nom, this.imageurl, this.archived);

  @override
  _ManageProductItemState createState() => _ManageProductItemState();
}

class _ManageProductItemState extends State<ManageProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(children: [
        Text(widget.nom),
        Row(
          children: [
            IconButton(
              icon: Icon(
                  widget.archived ? Icons.archive : Icons.archive_outlined),
              onPressed: () {
                widget.archived
                    ? Provider.of<Products>(context, listen: false)
                        .archiver(widget.id, false)
                    : Provider.of<Products>(context, listen: false)
                        .archiver(widget.id, true);

                setState(() {
                  widget.archived = !widget.archived;
                });
                print(widget.archived);
              },
              color: widget.archived ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: widget.id);
              },
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(widget.archived
                  ? Icons.delete
                  : Icons.delete_outline_outlined),
              onPressed: () {
                widget.archived
                    ? SweetAlertV2.show(context,
                        subtitle:
                            'êtes-vous sûr de vouloir supprimer ce produit ?',
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
                              .deleteProduct(widget.id)
                              .then((value) => SweetAlertV2.show(context,
                                  subtitle: "Succés!",
                                  style: SweetAlertV2Style.success));
                        } else {
                          SweetAlertV2.show(context,
                              subtitle: "Annulé!",
                              style: SweetAlertV2Style.error);
                        }

                        // return false to keep dialog
                        return false;
                      })
                    : null;
              },
              color:
                  widget.archived ? Theme.of(context).errorColor : Colors.grey,
            ),
          ],
        )
      ]),
      leading: CircleAvatar(
        //circle avatar will do the sizing and so on to size the image into itself
        backgroundImage: NetworkImage(widget.imageurl),
      ),
      /*  trailing: Container(
        width: 60,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: widget.id);
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
                        .deleteProduct(widget.id)
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
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),*/
    );
  }
}
