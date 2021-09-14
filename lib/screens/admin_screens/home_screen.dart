import 'package:deco_store_app/providers/auth.dart';
import 'package:deco_store_app/screens/admin_screens/super_admin_navigation_screen.dart';
import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../profile_screen.dart';
import 'admin_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we add <>to let it know which type of data you actually want to listening to.

    final List<Color> clr = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.amberAccent
    ];
    final names = [
      'Gestion de stock',
      'Consluter les commandes',
      'Gestion des Admins',
      'Profile',
    ];
    final icons = [
      'lib/assets/icons/warehouse.svg',
      'lib/assets/icons/list.svg',
      'lib/assets/icons/admin.svg',
      'lib/assets/icons/profile.svg',
    ];

    final role = Provider.of<Auth>(context, listen: false).roles;
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
        title: Text(' Accueil', style: TextStyle(color: Colors.black)),
      ),
      drawer: AppDrawer(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return role == 'ROLE_SUPER-ADMIN'
                      ? SuperAdminNavigation(1)
                      : AdminNavigationScreen(1);
                }),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              decoration: BoxDecoration(
                color: clr[0],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    icons[0],
                    width: 100,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    names[0],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return role == 'ROLE_SUPER-ADMIN'
                      ? SuperAdminNavigation(2)
                      : AdminNavigationScreen(2);
                }),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              decoration: BoxDecoration(
                color: clr[1],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    icons[1],
                    width: 100,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    names[1],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return role == 'ROLE_SUPER-ADMIN'
                      ? ProfileScreen()
                      : AdminNavigationScreen(3);
                }),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              decoration: BoxDecoration(
                color: clr[3],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    icons[3],
                    width: 100,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    names[3],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          role == 'ROLE_SUPER-ADMIN'
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SuperAdminNavigation(3);
                      }),
                    );
                  },
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                    decoration: BoxDecoration(
                      color: clr[2],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          icons[2],
                          width: 100,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          names[2],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}
