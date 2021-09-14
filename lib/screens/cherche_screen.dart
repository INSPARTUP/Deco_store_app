import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:deco_store_app/providers/products.dart';
import 'package:deco_store_app/widgets/productitem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChercheScreen extends StatefulWidget {
  @override
  _ChercheScreenState createState() => _ChercheScreenState();
}

class _ChercheScreenState extends State<ChercheScreen> {
  var _isInit = true;
  var _isLoading = false;
  var rech;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchProducts().then((_) {
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
    final productData = Provider.of<Products>(
        context); //we add <>to let it know which type of data you actually want to listening to.

    final productsItems =
        productData.items.where((element) => !element.archived).toList();

    var products = productsItems;

    if (rech != null)
      products = productsItems.where((pr) => pr.nom.contains(rech)).toList();

    return SafeArea(
      child: Scaffold(
        body: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  width: 350,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Color(0xFF08090C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(' Recherche',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),

                      //------------------------------    Search Bar

                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE4E5E5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFF98A0A6),
                              size: 20,
                            ),
                            hintText: "Rechercher",
                            contentPadding: const EdgeInsets.only(top: 13),
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          onSubmitted: (val) {
                            setState(() {
                              rech = val;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 125),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Produits Recherchés",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                //---------------------  GridView
                Padding(
                  padding: const EdgeInsets.only(top: 165.0),
                  child: GridView.builder(
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
                      value: products[i],
                      child: ProductItem(),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
