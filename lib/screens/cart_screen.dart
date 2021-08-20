import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/user_screens/commander_screen.dart';
import 'package:deco_store_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
// we are only here interested in cart and it won't import the cart item from the cart.dart file and we avoid that name clash (name issue) car yatchabah m3a CartItem, CartItemkayan f cart w CartItem

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cartitems;

  var _isInit = true;
  var _isLoading = false;
  /* Future<void> _refreshProducts(String email) async {
    await Provider.of<Cart>(context, listen: true).fetchCart(email);
  }
*/

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final email = Provider.of<Auth>(
        context,
      ).email;
      Provider.of<Cart>(context, listen: true).fetchCart(email).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false; // bach ydir hadik l khadma ghi l khatra lawla
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context, listen: false).email;
    final cart = Provider.of<Cart>(context, listen: false).fetchCart(email);
    final total = Provider.of<Cart>(context, listen: true).totalAmount;
    final cartitems = Provider.of<Cart>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Votre Panier'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              SweetAlertV2.show(context,
                  subtitle: 'êtes-vous sûr de vouloir Vider votre panier ?',
                  subtitleTextAlign: TextAlign.center,
                  style: SweetAlertV2Style.confirm,
                  cancelButtonText: 'Annuler',
                  confirmButtonText: 'Confirmer',
                  showCancelButton: true, onPress: (bool isConfirm) {
                if (isConfirm) {
                  SweetAlertV2.show(context,
                      subtitle: "Suppression...",
                      style: SweetAlertV2Style.loading);
                  Provider.of<Cart>(context, listen: false).clear(email).then(
                      (value) => SweetAlertV2.show(context,
                          subtitle: "Succés!",
                          style: SweetAlertV2Style.success));
                } else {
                  SweetAlertV2.show(context,
                      subtitle: "Annulé!", style: SweetAlertV2Style.error);
                }

                // return false to keep dialog
                return false;
              });

              /*      showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Vous etes sur ?'),
                  content:
                      Text('Vous etes sur de vouloir Vider votre panier ?'),
                  actions: [
                    FlatButton(
                      child: Text('Non'),
                      onPressed: () => Navigator.of(context).pop(false),
                      // this will close the dialog and now here, we can also forward a value 'false'
                    ),
                    FlatButton(
                      child: Text('Oui'),
                      onPressed: () => {
                        Provider.of<Cart>(context, listen: false).clear(email),
                        Navigator.of(context).pop(true)
                      },
                      // this will close the dialog and now here, we can also forward a value 'true'
                    )
                  ],
                ),
              ); */
            },
          ),
          SizedBox(width: 5)
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Card(
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Spacer(), //it takes all the available space and reserves it for itself
                        Chip(
                          label: Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .title
                                  .color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ), //the chip widget is also a little bit like our bage,our label, an element with rounded corners which you can use to display information
                        _isLoading
                            ? CircularProgressIndicator()
                            : FlatButton(
                                child: Text('Commander'),
                                onPressed: (total <= 0 || _isLoading)
                                    ? null //if onPressed points at null instead of a function,flutter automatically disables the button
                                    : () => Navigator.of(context)
                                            .pushReplacementNamed(
                                                CommanderScreen.routeName,
                                                arguments: {
                                              'total': total,
                                              'cartitems': cartitems
                                            }),
                                textColor: Theme.of(context).primaryColor,
                              )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartitems.length,
                    itemBuilder: (ctx, i) => CartItemWidget(
                        cartitems.values.toList()[i].productId,
                        //cart.items hiya Map zad .values bach nkharbo liste ta3 values w radinaha list .to List
                        cartitems.keys.toList()[i],
                        cartitems.values.toList()[i].prix,
                        cartitems.values.toList()[i].quantite,
                        cartitems.values.toList()[i].nom),
                  ),
                )
              ],
            ),
    );
  }
}
