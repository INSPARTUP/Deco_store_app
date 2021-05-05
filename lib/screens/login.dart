import 'dart:ui';

import 'package:Deco_store_app/services/authservice.dart';
import 'package:Deco_store_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  var prenom, nom, numtel, email, password, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Login'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xFFFAFBFD),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 85,
              //     height: SizeConfig.height(100.9),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(9.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DecoStore',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  //         height: SizeConfig.height(280.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: new Form(
                          key: _key,
                          autovalidate: _validate,
                          child: FormUI(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.mail,
                  color: Colors.red,
                ),
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              //    maxLength: 32,
              validator: validateEmail,
              onSaved: (String val) {
                email = val;
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
            obscureText: true,
            validator: validatePassword,
            decoration: InputDecoration(
              icon: Icon(
                Icons.vpn_key,
                color: Colors.red,
              ),
              hintText: 'Password',
            ),
            onSaved: (val) {
              password = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: CustomButton(
            label: 'Login',
            labelColour: Colors.white,
            backgroundColour: Colors.red,
            shadowColour: Color(0xff866DC9).withOpacity(0.16),
            onPressed: _sendToServer,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          child: Text('Create Account'),
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/user-signup',
            );
          },
        ),
      ],
    );
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email est Obligatoire";
    } else if (!regExp.hasMatch(value)) {
      return " Email n'est pas valide";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be atleast 8 characters long";
    }
    return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      AuthService().login(email, password).then((val) {
        if (val.statusCode == 200) {
          //    token = val.data['roles'];
          Fluttertoast.showToast(
              msg: 'Authenticated',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          if (val.data['roles'] == 'ROLE_USER') {
            Navigator.of(context)
                .pushNamed('/user-screen', arguments: val.data);
          } else if (val.data['roles'] == 'ROLE_ADMIN') {
            Navigator.of(context)
                .pushNamed('/admin-screen', arguments: val.data);
          } else if (val.data['roles'] == 'ROLE_SUPER-ADMIN') {
            Navigator.of(context)
                .pushNamed('/superadmin-screen', arguments: val.data);
          }
        }
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
