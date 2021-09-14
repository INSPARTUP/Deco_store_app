import 'package:deco_store_app/providers/count.dart';
import 'package:deco_store_app/providers/product.dart';
import 'package:deco_store_app/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Container(
      width: 200,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      decoration: BoxDecoration(
        // color: appThemeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        //ClipRRect which simply forces the child widget it wraps into a certain shape and therefore on ClipRRect ( bach n9ado ndiro borderRaduis) , ClipRRect is a widhet that helps us with clipping a rectangle to add rounded corners.
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            //darna l'image dakhal gesture detector bach n9ado ndiro OnTap
            onTap: () {
              context.read<Count>().reset();

              Navigator.of(context).pushNamed(
                DetailsScreen.routeName,
                arguments: product.id,
              );
            },

            child: Hero(
              //tag is used on the new screen which is loaded to know which image on the old screen to fload over so to say,which image should be animated over into the new screen, and it can be any tag  you want  and it should be unique
              //we need to add Hero(tag:) into the screen we're animating to is the "product detail screen"
              tag: product
                  .id, //this tag is then used on the new page which is loaded because the hero animation is always used between to different screens
              /// FadeInImage Creates a widget that displays a [placeholder] while an [image] is loading,
              /// then fades-out the placeholder and fades-in the image.
              child: FadeInImage(
                placeholder: AssetImage('lib/assets/images/product_holder.jpg'),
                image: NetworkImage(product.imageurl),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          footer: // footer za3ma l ta7ta.kima f HTML kayan header w footer
              GridTileBar(
            backgroundColor: Colors.black87,
            title: Text(
              product.nom,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            subtitle: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: Text(
                  "\$${product.prix}",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
