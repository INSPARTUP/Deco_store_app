import 'package:Deco_store_app/services/adminauthservice.dart';
import 'package:Deco_store_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var token;

  @override
  Widget build(BuildContext context) {
    token = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Admin Screen'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            CustomButton(
              label: 'Get Info',
              labelColour: Colors.white,
              backgroundColour: Colors.green,
              shadowColour: Color(0xff866DC9).withOpacity(0.16),
              onPressed: () {
                AdminAuthService().getinfo(token).then((val) {
                  Fluttertoast.showToast(
                      msg: val.data['msg'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              label: 'Add an Admin',
              labelColour: Colors.white,
              backgroundColour: Colors.green,
              shadowColour: Color(0xff866DC9).withOpacity(0.16),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/admin-signup',
                  arguments: token,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
