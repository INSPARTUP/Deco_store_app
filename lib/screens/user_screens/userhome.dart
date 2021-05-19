import 'package:Deco_store_app/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  // var token;
  var data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Center(
            child: RaisedButton(
                child: Text('Get Info'),
                color: Colors.green,
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: data['nom'] +
                          ' ' +
                          data['prenom'] +
                          ' ' +
                          data['roles'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);

/*

                  UserAuthService().getinfo(token).then((val) {
                    Fluttertoast.showToast(
                        msg: val.data['msg'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
             */
                })));
  }
}
