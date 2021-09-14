import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/screens/admin_screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class ManageProductItem extends StatefulWidget {
  final String id;
  final String nom;
  final int quantite;
  final int prix;
  final String imageurl;
  bool archived;
  ManageProductItem(this.id, this.nom, this.quantite, this.prix, this.imageurl,
      this.archived);

  @override
  _ManageProductItemState createState() => _ManageProductItemState();
}

class _ManageProductItemState extends State<ManageProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        //circle avatar will do the sizing and so on to size the image into itself
        backgroundImage: NetworkImage(widget.imageurl),
      ),
      title: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(widget.nom,
                style: TextStyle(fontWeight: FontWeight.bold))),
        Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text('Quantite: ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
                Text(widget.quantite.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                    )),
              ],
            )),
        Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text('Prix: ',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
                Text(widget.prix.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                    )),
              ],
            )),
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
    );
  }
}
