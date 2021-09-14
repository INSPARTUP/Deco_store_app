import 'package:deco_store_app/providers/orders.dart';
import 'package:deco_store_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditOrder extends StatefulWidget {
  static final routeName = "edit-order";

  final OrderItem order;
  EditOrder(this.order);

  @override
  _EditOrderState createState() => _EditOrderState();
}

GlobalKey<FormState> _key = new GlobalKey();
int deliveryTime;

class _EditOrderState extends State<EditOrder> {
  @override
  Widget build(BuildContext context) {
    void _accepter() {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Délai '),
          content: Form(
            key: _key,
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Délai de livraison ',
              ),
              keyboardType: TextInputType.number,

              onChanged: (val) {
                deliveryTime = int.parse(val);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Veuillez entrer le Délai de livraison ';
                } else if (double.tryParse(value) == null) {
                  return 'Veuillez entrer un numéro valide.'; // exemple ndakhlo String sama man9adoch n convertoh l double using double.parse(value)
                } else if (double.parse(value) <= -1) {
                  return 'Veuillez saisir un nombre supérieur à -1.';
                }
              },
              //  onSubmitted:
              // _recherche(), //  hadi ida bghit ydir recherche directement
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(false),
              // this will close the dialog and now here, we can also forward a value 'false'
            ),
            FlatButton(
                child: Text('Ok'),
                onPressed: () => {
                      if (_key.currentState.validate())
                        {
                          Provider.of<Orders>(context, listen: false)
                              .accepterOrder(widget.order.id, deliveryTime)
                              .then((value) => setState(() {
                                    widget.order.accepted = true;
                                    widget.order.deliveryTime = deliveryTime;
                                  })),
                          Navigator.of(context).pop(true)
                        }
                      else
                        null
                    }
                // this will close the dialog and now here, we can also forward a value 'true'
                )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 8.5,
        shadowColor: Colors.black,
        title: Text(
          "Consulter la commande",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildShoppingCartItem(context),
              Container(
                padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                height: widget.order.items.length * 40.0 + 100.0,
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: <Widget>[
                        ...widget.order.items
                            .map((prod) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          prod.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${prod.qty}x \$${prod.price}',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Total:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("\$" + widget.order.grandTotal.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.order.accepted
                      ? Column(
                          children: [
                            Text("La commande a été acceptée",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            Text(
                                "La Date d'arrivé est: " +
                                    DateFormat('dd/MM/yyyy')
                                        .format(widget.order.deliveredAt),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                          ],
                        )
                      : SizedBox(height: 0)),
              Padding(
                padding: EdgeInsets.only(
                    top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
                child: Expanded(
                    child: CustomButton(
                  label: 'Accepter',
                  labelColour: Colors.white,
                  backgroundColour: Colors.green[300],
                  shadowColour: Color(0xFF08f55b).withOpacity(0.20),
                  onPressed: !widget.order.accepted ? _accepter : null,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildShoppingCartItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      height: 250,
      child: Card(
        child: Container(
          width: (MediaQuery.of(context).size.width) / 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text('Details de la commande',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 15),
                Text('  Les informations du Client:',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                Text(
                  '     Nom: ' + widget.order.user.name,
                ),
                Text(
                  '     Email: ' + widget.order.user.email,
                ),
                SizedBox(height: 15),
                Text("  L'Adresse:",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                Text(
                  '     ' +
                      widget.order.billingAddress.deliveryAddress +
                      ',' +
                      widget.order.billingAddress.postCode +
                      ',' +
                      widget.order.billingAddress.country,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
