import 'dart:math';

import 'package:deco_store_app/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' as ord; //badalna nom ta3ha

class OrderItemWidget extends StatefulWidget {
  // hna baghyin nbadlo ghi had l widget ki nodorko f button ta3 expanded 3la biha rodinaha statefull  (appliquina widget(local) state) w makhdamnach b provider psq widget lokhrin manbadloch fihom walo ki nodorko expanded
  final ord.OrderItem order;

  OrderItemWidget(this.order);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(microseconds: 300),
        height: _expanded
            ? min(widget.order.items.length * 40.0 + 170.0, 300)
            : 150,
        child: Card(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('\$ ${widget.order.grandTotal}'),
                  onTap: () => print(widget.order.id),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy hh:mm aa')
                            .format(widget.order.createdAt),
                      ),
                      Text(widget.order.accepted == true
                          ? 'Accepté'
                          : 'en cours de traitement'),
                      widget.order.accepted
                          ? Text(
                              "la date d'arrivé: " +
                                  DateFormat('dd/MM/yyyy')
                                      .format(widget.order.deliveredAt),
                            )
                          : null,
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
                  /*  IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false)
                              .deleteOrder(widget.order.id);
                        },
                      ),*/
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: _expanded
                      ? min(widget.order.items.length * 30.0 + 70.0, 150)
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

                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false)
                            .deleteOrder(widget.order.id);
                        setState(
                          () {
                            _expanded = !_expanded;
                          },
                        );
                      },
                    ),
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
