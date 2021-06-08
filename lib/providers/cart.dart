import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

CartItem cartFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  CartItem({
    this.id,
    this.email,
    this.items,
    this.createdAt,
    this.v,
  });

  String id;
  String email;
  List<Item> items;
  DateTime createdAt;
  int v;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["_id"],
        email: json["email"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class Item {
  Item({
    this.id,
    this.productId,
    this.qty,
  });

  String id;
  String productId;
  int qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        productId: json["product_id"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_id": productId,
        "qty": qty,
      };
}

class ProductFromCartItem {
  ProductFromCartItem({
    this.productId,
    this.quantite,
    this.prix,
    this.nom,
    this.imageurl,
    this.type,
  });

  String nom;
  String type;
  int prix;
  int quantite;
  String description;
  String imageurl;
  DateTime createdAt;
  DateTime updatedAt;
  String productId;
}

class Cart with ChangeNotifier {
  Map<String, ProductFromCartItem> _items = {};

  Map<String, ProductFromCartItem> get items {
    return {
      ..._items
    }; //return a copy of _items not a reference of the list (to avoid any modification in the original Map)
  }

  List<ProductFromCartItem> _products = [];

  List<ProductFromCartItem> get products {
    return [..._products.reversed.toList()];
  }

  int get itemCount {
    if (_items.length == 0)
      return 0;
    else
      return _items.length;
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.prix * value.quantite;
    });
    return total;
  }

  Future<void> fetchCart(String email) async {
    // email = "azeqs@gmail.com";
    var url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/cart/cart?email=$email');
    http.Response response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body);
      List<dynamic> itemss;
      try {
        itemss = jsonData['items'];
      } catch (e) {
        itemss = [];
      }

      //  jsonData['items'];
      //   print(jsonData['items']?.hashCode);

      itemss.forEach((element) async {
        var url = Uri.parse(
            'https://whispering-bastion-00988.herokuapp.com/api/produits/${element["product_id"]}');
        http.Response response = await http.get(url);
        //  print(response.body);
        dynamic jsonData = json.decode(response.body);

        if (!_items.containsKey(jsonData["id"]))
          _items.putIfAbsent(
              jsonData["id"],
              () => ProductFromCartItem(
                    productId: jsonData["id"],
                    nom: jsonData["nom"],
                    prix: jsonData["prix"],
                    quantite: element["qty"],
                    imageurl: jsonData["imageurl"],
                    type: jsonData["type"],
                  ));
      });
/*
      print('///////////////////////////////////////');
      print('///////////////////////////////////////');
      print('///////////////////////////////////////');
      print('///////////////////////////////////////');
      _items.forEach((key, value) {
        print(value.quantite);
      });*/
      // return _items;

      //  notifyListeners();
      // print(_products);
      // print(_items);
      // return CartItem.fromJson(jsonData);

    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Server Error');
    }
  }

  Future<void> addCartItem(String id, String email, int qty) async {
    var quantite;
    print(id);
    var url = Uri.parse(
        'https://whispering-bastion-00988.herokuapp.com/api/produits/$id');
    http.Response response = await http.get(url);
    dynamic jsonData;
    if (response.statusCode == 200) {
      print(response.body);
      jsonData = json.decode(response.body);
      quantite = jsonData["quantite"];
      print(qty);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Server Error');
    }

    var url2 =
        Uri.parse('https://managecartandorders.herokuapp.com/api/cart/addCart');
    if (qty > quantite) {
      Fluttertoast.showToast(
          msg: "cette quantite n'existe pas dans le stock",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      try {
        final response = await http.post(
          url2,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            ////with json.encode we can convert this map into JSON format
            'email': email,
            'product_id': id,
            'qty': qty,
          }),
        );

        if (response.statusCode == 200) {
          if (_items.containsKey(id)) {
            // change quantity
            _items.update(
              id,
              (existingCartItem) => ProductFromCartItem(
                productId: existingCartItem.productId,
                nom: existingCartItem.nom,
                prix: existingCartItem.prix,
                quantite: existingCartItem.quantite + qty,
                type: existingCartItem.type,
                imageurl: existingCartItem.imageurl,
              ),
            );
          } else {
            _items.putIfAbsent(
                id,
                () => ProductFromCartItem(
                      productId: id,
                      nom: jsonData["nom"],
                      prix: jsonData["prix"],
                      quantite: qty,
                      type: jsonData["type"],
                      imageurl: jsonData["imageurl"],
                    ));
            //putIfAbsent tadi function f parametre 2(value) 3labiha zadna anonymous function
          }
          notifyListeners();

          Fluttertoast.showToast(
              msg: "Le produit est ajouté dans votre panier",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          print(json.decode(response
              .body)); //with json.decode we can convert this from JSON into some data we can work in Dart (Map)

          notifyListeners();
        }
      } catch (error) {
        print(error);
        throw error;
      }
    }
  }

  void removeSingleItem(String email, String productId) async {
    var url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/cart/deleteProduit');
    http.Response response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        ////with json.encode we can convert this map into JSON format
        'email': email,
        'product_id': productId,
      }),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      if (_items.containsKey(productId)) _items.remove(productId);
      notifyListeners();
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Server Error');
    }
  }

  void substract(String email, String id, String qtysub) async {
    var url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/cart/subtract');
    http.Response response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'product_id': id, 'qty': qtysub}));

    if (response.statusCode == 200) {
      _items.update(
        id,
        (existingCartItem) => ProductFromCartItem(
          productId: existingCartItem.productId,
          nom: existingCartItem.nom,
          prix: existingCartItem.prix,
          quantite: existingCartItem.quantite - int.parse(qtysub),
          type: existingCartItem.type,
          imageurl: existingCartItem.imageurl,
        ),
      );
      notifyListeners();
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Server Error');
    }
  }

  void clear(String email) async {
    var url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/cart/remove?email=$email');
    http.Response response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      _items = {};
      notifyListeners();
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Server Error');
    }
  }

/*
  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            prix: existingCartItem.prix,
            quantity: existingCartItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
      //putIfAbsent tadi function f parametre 2(value) 3labiha zadna anonymous function
    }
    notifyListeners();
  }
  void removeItems(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
              title: existingCartItem.title));
    } else {
      //quantity == 1
      _items.remove(productId);
    }
    notifyListeners();
  }
  void clear() {
    _items = {};
    notifyListeners();
  }
*/
}
