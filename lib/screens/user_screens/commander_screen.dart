import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/orders.dart';
import 'package:deco_store_app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class CommanderScreen extends StatefulWidget {
  static const routeName = '/commander-screen';
  @override
  _CommanderScreenState createState() => _CommanderScreenState();
}

class _CommanderScreenState extends State<CommanderScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  var prenom, nom, numtel, email, codep, wilaya, pays, adresse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Entrez vos données'),
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Color(0xFFFAFBFD),
      body: Column(
        children: [
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
                color: Colors.blue[800],
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
                color: Colors.blue[800],
              ),
              hintText: 'Prénom',
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
              obscureText: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.blue[800],
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
            obscureText: false,
            decoration: InputDecoration(
              icon: Icon(
                CupertinoIcons.location_fill,
                color: Colors.blue[800],
              ),
              hintText: 'Pays',
            ),
            validator: validateCountry,
            onSaved: (String val) {
              pays = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              icon: Icon(
                CupertinoIcons.location_circle_fill,
                color: Colors.blue[800],
              ),
              hintText: 'Wilaya',
            ),
            validator: validateWilaya,
            onSaved: (String val) {
              wilaya = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
              obscureText: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                icon: Icon(
                  CupertinoIcons.map,
                  color: Colors.blue[800],
                ),
                hintText: 'Code Postal',
              ),
              maxLength: 5,
              validator: validateCodep,
              onSaved: (String val) {
                codep = val;
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              icon: Icon(
                CupertinoIcons.map_pin_ellipse,
                color: Colors.blue[800],
              ),
              hintText: 'Adresse',
            ),
            maxLength: 40,
            validator: validateAdr,
            onSaved: (String val) {
              adresse = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
          child: CustomButton(
            label: 'Commander',
            labelColour: Colors.white,
            backgroundColour: Colors.blue[800],
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

  String validateWilaya(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Le nom du wilaya est obligatoire";
    } else if (!regExp.hasMatch(value)) {
      return "Le nom du wilaya doit être a-z et A-Z";
    }
    return null;
  }

  String validateCountry(String value) {
    if (value.length == 0) {
      return "Le nom du pays est obligatoire";
    }
    return null;
  }

  String validateAdr(String value) {
    if (value.length == 0) {
      return "L'adresse est obligatoire";
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

  String validateCodep(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Le code postal est obligatoire";
    } else if (value.length != 5) {
      return "Le code postal doit être composé de 5 chiffres";
    } else if (!regExp.hasMatch(value)) {
      return "Le code postal doit être composé de chiffres";
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

  _sendToServer() async {
    final user_fullname = Provider.of<Auth>(context, listen: false).nom +
        ' ' +
        Provider.of<Auth>(context, listen: false).prenom;

    final user_email = Provider.of<Auth>(context, listen: false).email;
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    final productsList = arguments['cartitems'];
    final total = arguments['total'];
    print(total);

    List<ItemOrder> orderitems = [];
    productsList.forEach((k, v) => orderitems.add(ItemOrder(
        name: v.nom, price: v.prix, productId: v.productId, qty: v.quantite)));
    print(orderitems);
    final test = orderitems
        .map((cp) => {
              //execute forEach cart product
              'productId': cp.productId,
              'name': cp.name,
              'qty': cp.qty,
              'price': cp.price,
            })
        .toList();
    print(test);
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      try {
        await Provider.of<Orders>(context, listen: false).addOrder(
            User(name: user_fullname, email: user_email),
            BillingAddress(
                name: nom + ' ' + prenom,
                email: email,
                postCode: codep,
                wilaya: wilaya,
                deliveryAddress: adresse,
                country: pays),
            numtel,
            orderitems,
            total,
            context);
        SweetAlertV2.show(context,
            title: "Félicitation",
            subtitle: "Votre commande a été envoyée avec succés",
            style: SweetAlertV2Style.success,
            subtitleTextAlign: TextAlign.center);
      } catch (error) {
        print(error);
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Erreur!'),
            content: Text('Problemè avec votre commande'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
      Navigator.of(context).pop();
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
