import 'package:Deco_store_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Welcome'),
        backgroundColor: Colors.red,
      ),
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
                padding: const EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Votre Role',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                    label: 'Admin',
                    labelColour: Colors.white,
                    backgroundColour: Colors.green,
                    shadowColour: Color(0xff866DC9).withOpacity(0.16),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/admin-login',
                      );
                    }),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                    label: 'Utilisateur',
                    labelColour: Colors.white,
                    backgroundColour: Colors.green,
                    shadowColour: Color(0xff866DC9).withOpacity(0.16),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/user-login',
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
