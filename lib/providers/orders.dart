import 'dart:convert';
import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

OrderItem orderItemFromJson(String str) => OrderItem.fromJson(json.decode(str));

String orderItemToJson(OrderItem data) => json.encode(data.toJson());

class OrderItem {
  OrderItem({
    this.user,
    this.billingAddress,
    this.shippingMethod,
    this.paymentMethod,
    this.accepted,
    this.deliveryTime,
    this.deliveredAt,
    this.arrived,
    this.id,
    this.phoneNumber,
    this.items,
    this.grandTotal,
    this.createdAt,
    this.v,
  });

  User user;
  BillingAddress billingAddress;
  String shippingMethod;
  String paymentMethod;
  bool accepted;
  int deliveryTime;
  DateTime deliveredAt;
  bool arrived;
  String id;
  String phoneNumber;
  List<ItemOrder> items;
  int grandTotal;
  DateTime createdAt;
  int v;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        user: User.fromJson(json["user"]),
        billingAddress: BillingAddress.fromJson(json["billingAddress"]),
        shippingMethod: json["shippingMethod"],
        paymentMethod: json["paymentMethod"],
        accepted: json["accepted"],
        deliveryTime: json["deliveryTime"],
        deliveredAt: DateTime.parse(json["deliveredAt"]),
        arrived: json["arrived"],
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        items: List<ItemOrder>.from(
            json["items"].map((x) => ItemOrder.fromJson(x))),
        grandTotal: json["grandTotal"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "billingAddress": billingAddress.toJson(),
        "shippingMethod": shippingMethod,
        "paymentMethod": paymentMethod,
        "accepted": accepted,
        "deliveryTime": deliveryTime,
        "deliveredAt": deliveredAt.toIso8601String(),
        "arrived": arrived,
        "_id": id,
        "phoneNumber": phoneNumber,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "grandTotal": grandTotal,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}

class BillingAddress {
  BillingAddress({
    this.country,
    this.name,
    this.email,
    this.postCode,
    this.wilaya,
    this.deliveryAddress,
  });

  String country;
  String name;
  String email;
  String postCode;
  String wilaya;
  String deliveryAddress;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        country: json["country"],
        name: json["name"],
        email: json["email"],
        postCode: json["postCode"],
        wilaya: json["wilaya"],
        deliveryAddress: json["deliveryAddress"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "name": name,
        "email": email,
        "postCode": postCode,
        "wilaya": wilaya,
        "deliveryAddress": deliveryAddress,
      };
}

class ItemOrder {
  ItemOrder({
    this.id,
    this.productId,
    this.name,
    this.price,
    this.qty,
  });

  String id;
  String productId;
  String name;
  int price;
  int qty;

