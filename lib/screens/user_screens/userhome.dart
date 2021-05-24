import 'package:Deco_store_app/providers/auth.dart';
import 'package:Deco_store_app/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  // var token;
  var data;
  @override
  Widget build(BuildContext context) {
    final nom = Provider.of<Auth>(context, listen: false).nom;
    final prenom = Provider.of<Auth>(context, listen: false).prenom;
    final role = Provider.of<Auth>(context, listen: false).roles;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('Get Info'),
                color: Colors.green,
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: nom + ' ' + prenom + ' ' + role,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }),
            RaisedButton(
                child: Text('Logout'),
                color: Colors.green,
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                }),
          ],
        ),
      ),
    );
  }
}
