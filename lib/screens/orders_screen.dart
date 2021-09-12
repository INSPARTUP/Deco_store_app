import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/widgets/user_app_drawer.dart';
import 'package:deco_store_app/widgets/user_order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
// nas7a9o ghi Orders class.manas7a9och OrderItem lidiralna problem
import '../widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context).email;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              "lib/assets/icons/menu.svg",
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        title: Text('Vos Commandes', style: TextStyle(color: Colors.black)),
      ),
      drawer: UserAppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false)
            .fetchAndSetOrders(email),
        builder: (ctx, dataSnapshot) {
          //dataSnapshot is like response
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              print(dataSnapshot);
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                // darna Consumer psq nas7a9o ghi Listview tdir rebuilding ida sra changement f provider orders mchi ga3 orders_overview (za3ma mchi ga3 build ta3 orders_overview)
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => UserOrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

/* */
