import 'dart:math';

import 'package:deco_store_app/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserOrderItem extends StatefulWidget {
  final OrderItem order;

  UserOrderItem(this.order);

  @override
  _UserOrderItemState createState() => _UserOrderItemState();
}

class _UserOrderItemState extends State<UserOrderItem> {
  void initState() {
    // TODO: implement initState

    if (DateTime.now().isAfter(widget.order.deliveredAt))
      Provider.of<Orders>(context, listen: false).arriver(widget.order.id);

    super.initState();
  }

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        height: _expanded
            ? min(widget.order.items.length * 40.0 + 120.0, 300)
            : 150,
        child: Card(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('\$ ${widget.order.grandTotal}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm aa')
                            .format(widget.order.createdAt),
                      ),
                      Text(
                        widget.order.accepted
                            ? 'Accepté'
                            : 'en cours de traitement',
                        style: TextStyle(
                            color: widget.order.accepted
                                ? Colors.green
                                : Colors.grey),
                      ),
                      widget.order.arrived
                          ? Text(
                              "La commande a été arrivée ",
                              style: TextStyle(color: Colors.green[300]),
                            )
                          : SizedBox(height: 0),
                      widget.order.arrived
                          ? Text(
                              "la date d'arrivé: " +
                                  DateFormat('dd/MM/yyyy')
                                      .format(widget.order.deliveredAt),
                              style: TextStyle(color: Colors.green),
                            )
                          : SizedBox(height: 0),
                      Text(
                        'Livraison : Gratuite',
                        style: TextStyle(fontSize: 12.5),
                      ),
                      Text(
                        'Mode de paiment : paiement à la livraison',
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(
                        () {
                          _expanded = !_expanded;
                        },
                      );
                    },
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: _expanded
                      ? min(widget.order.items.length * 30.0, 150)
                      : 0,
                  child: ListView(children: [
                    ...widget.order.items
                        .map((prod) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    prod.name,
                                    style: TextStyle(
                                      fontSize: 12,
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
                            ))
                        .toList(),
                    // we use map to convet list of Data to list of widgets
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
