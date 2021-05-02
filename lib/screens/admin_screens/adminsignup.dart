import 'package:Deco_store_app/services/adminauthservice.dart';
import 'package:Deco_store_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminSignup extends StatefulWidget {
  @override
  _AdminSignupState createState() => _AdminSignupState();
}

class _AdminSignupState extends State<AdminSignup> {
  var prenom, nom, numtel, email, password, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Add an Admin'),
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
                    'DecoStore',
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),

/*
 child: CustomTextField(
                                hintText: 'First Name',
                                icon: Icon(
                                  CupertinoIcons.profile_circled,
                                  color: Colors.red,
                                ),
                              ),

*/

                              child: TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    CupertinoIcons.profile_circled,
                                    color: Colors.red,
                                  ),
                                  hintText: 'Nom',
                                ),
                                onChanged: (val) {
                                  nom = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),

/*

     child: CustomTextField(
                                hintText: 'Last Name',
                                icon: Icon(
                                  CupertinoIcons.profile_circled,
                                  color: Colors.red,
                                ),
                              ),

*/

                              child: TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    CupertinoIcons.profile_circled,
                                    color: Colors.red,
                                  ),
                                  hintText: 'Prenom',
                                ),
                                onChanged: (val) {
                                  prenom = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),

                              /*  child: CustomTextField(
                                hintText: '+213 55 24 97 02 1',
                                icon: Icon(
                                  Icons.phone_android,
                                  color: Colors.red,
                                ),
                              ),*/

                              child: TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.phone_android,
                                    color: Colors.red,
                                  ),
                                  hintText: '+213 55 24 97 02 1',
                                ),
                                onChanged: (val) {
                                  numtel = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),

/*
             child: CustomTextField(
                                hintText: 'Email',
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.red,
                                ),
                              ),

*/

                              child: TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.red,
                                  ),
                                  hintText: 'Email',
                                ),
                                onChanged: (val) {
                                  email = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),

/*  child: CustomTextField(
                                hintText: 'Password',
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.red,
                                ),
                              ),*/

                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.red,
                                  ),
                                  hintText: 'Password',
                                ),
                                onChanged: (val) {
                                  password = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 35.0,
                                right: 35.0,
                                top: 30.0,
                              ),
                              child: CustomButton(
                                label: 'Register Now',
                                labelColour: Colors.white,
                                backgroundColour: Colors.red,
                                shadowColour:
                                    Color(0xff866DC9).withOpacity(0.16),
                                onPressed: () {
                                  AdminAuthService()
                                      .addAdmin(
                                          nom, prenom, numtel, email, password)
                                      .then((val) {
                                    Fluttertoast.showToast(
                                        msg: val.data['msg'],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                    /*     if (val.data['success']) {
                                      Navigator.of(context)
                                          .pushNamed('/admin-screen');
                                    }*/
                                  });
                                },
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
          ),
          Column(
            children: [
              SizedBox(
                //  height: SizeConfig.height(40.8),
                child: Divider(height: 10),
              ),
              Text(
                'You are completely safe',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Read our Terms & Conditions.',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
