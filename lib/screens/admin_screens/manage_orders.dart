import 'package:deco_store_app/providers/orders.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../widgets/order_item_widget.dart';

class ManageOrders extends StatelessWidget {
  const ManageOrders({Key key}) : super(key: key);
  static const routeName = '/manage-orders';

  @override
  Widget build(BuildContext context) {
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
        title: Text('Les Commandes', style: TextStyle(color: Colors.black)),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAllOrders(),
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
                  itemCount: orderData.allOrders.length,
                  itemBuilder: (ctx, i) =>
                      OrderItemWidget(orderData.allOrders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
