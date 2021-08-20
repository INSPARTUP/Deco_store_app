import 'package:deco_store_app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  final String
      productId; //hadi 'Key' f map items njiboh bach ki n9ado ndiro direct items.remove(productId) (productId howa Key)
  final int price;
  final int quantity;
  final String title;
  CartItemWidget(
      this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context).email;
    var qtysub;
    void _substract() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Confirmation '),
          content: Form(
            key: _key,
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Quantité à enlever',
              ),
              keyboardType: TextInputType.number,

              onChanged: (val) {
                qtysub = val;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Veuillez entrer la quantite';
                }
                if (double.tryParse(value) == null) {
                  return 'Veuillez entrer un numéro valide.'; // exemple ndakhlo String sama man9adoch n convertoh l double using double.parse(value)
                }
                if (double.parse(value) <= 0) {
                  return 'Veuillez saisir un nombre supérieur à zéro.';
                }
                if (int.parse(value) > quantity) {
                  return "Cette quantite n'existe pas dans votre panier.";
                }
              },
              //  onSubmitted:
              // _recherche(), //  hadi ida bghit ydir recherche directement
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(false),
              // this will close the dialog and now here, we can also forward a value 'false'
            ),
            FlatButton(
                child: Text('Oui'),
                onPressed: () => {
//print(quantity),
                      //     print(int.parse(qtysub)),
                      if (_key.currentState.validate())
                        {
                          if (int.parse(qtysub) == quantity)
                            {
                              Provider.of<Cart>(context, listen: false)
                                  .removeSingleItem(email, productId),
                            }
                          else
                            Provider.of<Cart>(context, listen: false)
                                .substract(email, productId, qtysub),
                          Navigator.of(context).pop(true)
                        }
                      else
                        null
                    }
                // this will close the dialog and now here, we can also forward a value 'true'
                )
          ],
        ),
      );
    }

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment
            .centerRight, // to align it in the center vertically but on the right horizontally
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection
          .endToStart, //tkhalih yat7arak ghi m la droite l la gauche
      confirmDismiss: (direction) {
        // confirmDismiss khass tadi f parametre Future(True or False), w show Dialog trodalna Future ida khdamna b Navigator.of(ctx).pop(false) wala Navigator.of(ctx).pop(true)

        SweetAlertV2.show(context,
            subtitle: 'êtes-vous sûr de vouloir supprimer ce produit ?',
            subtitleTextAlign: TextAlign.center,
            style: SweetAlertV2Style.confirm,
            cancelButtonText: 'Annuler',
            confirmButtonText: 'Confirmer',
            showCancelButton: true, onPress: (bool isConfirm) {
          if (isConfirm) {
            SweetAlertV2.show(context,
                subtitle: "Suppression...", style: SweetAlertV2Style.loading);

            Provider.of<Cart>(context, listen: false)
                .removeSingleItem(email, productId)
                .then((value) => SweetAlertV2.show(context,
                    subtitle: "Succés!", style: SweetAlertV2Style.success));
          } else {
            SweetAlertV2.show(context,
                subtitle: "Annulé!", style: SweetAlertV2Style.error);
          }

          // return false to keep dialog
          return false;
        });
        /*  return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Confirmation '),
            content: Text('Vous êtes sûr de vouloir retirer ce produit ?'),
            actions: [
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
                // this will close the dialog and now here, we can also forward a value 'false'
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () => {
                  Provider.of<Cart>(context, listen: false)
                      .removeSingleItem(email, productId),
                  Navigator.of(context).pop(true)
                },
                // this will close the dialog and now here, we can also forward a value 'true'
              )
            ],
          ),
        );  */
      },
      onDismissed:
          (direction) {}, //direction za3ma 3la 7ssab kol direction n7arko ndiro function ta3ha chawa hna 3adna ghi direction wa7da

      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text('$price DA'),
                    ),
                  ),
                ),
                title: Text(title),
                subtitle: Text('Total : ${(price * quantity)} DA'),
                trailing: Text('$quantity'),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                  child: Text(
                    "Diminuer la quantite",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: _substract,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
