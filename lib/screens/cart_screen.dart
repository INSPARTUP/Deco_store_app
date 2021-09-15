import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/user_screens/commander_screen.dart';
import 'package:deco_store_app/screens/user_screens/navigation_screen.dart';
import 'package:deco_store_app/widgets/cart_item.dart';
import 'package:deco_store_app/widgets/user_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isInit = true;
  var _isLoading = false;
  Future<void> _refreshCart(String email, BuildContext ctx) async {
    await Provider.of<Cart>(ctx, listen: false).fetchCart(email, ctx);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final email = Provider.of<Auth>(context, listen: true).email;
      Provider.of<Cart>(context, listen: true)
          .fetchCart(email, context)
          .then((_) {
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
    final email = Provider.of<Auth>(context).email;
    final total = Provider.of<Cart>(context, listen: true).totalAmount;
    final cartitems = Provider.of<Cart>(context, listen: true).items;
    print('tesssssssssst100000');
    print(email);
    return RefreshIndicator(
      onRefresh: () => _refreshCart(email, context),
      child: Scaffold(
          appBar: AppBar(
            elevation: 8.5,
            shadowColor: Colors.black,
            backgroundColor: Colors.white,
            title: Text('Votre Panier', style: TextStyle(color: Colors.black)),
            leading: Builder(
              builder: (context) => IconButton(
                icon: SvgPicture.asset(
                  "lib/assets/icons/menu.svg",
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  cartitems.length == 0
                      ? null
                      : SweetAlertV2.show(context,
                          subtitle:
                              'êtes-vous sûr de vouloir Vider votre panier ?',
                          subtitleTextAlign: TextAlign.center,
                          style: SweetAlertV2Style.confirm,
                          cancelButtonText: 'Annuler',
                          confirmButtonText: 'Confirmer',
                          showCancelButton: true, onPress: (bool isConfirm) {
                          if (isConfirm) {
                            SweetAlertV2.show(context,
                                subtitle: "Suppression...",
                                style: SweetAlertV2Style.loading);
                            Provider.of<Cart>(context, listen: false)
                                .clear(email)
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
                        });
                },
              ),
              SizedBox(width: 5)
            ],
          ),
          drawer: UserAppDrawer(),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Cart>(
                  // darna Consumer psq nas7a9o ghi Listview tdir rebuilding ida sra changement f provider orders mchi ga3 orders_overview (za3ma mchi ga3 build ta3 orders_overview)
                  builder: (ctx, cartData, child) => Column(
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
                                  '\$${cartData.totalAmount.toStringAsFixed(2)}',
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
                                      onPressed: (cartData.totalAmount <= 0 ||
                                              _isLoading)
                                          ? null //if onPressed points at null instead of a function,flutter automatically disables the button
                                          : () => Navigator.of(context)
                                                  .pushNamed(
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
                          itemCount: cartData.items.length,
                          itemBuilder: (ctx, i) => CartItemWidget(
                              cartData.items.values.toList()[i].productId,
                              //cart.items hiya Map zad .values bach nkharbo liste ta3 values w radinaha list .to List
                              cartData.items.keys.toList()[i],
                              cartData.items.values.toList()[i].prix,
                              cartData.items.values.toList()[i].quantite,
                              cartData.items.values.toList()[i].nom),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
