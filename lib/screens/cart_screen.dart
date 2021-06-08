import 'package:Deco_store_app/providers/auth.dart';
import 'package:Deco_store_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Deco_store_app/providers/cart.dart';
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

/*
  Future<void> orderNow(cart) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Orders>(context, listen: false).addOrder(
          cart.items.values.toList(), //ta3tina les valeurs f liste
          cart.totalAmount);
      cart.clear();
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occured!'),
          content: Text('Something went wrong'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      //we will go back to the previous page whent we get response from database when we do Http.post()
    }
  }
*/

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
              showDialog(
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
              );
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
                            '${total.toStringAsFixed(2)} DA',
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
                                    : null,
                                // () => orderNow(cart),
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
