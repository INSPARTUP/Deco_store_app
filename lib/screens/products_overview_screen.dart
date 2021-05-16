import 'package:Deco_store_app/providers/products.dart';
import 'package:Deco_store_app/widgets/app_drawer.dart';
import 'package:Deco_store_app/widgets/products_grid.dart';
import 'package:Deco_store_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions { Favorites, All }

class ProductsOverwiewScreen extends StatefulWidget {
  static const routeName = '/products-overview';

  @override
  _ProductsOverwiewScreenState createState() => _ProductsOverwiewScreenState();
}

class _ProductsOverwiewScreenState extends State<ProductsOverwiewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

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
    //  final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          /*  PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  //      productsContainer.showFavoritesOnly();
                  _showOnlyFavorites = true;
                } else {
                  //     productsContainer.showAll();
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),*/
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),

      /*  Column(
              children: [
               SearchBar(),
                ProductsGrid(_showOnlyFavorites),
              ],
            ),*/

      /* ListView(
                children: [
                  Container(
                    width: 300,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(10, 10, 10, 10),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        SearchBar(),
                        //  CollectionWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Products",
                          //  style: medBoldStyle,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "View All",

                          //   style: smallBoldTxtStyle.copyWith(color: Colors.black54),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                      height: 300, child: ProductsGrid(_showOnlyFavorites)),
                  const SizedBox(height: 100),
                ],
              )
              
              
              
              
              
              
              
              
              
              
              
              
              */
    );
  }
}
