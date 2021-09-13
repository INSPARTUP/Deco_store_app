import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductsGrid extends StatefulWidget {
  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  var slideShowList = [
    "lib/assets/collections/image_1.gif",
    "lib/assets/collections/image_2.jpg",
    "lib/assets/collections/image_3.gif",
    "lib/assets/collections/image_4.jpg",
  ];
  var type;
  var typeSelected = 0;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
        context); //we add <>to let it know which type of data you actually want to listening to.
    var prod = productData.items.where((element) => !element.archived).toList();
    var products = prod;

    if (type != null)
      products =
          prod.where((pr) => pr.nom.toLowerCase().contains(type)).toList();

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
              SizedBox(height: 10),
              Text(
                '   Nos Produits : ',
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Arial, sans-serif',
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 23.5),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          type = '';
                          typeSelected = 0;
                        });
                      },
                      child: Text(
                        "Tous",
                        style: TextStyle(
                            color:
                                typeSelected == 0 ? Colors.blue : Colors.black,
                            fontWeight: typeSelected == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: typeSelected == 0 ? 25 : 16),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            type = 'armoire';
                            typeSelected = 1;
                          });
                        },
                        child: Text(
                          "Armoires",
                          style: TextStyle(
                              color: typeSelected == 1
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: typeSelected == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: typeSelected == 1 ? 25 : 16),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            type = 'lit';
                            typeSelected = 2;
                          });
                        },
                        child: Text(
                          "Lits",
                          style: TextStyle(
                              color: typeSelected == 2
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: typeSelected == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: typeSelected == 2 ? 25 : 16),
                        )),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            type = 'table';
                            typeSelected = 3;
                          });
                        },
                        child: Text(
                          "Tables",
                          style: TextStyle(
                              color: typeSelected == 3
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: typeSelected == 3
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: typeSelected == 3 ? 25 : 16),
                        )),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          type = 'chaise';
                          typeSelected = 4;
                        });
                      },
                      child: Text(
                        "Chaises",
                        style: TextStyle(
                            color:
                                typeSelected == 4 ? Colors.blue : Colors.black,
                            fontWeight: typeSelected == 4
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: typeSelected == 4 ? 25 : 16),
                      ),
                    ),
                    SizedBox(width: 23.5),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.only(top: 240.0),
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
