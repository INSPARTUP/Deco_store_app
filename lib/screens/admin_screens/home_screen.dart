import 'package:deco_store_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'admin_navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we add <>to let it know which type of data you actually want to listening to.

    final List<Color> clr = [Colors.red, Colors.green, Colors.blue];
    final names = [
      'Gestion de stock',
      'Consluter les commandes',
    ];
    final icons = [
      'lib/assets/icons/warehouse.svg',
      'lib/assets/icons/list.svg',
    ];

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
        title: Text(' Produits', style: TextStyle(color: Colors.black)),
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
                  return AdminNavigationScreen(1);
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
                  return AdminNavigationScreen(2);
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
        ],
      ),
    );
  }
}
