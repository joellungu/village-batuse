import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/accueil.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:flutter/services.dart';
import 'commande_boissons.dart';
import 'commande_chichas.dart';
import 'commande_plats.dart';

class DetailsCommande extends StatelessWidget {
  //
  double prixFranc = 0.0;
  double prixDollar = 0.0;
  //
  static const platform = MethodChannel('samples.flutter.dev/battery');
  //
  List accs = [];
  //
  CommandeController commandeController = Get.find();
  //
  int index;
  //
  DetailsCommande(this.index);
  //
  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    //
    return super.debugDescribeChildren();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("TABLE N° ${commandeController.commandes[index]['table']}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: CommandePlats(index),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: CommandeBoissons(
                      index,
                      key: UniqueKey(),
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: CommandeChichas(index),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                //
                Get.dialog(
                  Container(
                    height: 40,
                    width: 40,
                    child: const CircularProgressIndicator(),
                    alignment: Alignment.center,
                  ),
                );
                //
                var box = GetStorage();
                //
                Map agent = box.read("user");
                //
                List listePlats = box.read("commandePlats$index") ?? [];
                //
                List listeBoissons = box.read("commandeBoissons$index") ?? [];
                //
                List listeChichas = box.read("commandeChichas$index") ?? [];

                //
                DateTime d = DateTime.now(); //
                //
                //***************
                List commandes = box.read("commandes") ?? [];
                //
                Map e = {
                  "dateCommande": "${d.day}-${d.month}-${d.year}",
                  "plats": listePlats,
                  //"platsLivre": "non",
                  "boissons": listeBoissons,
                  //"boissonsLivre": "non",
                  "chichas": listeChichas,
                  //"chichasLivre": "non",
                  "imprimer": "non",
                  "lieuCommande": agent['section'],
                  "nTable": commandes[index]['table'],
                };
                //
                bool v = await commandeController.saveCommande(e);
                if (v) {
                  Map c = box.read("${d.day}-${d.month}-${d.year}") ?? {};
                  //
                  c['dateCommande'] = "${d.day}-${d.month}-${d.year}";
                  List l = c['commandes'] ?? [];
                  //
                  l.add(e);
                  c['commandes'] = l;
                  //
                  box.write("${d.day}-${d.month}-${d.year}", c);
                  //***************
                  commandes.removeAt(index);
                  //***************
                  box.write("commandes", commandes);
                  //
                  box.write("commandePlats$index", []);
                  //
                  box.write("commandeBoissons$index", []);
                  //
                  box.write("commandeChichas$index", []);
                  //***************
                  Get.back();
                  Get.offAll(Accueil());
                  //***************
                  Get.snackbar("Commande", "Votre commande a été enregistré",
                      backgroundColor: Colors.green.shade900);
                  //////////////////////////////////////////////////////////
                  //
                  accs = [];
                  //
                  String plts = getFacPlat(listePlats);
                  String boissons = getFacPlat(listeBoissons);
                  String chichas = getFacPlat(listeChichas);
                  String accampagnements = getFacPlat(accs);
                  String fac = plts +
                      boissons +
                      chichas +
                      accampagnements +
                      "[C]--------------------------------\n" +
                      "[R]TOTAL FRANC :[R]${prixFranc} CDF\n" +
                      "[R]TAX :[R]4.23€\n" +
                      "[L]\n" +
                      "[R]TOTAL DOLLAR :[R]${prixDollar} USD\n" +
                      "[R]TAX :[R]4.23€\n" +
                      "[L]\n" +
                      "[C]================================\n" +
                      "[L]\n";

                  print("le plts vaut: $fac");
                  String batteryLevel;
                  try {
                    final int result = await platform
                        .invokeMethod('getBatteryLevel', {"facture": fac});
                    batteryLevel = 'Battery level at $result % .';
                  } on PlatformException catch (e) {
                    batteryLevel =
                        "Failed to get battery level: '${e.message}'.";
                  }
                  print("le plts vaut: $fac");
                  //////////////////////////////////////////////////////////////////
                } else {
                  Get.back();
                  Get.snackbar(
                      "Commande", "Votre commande n'a pas été enregistré",
                      backgroundColor: Colors.red.shade900);
                }
                //
              },
              child: Text("IMPRIMER"))
        ],
      ),
    );
  }

  //
  String getFacPlat(List p) {
    //
    String produit = "";
    //
    for (Map plat in p) {
      //
      if (plat['accompagnement'] != null) {
        for (Map ac in jsonDecode(plat['accompagnement'])) {
          if (ac['devise'] != "USD") {
            prixFranc += ac['prix'] * int.parse(ac['quantite']);
          } else {
            prixDollar += ac['prix'] * int.parse(ac['quantite']);
          }
          accs.add(ac);
        }
      }
      //
      if (plat['devise'] != "USD") {
        if (plat['quantite'] != null) {
          prixFranc += plat['prix'] * int.parse(plat['quantite']);
        } else {
          prixFranc += plat['prix'];
        }
      } else {
        if (plat['quantite'] != null) {
          prixDollar += plat['prix'] * int.parse(plat['quantite']);
        } else {
          prixDollar += plat['prix'];
        }
      }

      if (plat['quantite'] != null) {
        produit = produit +
            "[L]\n" +
            "[L]<b>${plat['nom']}</b>[R]${plat['prix']} ${plat['devise']}\n" +
            "[L]  + Qt : ${plat['quantite']}\n";
      } else {
        produit = produit +
            "[L]\n" +
            "[L]<b>${plat['nom']}</b>[R]${plat['prix']} ${plat['devise']}\n";
      }

      //"[L]\n";
    }
    //
    produit = produit + "[L]\n";
    //
    return produit;
  }
}
