import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

class ManageAdmins extends StatefulWidget {
  static const routeName = '/manage-admins';
  const ManageAdmins({Key key}) : super(key: key);

  @override
  _ManageAdminsState createState() => _ManageAdminsState();
}

class _ManageAdminsState extends State<ManageAdmins> {
  Future<void> _refreshProducts() async {
    await Provider.of<Auth>(context, listen: false).fetchAdmins();
    // the ovewall methode will only be doneonce this is done and only when this Future which is automatically returned will yield (resolve)
  }

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
        title: const Text('Liste des Admins',
            style: TextStyle(color: Colors.black)),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        //with the FutureBuilder,we will fetch data when (future: _refreshProducts(context),) load
        future: _refreshProducts(),
        builder: (ctx, snapshot /*like response */) => snapshot
                    .connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(),
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
                                ListTile(
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
                                              style: SweetAlertV2Style.loading);
                                          Provider.of<Auth>(context,
                                                  listen: false)
                                              .deleteAdmin(
                                                  adminsData.admins[i].id)
                                              .then((value) =>
                                                  SweetAlertV2.show(
                                                      context,
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
