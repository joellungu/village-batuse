import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'details_historique.dart';

class Historiques extends StatelessWidget {
  //
  RxMap commandes = {}.obs;
  //
  var box = GetStorage();
  //
  DateTime d = DateTime.now();
  //
  Historiques() {
    commandes.value = box.read("${d.day}-${d.month}-${d.year}") ?? {};
  }
  //List l = box.read("commandes") ?? [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historiques"),
      ),
      body: commandes['commandes'] != null
          ? Obx(
              () => ListView(
                padding: EdgeInsets.all(20),
                children: List.generate(commandes['commandes'].length, (index) {
                  //
                  Map e = commandes['commandes'][index];
                  return ListTile(
                    onTap: () {
                      Get.to(DetailsHistorique(e));
                    },
                    title: Text("TABLE N° ${e['nTable']}"),
                    subtitle: Text("Date ${commandes['dateCommande']}"),
                  );
                }),
              ),
            )
          : Container(),
    );
  }
}
