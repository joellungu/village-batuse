import 'package:flutter/material.dart';

import 'bar.dart';
import 'chicha.dart';

class BarAccueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouvvelle commandes"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       //
        //       DateTime dd = DateTime.now();
        //       //
        //       String datecommande = "${dd.day}-${dd.month}-${dd.year}";
        //       print("la date: $datecommande");
        //       //
        //     },
        //     icon: Icon(Icons.abc),
        //   ),
        // ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Bar(),
          ),
          Expanded(
            flex: 5,
            child: Chicha(),
          ),
        ],
      ),
    );
  }
}
