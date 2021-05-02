import 'package:Deco_store_app/services/adminauthservice.dart';
import 'package:Deco_store_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var prenom, nom, numtel, email, password, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Admin Login'),
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.mail,
                                    color: Colors.red,
                                  ),
                                  hintText: 'Email',
                                ),
                                //   InputDecoration(labelText: 'Email'),
                                onChanged: (val) {
                                  email = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0, top: 20.0),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.red,
                                  ),
                                  hintText: 'Password',
                                ),
                                //   labelText: 'Password'),

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
                                  label: 'Login',
                                  labelColour: Colors.white,
                                  backgroundColour: Colors.red,
                                  shadowColour:
                                      Color(0xff866DC9).withOpacity(0.16),
                                  onPressed: () {
                                    AdminAuthService()
                                        .login(email, password)
                                        .then((val) {
                                      if (val.data['success']) {
                                        token = val.data['token'];
                                        Fluttertoast.showToast(
                                            msg: 'Authenticated',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                        Navigator.of(context).pushNamed(
                                            '/admin-screen',
                                            arguments: token);
                                      }
                                    });
                                  }),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            /*               RaisedButton(
                              child: Text('you have not an account'),
                              color: Colors.green,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/admin-signup',
                                );
                              },
                            ),*/
                          ],
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
}
