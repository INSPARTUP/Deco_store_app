import 'package:Deco_store_app/services/authservice.dart';
import 'package:Deco_store_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminSignup extends StatefulWidget {
  @override
  _AdminSignupState createState() => _AdminSignupState();
}

class _AdminSignupState extends State<AdminSignup> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  var prenom, nom, numtel, email, password, confirm_password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Créer un compte'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xFFFAFBFD),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            //  height: SizeConfig.height(53.9),
            color: Color(0xFFFAFBFD),
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kagu',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.red,
                    ),
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.red,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  //     height: SizeConfig.height(377.3),
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
                ),
              ],
            ),
          ),
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
                CupertinoIcons.profile_circled,
                color: Colors.red,
              ),
              hintText: 'Nom',
            ),
            //  maxLength: 32,
            validator: validateNom,
            onSaved: (String val) {
              nom = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              icon: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.red,
              ),
              hintText: 'Prenom',
            ),
            validator: validatePrenom,
            onSaved: (String val) {
              prenom = val;
            },
          ),
        ),
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
              obscureText: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.red,
                ),
                hintText: '+213 55 24 97 02 1',
              ),
              maxLength: 10,
              validator: validateMobile,
              onSaved: (String val) {
                numtel = val;
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
              hintText: 'Mot de passe',
            ),
            onSaved: (val) {
              password = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
            obscureText: true,
            validator: validateConfirmPassword,
            decoration: InputDecoration(
              icon: Icon(
                Icons.vpn_key,
                color: Colors.red,
              ),
              hintText: 'Confirmez le mot de passe',
            ),
            onSaved: (val) {
              confirm_password = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: CustomButton(
            label: 'Inscrivez-Vous',
            labelColour: Colors.white,
            backgroundColour: Colors.red,
            shadowColour: Color(0xff866DC9).withOpacity(0.16),
            onPressed: _sendToServer,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  String validateNom(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Le nom est obligatoire";
    } else if (!regExp.hasMatch(value)) {
      return "Le nom doit être a-z et A-Z";
    }
    return null;
  }

  String validatePrenom(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Le prenom est obligatoire";
    } else if (!regExp.hasMatch(value)) {
      return "Le prenom doit être a-z et A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Le numero Telephone est obligatoire";
    } else if (value.length != 10) {
      return "Le numéro de telephone doit être composé de 10 chiffres";
    } else if (!regExp.hasMatch(value)) {
      return "Le numéro de telephone doit être composé de chiffres";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email est obligatoire";
    } else if (!regExp.hasMatch(value)) {
      return " Email n'est pas valide";
    } else {
      return null;
    }
  }

  var conf;
  String validatePassword(String value) {
    if (value.length < 8) {
      conf = value;
      return "Le mot de passe doit contenir au moins 8 caractères";
    }
    conf = value;

    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.length == 0) {
      return "Le mot de passe est obligatoire";
    } else if (value != conf) {
      return "Le mot de passe est incorrect";
    }
    return null;
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      AuthService()
          .addAdmin(
        nom,
        prenom,
        numtel,
        email,
        password,
      )
          .then((val) {
        Fluttertoast.showToast(
            msg: val.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