  factory ItemOrder.fromJson(Map<String, dynamic> json) => ItemOrder(
        id: json["_id"],
        productId: json["productId"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
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

  set vider(String a) {
    _orders = [];
    _allOrders = [];
    notifyListeners();
  }

  List<OrderItem> _allOrders = [];
  List<OrderItem> get allOrders {
    return [..._allOrders];
  }

  Future<void> fetchAllOrders() async {
    final url = Uri.parse(
        'https://managecartandorders.herokuapp.com/api/order/orders'); //const because url will not change at the run time
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final List<OrderItem> loadedOrders = [];
    print(json.decode(response.body));

    final extractedData = json.decode(response.body) as List<dynamic>;

    if (extractedData == null) {
      return;
    }
    //print(extractedData);
    extractedData.forEach((orderData) {
      //  print(orderData['billingAddress']['deliveryAddress']);
      loadedOrders.add(OrderItem.fromJson(orderData));
      /*  OrderItem(
          user: User(
              name: orderData['user']['name'],
              email: orderData['user']['email']),
          createdAt: DateTime.parse(orderData['createdAt']),
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
          accepted: orderData['accepted'],
          id: orderData["_id"],
          deliveryTime: orderData['deliveryTime'],
          deliveredAt: DateTime.parse(orderData['deliveredAt']),
          arrived: orderData['arrived'],
          items: (orderData['items'] as List<dynamic>)
              .map(
                (item) => ItemOrder(
                  productId: item['productId'],
                  price: item['price'],
                  name: item['name'],
                  qty: item['qty'],
                ),
              )
              .toList(),
        ),  */
    });

    loadedOrders.forEach((order) async {
      if (DateTime.now().add(Duration(hours: 12)).isAfter(order.deliveredAt) &&
          order.accepted) {
        var url = Uri.parse(
            'https://managecartandorders.herokuapp.com/api/order/${order.id}');

        order.arrived = true;
        final response = await http.put(url, body: {
          "arrived": true.toString(),
        });

        print(json.decode(response.body)['message']);
      }
    });

    _allOrders = loadedOrders.reversed.toList();
    //nagalbo la liste bach orders jdod ykono l foga
    notifyListeners();
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

    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderData) {
      loadedOrders.add(OrderItem.fromJson(orderData));
    });

    loadedOrders.forEach((order) async {
      if (DateTime.now().add(Duration(hours: 12)).isAfter(order.deliveredAt) &&
          order.accepted) {
        var url = Uri.parse(
            'https://managecartandorders.herokuapp.com/api/order/${order.id}');

        order.arrived = true;
        final response = await http.put(url, body: {
          "arrived": true.toString(),
        });

        print(json.decode(response.body)['message']);
      }
    });

    _orders = loadedOrders.reversed.toList();
    //nagalbo la liste bach orders jdod ykono l foga
    notifyListeners();
  }

  Future<void> addOrder(
      User user,
      BillingAddress billingAddress,
      String phoneNumber,
      List<ItemOrder> cartProducts,
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

  Future<void> deleteOrder(String id) async {
    var url =
        Uri.parse('https://managecartandorders.herokuapp.com/api/order/$id');
    final existingOrderIndex = _allOrders.indexWhere((prod) => prod.id == id);
    var existingOrder = _allOrders[existingOrderIndex];

    _allOrders.removeAt(existingOrderIndex);
    notifyListeners();

    final response = await http.delete(url);

    Fluttertoast.showToast(
        msg: json.decode(response.body)['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    if (response.statusCode >= 400) {
      _allOrders.insert(existingOrderIndex, existingOrder);
      notifyListeners();
    }

    existingOrder = null;
  }

  Future<void> accepterOrder(String id, int deliveryTime) async {
    final orderIndex = _allOrders.indexWhere((order) => order.id == id);
    print(deliveryTime);
    if (orderIndex >= 0) {
      var url =
          Uri.parse('https://managecartandorders.herokuapp.com/api/order/$id');

      var newDeliveredAt = DateTime.now().add(Duration(days: deliveryTime));
      print(DateTime.now());
      print(newDeliveredAt);

      _allOrders[orderIndex].accepted = true;
      _allOrders[orderIndex].deliveryTime = deliveryTime;
      _allOrders[orderIndex].deliveredAt = newDeliveredAt;

      final response = await http.put(url, body: {
        "accepted": true.toString(),
        "deliveryTime": deliveryTime.toString(),
        "deliveredAt": newDeliveredAt.toIso8601String(),
      });

      //darna await sama ki ykamal l code lilfoga ydir li rah lta7t sama ydir update f local memoire
      Fluttertoast.showToast(
          msg: json.decode(response.body)['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      print(json.decode(response.body)['message']);

      notifyListeners();
    } else
      print('...');
  }

  Future<void> arriver(String id) async {
    final orderIndex = _allOrders.indexWhere((order) => order.id == id);
    if (orderIndex >= 0) {
      var url =
          Uri.parse('https://managecartandorders.herokuapp.com/api/order/$id');

      _allOrders[orderIndex].arrived = true;
      final response = await http.put(url, body: {
        "arrived": true.toString(),
      });

      print(json.decode(response.body)['message']);

      notifyListeners();
    } else
      print('...');
  }
}
