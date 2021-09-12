import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductsGrid extends StatelessWidget {
/*
  var slideShowList = [
    "https://www.wofox.com/napi/adsn/MTY2NjU=/166651574058317971.gif",
    "https://www.centimetre.com/image/1336x640/i/public/carousel/armoire/default/ill-visionneuse_2.jpg",
    "https://cdn.dribbble.com/users/503378/screenshots/4703008/ezgif.com-optimize__8_.gif",
    "https://www.sablotomb.fr/wp-content/uploads/2021/04/Egur-Berri-Verriere-Sogal_Moduleco.jpg",
  ];*/

  var slideShowList = [
    "lib/assets/collections/image_1.gif",
    "lib/assets/collections/image_2.jpg",
    "lib/assets/collections/image_3.gif",
    "lib/assets/collections/image_4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
        context); //we add <>to let it know which type of data you actually want to listening to.
    final products =
        productData.items.where((element) => !element.archived).toList();

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ]),
          margin: const EdgeInsets.only(left: 15, right: 15),
          height: 150.0,
          child: Carousel(
            dotIncreaseSize: 0.8,
            dotSize: 8,
            dotColor: Colors.black,
            dotBgColor: Colors.transparent,
            borderRadius: true,
            boxFit: BoxFit.cover,
            images: List.generate(
              slideShowList.length,
              (index) => AssetImage(slideShowList[index]),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(top: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '   Nos Produits : ',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Arial, sans-serif',
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(top: 185.0),
          child: GridView.builder(
            /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //number of columns
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),*/

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 2,
              childAspectRatio: 1,
            ),
            itemCount: products.length,
            addAutomaticKeepAlives: true,
            cacheExtent: 100000000.0,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              // create: (ctx) => products[i], madarnach hadi psq products[i] already existing, manas7a9och ndiro create (instantiatin) l products[i]
              //using value is the right approach you should use if you for example use a provider on something that's part of a list or a grid
              value: products[i],
              //darna kol product ro7ah bach kol wa7ad ywali 3andah provider (w kol wa7ad dayar ta3 isFavorite ta3ah)
              //mana7toch n3awdo ndiro re instantiate product objects psq sayi darnaha f Products class
              //return single product item as it's store in the products class

              child: ProductItem(),
            ),
          ),
        ),
      ],
    );
  }
}
