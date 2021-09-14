import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SuperAdminScreen extends StatefulWidget {
  @override
  _SuperAdminScreenState createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {
  @override
  Widget build(BuildContext context) {
    final nom = Provider.of<Auth>(context, listen: false).nom;
    final prenom = Provider.of<Auth>(context, listen: false).prenom;

    return Scaffold(
      appBar: AppBar(
        elevation: 8.5,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text('Super Admin '),
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
                  Fluttertoast.showToast(
                      msg: nom + ' ' + prenom,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              label: 'Ajouter un Admin',
              labelColour: Colors.white,
              backgroundColour: Colors.green,
              shadowColour: Color(0xff866DC9).withOpacity(0.16),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/admin-signup',
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              label: 'Gestion des Admins',
              labelColour: Colors.white,
              backgroundColour: Colors.green,
              shadowColour: Color(0xff866DC9).withOpacity(0.16),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/manage-admins',
                );
                //  Provider.of<Auth>(context, listen: false).fetchAdmins();
              },
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              label: 'Gestion des Commandes',
              labelColour: Colors.white,
              backgroundColour: Colors.green,
              shadowColour: Color(0xff866DC9).withOpacity(0.16),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/manage-orders',
                );
                //  Provider.of<Auth>(context, listen: false).fetchAdmins();
              },
            ),
          ],
        ),
      ),
    );
  }
}
