import 'package:Deco_store_app/providers/count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  // int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    int numOfItems = Provider.of<Count>(context, listen: true).numOfItems;
    return Row(
      children: <Widget>[
        buildOutlineButton(
            icon: Icons.remove,
            press: Provider.of<Count>(context, listen: true).sub

            /*     () {
      if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
 },*/
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: Provider.of<Count>(context, listen: false).add
            /*   () {
              setState(() {
                numOfItems++;
              });   
            }*/

            ),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
