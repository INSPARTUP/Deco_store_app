import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/providers/orders.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:deco_store_app/widgets/super_admin_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../widgets/order_item_widget.dart';

class ManageOrders extends StatelessWidget {
  const ManageOrders({Key key}) : super(key: key);
  static const routeName = '/manage-orders';

  Future<void> _refreshOrders(BuildContext ctx) async {
    Provider.of<Orders>(ctx, listen: false).fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final role = Provider.of<Auth>(context, listen: false).roles;

    return Scaffold(
      appBar: AppBar(
        elevation: 8.5,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text('Les Commandes', style: TextStyle(color: Colors.black)),
        /* leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              "lib/assets/icons/arrow-long-left.svg",
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),*/
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
      ),
      drawer: role == 'ROLE_ADMIN'
          ? AppDrawer()
          : role == 'ROLE_SUPER-ADMIN'
              ? SuperAdminDrawer()
              : SuperAdminDrawer(),
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
                child: Text('Erreur!'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _refreshOrders(
                  context,
                ),
                child: Consumer<Orders>(
                  // darna Consumer psq nas7a9o ghi Listview tdir rebuilding ida sra changement f provider orders mchi ga3 orders_overview (za3ma mchi ga3 build ta3 orders_overview)
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.allOrders.length,
                    itemBuilder: (ctx, i) =>
                        OrderItemWidget(orderData.allOrders[i]),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
