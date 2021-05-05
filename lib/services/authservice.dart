import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  addUser(nom, prenom, numtel, email, password) async {
    try {
      return await dio.post(
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

  addAdmin(nom, prenom, numtel, email, password) async {
    try {
      return await dio.post(
          'https://fathomless-coast-11439.herokuapp.com/api/auth/signup',
          data: {
            "nom": nom,
            "prenom": prenom,
            "numtel": numtel,
            "email": email,
            "password": password,
            "roles": 'admin'
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
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

  login(email, password) async {
    try {
      return await dio.post(
          'https://fathomless-coast-11439.herokuapp.com/api/auth/signin',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
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

  /*
  login(email, password) async {
    try {
      return await dio.post('https://decostore1.herokuapp.com/authenticateuser',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  addUser(nom, prenom, numtel, email, password) async {
    try {
      return await dio.post('https://decostore1.herokuapp.com/addUser',
          data: {
            "nom": nom,
            "prenom": prenom,
            "numtel": numtel,
            "email": email,
            "password": password
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  login(email, password) async {
    try {
      return await dio.post(
          'https://fathomless-coast-11439.herokuapp.com/api/auth/signin',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
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
*/

/*
  getinfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('https://decostore1.herokuapp.com/getinfo');
  }

*/
}
