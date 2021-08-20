import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord; //badalna nom ta3ha

class OrderItem extends StatefulWidget {
  // hna baghyin nbadlo ghi had l widget ki nodorko f button ta3 expanded 3la biha rodinaha statefull  (appliquina widget(local) state) w makhdamnach b provider psq widget lokhrin manbadloch fihom walo ki nodorko expanded
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      height:
          _expanded ? min(widget.order.items.length * 20.0 + 110.0, 250) : 93,
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
                          .format(widget.order.dateTime),
                    ),
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
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
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
                    ? min(widget.order.items.length * 20.0 + 10.0, 110)
                    : 0,
                child: ListView(
                    children: widget.order.items
                        .map((prod) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  prod.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${prod.qty}x \$${prod.price}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ))
                        .toList()
                    // we use map to convet list of Data to list of widgets

                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
