import 'dart:ui';

import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/admin_screens/admin_navigation_screen.dart';
import 'package:deco_store_app/screens/admin_screens/super_admin_navigation_screen.dart';
import 'package:deco_store_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'user_screens/navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool _passwordVisible = false;

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _btnpressed = false;
  var prenom, nom, numtel, email, password, token;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: Text('Avertissement'),
                content: Text('Voulez-vous vraiment sortir'),
                actions: [
                  TextButton(
                      child: Text('Oui'),
                      onPressed: () => SystemNavigator.pop()),
                  TextButton(
                    child: Text('Non'),
                    onPressed: () => Navigator.pop(c, false),
                  ),
                ],
              ),
            ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 8.5,
            shadowColor: Colors.black,
            centerTitle: true,
            title: Text('Connexion', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue[800],
          ),
          backgroundColor: Color(0xFFFAFBFD),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/collections/background1.jpg"),

                //  https://i.pinimg.com/originals/cd/5a/b4/cd5ab4c99f790dd29100193d281bc2e9.jpg"
                fit: BoxFit.cover,
              ),
            ),
            child:
                /* new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Container(
                decoration:
                    new BoxDecoration(color: Colors.white.withOpacity(0.1)),
                child:*/
                Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 130,
                    //     height: SizeConfig.height(100.9),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
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
                              'Kagu',
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
            /*  ),
            ),*/
          ),
        ));
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
              obscureText: false,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                icon: Icon(
                  Icons.mail,
                  color: Colors.blue[800],
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
            style: TextStyle(color: Colors.black),
            obscureText: !_passwordVisible,
            validator: validatePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              icon: Icon(
                Icons.vpn_key,
                color: Colors.blue[800],
              ),
              hintText: 'Mot de passe',
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            onSaved: (val) {
              password = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: _btnpressed
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]),
                )
              : CustomButton(
                  label: 'Connectez-vous',
                  labelColour: Colors.white,
                  backgroundColour: Colors.blue[800],
                  shadowColour: Color(0xFF0c64a7).withOpacity(0.20),
                  onPressed: _sendToServer,
                ),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextButton(
          child: Text('Inscrivez-vous',
              style: TextStyle(color: Colors.blue, fontSize: 18)),
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/user-signup',
            );
          },
        ),
      ],
    );
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
      return "Le mot de passe doit contenir au moins 8 caractères";
    }
    return null;
  }

  Future<void> _sendToServer() async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      setState(() {
        _btnpressed = true;
      });
      await Provider.of<Auth>(context, listen: false).login(email, password);

      final connecter = Provider.of<Auth>(context, listen: false).isAuth;
      final role = Provider.of<Auth>(context, listen: false).roles;
      print(connecter);
      print(role);
      setState(() {
        _btnpressed = false;
      });
      if (connecter == true) {
        //    token = val.data['roles'];
        Fluttertoast.showToast(
            msg: 'Connecté',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        if (role == 'ROLE_USER') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return NavigationScreenUser(0);
            }),
          );
        } else if (role == 'ROLE_ADMIN') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AdminNavigationScreen(0);
            }),
          );
        } else if (role == 'ROLE_SUPER-ADMIN') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return SuperAdminNavigation(0);
            }),
          );
        }
      }
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
