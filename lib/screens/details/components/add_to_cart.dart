import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:deco_store_app/providers/count.dart';
import 'package:deco_store_app/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key key,
    @required this.product,
    @required this.ctx,
  }) : super(key: key);

  final Product product;
  final BuildContext ctx;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool btn_pressed = false;

  Future<void> addToCart(String email, int qty) async {
    try {
      setState(() {
        btn_pressed = true;
      });
      await Provider.of<Cart>(widget.ctx, listen: false)
          .addCartItem(widget.product.id, email, qty);
      setState(() {
        btn_pressed = false;
      });
    } catch (error) {
      print(error);
      await showDialog<Null>(
        context: widget.ctx,
        builder: (ctx) => AlertDialog(
          title: Text('Erreur!'),
          content: Text('Il existe un probleme'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context, listen: false).email;
    int qty = Provider.of<Count>(context, listen: true).numOfItems;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "lib/assets/icons/add_to_cart.svg",
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.blue,
                onPressed: () {
                  addToCart(email, qty);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "lib/assets/icons/add_to_cart.svg",
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    btn_pressed
                        ? Padding(
                            padding: EdgeInsets.only(left: 45),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Ajouter au Panier".toUpperCase(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
