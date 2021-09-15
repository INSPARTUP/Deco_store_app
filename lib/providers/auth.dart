import 'dart:convert';
import 'dart:async'; //to use Timer
import 'package:deco_store_app/models/admindata.dart';
import 'package:deco_store_app/models/role.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';
import 'orders.dart';

class Auth with ChangeNotifier {
  Dio dio = new Dio();

  String id;
  String nom;
  String prenom;
  String email;
  String numtel;
  Role role;
  String roles;
  String accessToken;

  bool inscription;

//if we have a token, and the token didn't expire,then the user is authenticated
  bool get isAuth {
    return accessToken != null;
  }

  List<AdminData> _admins = [];

  List<AdminData> get admins {
    return [..._admins.toList()];
  }

  Future<void> addUser(nom, prenom, numtel, email, password) async {
    try {
      inscription = false;
      final response = await dio.post(
          'https://fathomless-coast-11439.herokuapp.com/api/auth/signup',
          data: {
            "nom": nom,
            "prenom": prenom,
            "numtel": numtel,
            "email": email,
            "password": password,
            "roles": 'user'
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));

      Fluttertoast.showToast(
        msg: response.data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      if (response.statusCode == 200) {
        inscription = true;
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response.data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> login(mail, password) async {
    try {
      final response = await dio.post(
          'https://fathomless-coast-11439.herokuapp.com/api/auth/signin',
          data: {"email": mail, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));

      if (response.statusCode == 200) {
        print(response.data);
        final responseData = response.data;
        id = responseData["id"];
        nom = responseData["nom"];
        prenom = responseData["prenom"];
        email = responseData["email"];
        numtel = responseData["numtel"];
        role = Role.fromJson(responseData["role"]);
        roles = responseData["roles"];
        accessToken = responseData["accessToken"];
      } else if (response.statusCode == 404) {
        throw Exception('Not found');
      } else {
        throw Exception('Server Error');
      }

      notifyListeners(); //to notify the Consumer in main.dart and rebuil MaterialApp
      //shared prefences alse involves working with futures sama khass methode l foga tkon async
      final prefs = await SharedPreferences.getInstance();
      //in prefs we store the real access to shared prefences and now we can use prefs to write and read data to and form the shared prefences device storage

      final userData = json.encode({
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "numtel": numtel,
        "role": role.toJson(),
        "roles": roles,
        "accessToken": accessToken,
      });
      prefs.setString('userData', userData);
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response.data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

//Future return boolean
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    // ki wsalna hna sama 3adna valid Data aya n initialo les valeurs ta3 (token,userId,...) pcq ykono raho m la memoire ki tafina l'application

    id = extractedUserData["id"];
    nom = extractedUserData["nom"];
    prenom = extractedUserData["prenom"];
    email = extractedUserData["email"];
    numtel = extractedUserData["numtel"];
    role = Role.fromJson(extractedUserData["role"]);
    roles = extractedUserData["roles"];
    accessToken = extractedUserData["accessToken"];
    print('------------------------------tessssst');

    print(id);
    print(nom);

    print('------------------------tesssssst--------');

    notifyListeners();
    return true;
  }

  void logout(BuildContext ctx) async {
    accessToken = null;
    id = null;

    Provider.of<Cart>(ctx, listen: false).vider = '';
    Provider.of<Orders>(ctx, listen: false).vider = '';

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<void> fetchAdmins() async {
    var url = Uri.parse(
        'https://fathomless-coast-11439.herokuapp.com/api/getAllAdmin');

    http.Response response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      List<dynamic> adminsJsonData = json.decode(response.body);

      _admins = adminsJsonData.map((e) => AdminData.fromJson(e)).toList();
    } else {
      _admins = [];
    }

    notifyListeners();
  }

  Future<void> deleteAdmin(String id) async {
    var url = Uri.parse(
        'https://fathomless-coast-11439.herokuapp.com/api/deleteAdmin');
    final existingAdminIndex = _admins.indexWhere((prod) => prod.id == id);
    var existingAdmin = _admins[existingAdminIndex];

    _admins.removeAt(existingAdminIndex);
    notifyListeners();

    final response = await http.delete(url, body: {"adminId": id});

    Fluttertoast.showToast(
        msg: json.decode(response.body)['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    if (response.statusCode >= 400) {
      _admins.insert(existingAdminIndex, existingAdmin);
      notifyListeners();
    }

    existingAdmin = null;
  }
}
