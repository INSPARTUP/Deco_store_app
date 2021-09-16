import 'dart:math';

import 'package:deco_store_app/providers/orders.dart';
import 'package:deco_store_app/screens/admin_screens/edit_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';
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
/*
  @override
  void initState() {
    // TODO: implement initState

    if (DateTime.now().isAfter(widget.order.deliveredAt))
      Provider.of<Orders>(context, listen: false).arriver(widget.order.id);

    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.order.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment
            .centerRight, // to align it in the center vertically but on the right horizontally
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,

      confirmDismiss: (direction) {
        SweetAlertV2.show(context,
            subtitle: 'êtes-vous sûr de vouloir supprimer cette commande ?',
            subtitleTextAlign: TextAlign.center,
            style: SweetAlertV2Style.confirm,
            cancelButtonText: 'Annuler',
            confirmButtonText: 'Confirmer',
            showCancelButton: true, onPress: (bool isConfirm) {
          if (isConfirm) {
            SweetAlertV2.show(context,
                subtitle: "Suppression...", style: SweetAlertV2Style.loading);
            Provider.of<Orders>(context, listen: false)
                .deleteOrder(widget.order.id)
                .then((value) => SweetAlertV2.show(context,
                    subtitle: "Succés!", style: SweetAlertV2Style.success));
          } else {
            SweetAlertV2.show(context,
                subtitle: "Annulé!", style: SweetAlertV2Style.error);
          }

          // return false to keep dialog
          return false;
        });

        setState(
          () {
            _expanded = false;
          },
        );
      },
      onDismissed:
          (direction) {}, //direction za3ma 3la 7ssab kol direction n7arko ndiro function ta3ha chawa hna 3adna ghi direction wa7da

      child: Column(
        children: [
          SizedBox(height: 5),
          SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(microseconds: 300),
              height: _expanded
                  ? min(widget.order.items.length * 40.0 + 250.0, 400)
                  : 150,
              child: Card(
                margin: EdgeInsets.all(10),
                child: /*SingleChildScrollView(
                  child:*/
                    ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('\$ ${widget.order.grandTotal}'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditOrder(widget.order),
                          ),
                        );
                      },
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy hh:mm aa').format(
                                widget.order.createdAt.add(Duration(hours: 1))),
                          ),
                          Text(
                            widget.order.accepted == true
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
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent[700]),
                                )
                              : SizedBox(height: 0),
                          widget.order.accepted
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
                        icon: Icon(
                            _expanded ? Icons.expand_less : Icons.expand_more),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      height: _expanded
                          ? min(widget.order.items.length * 30.0 + 70.0, 150)
                          : 0,
                      child: ListView(children: [
                        ...widget.order.items
                            .map((prod) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            SweetAlertV2.show(context,
                                subtitle:
                                    'êtes-vous sûr de vouloir supprimer cette commande ?',
                                subtitleTextAlign: TextAlign.center,
                                style: SweetAlertV2Style.confirm,
                                cancelButtonText: 'Annuler',
                                confirmButtonText: 'Confirmer',
                                showCancelButton: true,
                                onPress: (bool isConfirm) {
                              if (isConfirm) {
                                SweetAlertV2.show(context,
                                    subtitle: "Suppression...",
                                    style: SweetAlertV2Style.loading);
                                Provider.of<Orders>(context, listen: false)
                                    .deleteOrder(widget.order.id)
                                    .then((value) => SweetAlertV2.show(context,
                                        subtitle: "Succés!",
                                        style: SweetAlertV2Style.success));
                              } else {
                                SweetAlertV2.show(context,
                                    subtitle: "Annulé!",
                                    style: SweetAlertV2Style.error);
                              }

                              // return false to keep dialog
                              return false;
                            });

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

                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
