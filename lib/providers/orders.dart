import 'dart:convert';
import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

OrderItem orderFromJson(String str) => OrderItem.fromJson(json.decode(str));

String orderToJson(OrderItem data) => json.encode(data.toJson());

class OrderItem {
  OrderItem(
      {this.user,
      this.billingAddress,
      this.items,
      this.shippingMethod,
      this.paymentMethod,
      this.phoneNumber,
      this.grandTotal,
      this.dateTime});

  User user;
  BillingAddress billingAddress;
  List<Itemorder> items;
  String shippingMethod;
  String paymentMethod;
  String phoneNumber;
  int grandTotal;
  DateTime dateTime;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        user: User.fromJson(json["user"]),
        billingAddress: BillingAddress.fromJson(json["billingAddress"]),
        items: List<Itemorder>.from(json["items"].map((x) => Item.fromJson(x))),
        shippingMethod: json["shippingMethod"],
        paymentMethod: json["paymentMethod"],
        phoneNumber: json["phoneNumber"],
        grandTotal: json["grandTotal"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "billingAddress": billingAddress.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "shippingMethod": shippingMethod,
        "paymentMethod": paymentMethod,
        "phoneNumber": phoneNumber,
        "grandTotal": grandTotal,
      };
}

class BillingAddress {
  BillingAddress({
    this.name,
    this.email,
    this.postCode,
    this.wilaya,
    this.deliveryAddress,
    this.country,
  });

  String name;
  String email;
  String postCode;
  String wilaya;
  String deliveryAddress;
  String country;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        name: json["name"],
        email: json["email"],
        postCode: json["postCode"],
        wilaya: json["wilaya"],
        deliveryAddress: json["deliveryAddress"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "postCode": postCode,
        "wilaya": wilaya,
        "deliveryAddress": deliveryAddress,
        "country": country,
      };
}

class Itemorder {
  Itemorder({
    this.productId,
    this.name,
    this.price,
    this.qty,
  });

  String productId;
  String name;
  int price;
  int qty;

  factory Itemorder.fromJson(Map<String, dynamic> json) => Itemorder(
        productId: json["productId"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "price": price,
        "qty": qty,
      };
}

class User {
  User({
    this.name,
    this.email,
  });

  String name;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
      };
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders(String email) async {
    final url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/order/?email=$email'); //const because url will not change at the run time
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final List<OrderItem> loadedOrders = [];
    print(json.decode(response.body));

    final extractedData = json.decode(response.body) as List<dynamic>;
    /*  Map<String, dynamic> extractedData =
        Map.castFrom(json.decode(response.body));
*/
    if (extractedData == null) {
      return;
    }
    //print(extractedData);
    extractedData.forEach((orderData) {
      //  print(orderData['billingAddress']['deliveryAddress']);
      loadedOrders.add(
        OrderItem(
          user: User(
              name: orderData['user']['name'],
              email: orderData['user']['email']),
          dateTime: DateTime.parse(orderData['createdAt']),
          grandTotal: orderData['grandTotal'],
          phoneNumber: orderData['phoneNumber'],
          billingAddress: BillingAddress(
              name: orderData['billingAddress']['name'],
              email: orderData['billingAddress']['email'],
              postCode: orderData['billingAddress']['postCode'],
              wilaya: orderData['billingAddress']['wilaya'],
              deliveryAddress: orderData['billingAddress']['deliveryAddress'],
              country: orderData['billingAddress']['country']),
          shippingMethod: orderData['shippingMethod'],
          paymentMethod: orderData['paymentMethod'],
          items: (orderData['items'] as List<dynamic>)
              .map(
                (item) => Itemorder(
                  productId: item['productId'],
                  price: item['price'],
                  name: item['name'],
                  qty: item['qty'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    //nagalbo la liste bach orders jdod ykono l foga
    notifyListeners();
  }

  Future<void> addOrder(
      User user,
      BillingAddress billingAddress,
      String phoneNumber,
      List<Itemorder> cartProducts,
      int total,
      BuildContext context) async {
    final url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/order/create'); //const because url will not change at the run time
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user": {"name": user.name, "email": user.email},
          'billingAddress': {
            'name': billingAddress.name,
            'email': billingAddress.email,
            'postCode': billingAddress.postCode,
            'wilaya': billingAddress.wilaya,
            'deliveryAddress': billingAddress.deliveryAddress,
            'country': billingAddress.country
          },
          'items': cartProducts
              .map((cp) => {
                    'productId': cp.productId,
                    'name': cp.name,
                    'qty': cp.qty,
                    'price': cp.price,
                  })
              .toList(),
          "shippingMethod": "free",
          "paymentMethod": "cash_on_delivery",
          'grandTotal': total,
          'phoneNumber': phoneNumber,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      _orders.insert(
          0, //add the the beginning of the list
          OrderItem(
            user: user,
            billingAddress: billingAddress,
            items: cartProducts,
            shippingMethod: 'free',
            paymentMethod: 'cash_on_delivery',
            phoneNumber: phoneNumber,
            grandTotal: total,
          ));
      notifyListeners();

      Fluttertoast.showToast(
          msg: "Votre commande a été envoyée avec succés",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      SweetAlertV2.show(context,
          title: "Félicitation",
          subtitle: "Votre commande a été envoyée avec succés",
          style: SweetAlertV2Style.success,
          subtitleTextAlign: TextAlign.center, onPress: (x) {
        Navigator.of(context).pop();
        return true;
      });
      print(json.decode(response
          .body)); //with json.decode we can convert this from JSON into some data we can work in Dart (Map)
      final user_email = Provider.of<Auth>(context, listen: false).email;
      Provider.of<Cart>(context, listen: false).clear(user_email);
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Server Error');
    }
  }
}
