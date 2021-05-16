import 'package:Deco_store_app/providers/product.dart';
import 'package:Deco_store_app/Screens/product_detail_screen.dart';
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
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
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
                placeholder:
                    AssetImage('lib/assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageurl),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          footer: // footer za3ma l ta7ta.kima f HTML kayan header w footer
              GridTileBar(
            backgroundColor: Colors.black87,
            /*    leading: Consumer<Product>(
              //Consumer always listen to changes here.3andna ghi had iconbutton liyatbadal sama ndiro hna Consumer bach man3awdoch rebuild ga3 widget ki yatbadal isFavorite
              builder: (ctx, product, _) => IconButton(
                //the define a widget that should be placed in the start of this Bar
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                iconSize: 18,
                onPressed: () {
                  product.toggleFavoriteStatus(authData.token, authData.userId);
                },
                color: Theme.of(context).accentColor,
              ),
            ),*/
            title: Text(
              product.nom,
              textAlign: TextAlign.center,
              // style: smallBoldTxtStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
