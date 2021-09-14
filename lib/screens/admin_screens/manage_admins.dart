import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:deco_store_app/widgets/super_admin_app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

import 'adminsignup.dart';

class ManageAdmins extends StatefulWidget {
  static const routeName = '/manage-admins';
  const ManageAdmins({Key key}) : super(key: key);

  @override
  _ManageAdminsState createState() => _ManageAdminsState();
}

class _ManageAdminsState extends State<ManageAdmins> {
  Future<void> _refreshAdmins() async {
    await Provider.of<Auth>(context, listen: false).fetchAdmins();
    // the ovewall methode will only be doneonce this is done and only when this Future which is automatically returned will yield (resolve)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.5,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
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
        title: const Text('Liste des Admins',
            style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AdminSignup();
                }),
              );
            },
          ),
        ],
      ),
      drawer: SuperAdminDrawer(),
      body: FutureBuilder(
        //with the FutureBuilder,we will fetch data when (future: _refreshProducts(context),) load
        future: _refreshAdmins(),
        builder: (ctx, snapshot /*like response */) => snapshot
                    .connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshAdmins(),
                child: Consumer<Auth>(
                  builder: (ctx, adminsData, _) => Padding(
                    padding: EdgeInsets.all(8),
                    child: adminsData.admins.length == 0
                        ? Center(
                            child: Text(
                              "il n'existe pas des admins",
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            itemCount: adminsData.admins.length,
                            addAutomaticKeepAlives: true,
                            cacheExtent: 100000000.0,
                            itemBuilder: (_, i) => Column(
                              children: [
                                Dismissible(
                                  key: ValueKey(adminsData.admins[i].id),
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
                                        subtitle:
                                            'êtes-vous sûr de vouloir supprimer ce admin ?',
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
                                        Provider.of<Auth>(context,
                                                listen: false)
                                            .deleteAdmin(
                                                adminsData.admins[i].id)
                                            .then((value) => SweetAlertV2.show(
                                                context,
                                                subtitle: "Succés!",
                                                style:
                                                    SweetAlertV2Style.success));
                                      } else {
                                        SweetAlertV2.show(context,
                                            subtitle: "Annulé!",
                                            style: SweetAlertV2Style.error);
                                      }

                                      return false;
                                    });
                                  },
                                  onDismissed:
                                      (direction) {}, //direction za3ma 3la 7ssab kol direction n7arko ndiro function ta3ha chawa hna 3adna ghi direction wa7da

                                  child: ListTile(
                                    title: Text(
                                        adminsData.admins[i].nom +
                                            ' ' +
                                            adminsData.admins[i].prenom,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Email:" +
                                            ' ' +
                                            adminsData.admins[i].email),
                                        Text("Numéro de téléphone:" +
                                            ' ' +
                                            adminsData.admins[i].numtel),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        SweetAlertV2.show(context,
                                            subtitle:
                                                'êtes-vous sûr de vouloir supprimer ce admin ?',
                                            subtitleTextAlign: TextAlign.center,
                                            style: SweetAlertV2Style.confirm,
                                            cancelButtonText: 'Annuler',
                                            confirmButtonText: 'Confirmer',
                                            showCancelButton: true,
                                            onPress: (bool isConfirm) {
                                          if (isConfirm) {
                                            SweetAlertV2.show(context,
                                                subtitle: "Suppression...",
                                                style:
                                                    SweetAlertV2Style.loading);
                                            Provider.of<Auth>(context,
                                                    listen: false)
                                                .deleteAdmin(
                                                    adminsData.admins[i].id)
                                                .then((value) =>
                                                    SweetAlertV2.show(context,
                                                        subtitle: "Succés!",
                                                        style: SweetAlertV2Style
                                                            .success));
                                          } else {
                                            SweetAlertV2.show(context,
                                                subtitle: "Annulé!",
                                                style: SweetAlertV2Style.error);
                                          }

                                          return false;
                                        });
                                      },
                                      color: Theme.of(context).errorColor,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
