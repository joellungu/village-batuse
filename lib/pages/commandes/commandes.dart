import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/historiques/historiques.dart';
import 'package:village_batuse/pages/rapports/rapports.dart';
import 'package:flutter/services.dart';
import 'commande_controller.dart';
import 'details_commande.dart';

class Commandes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Commandes();
  }
}

class _Commandes extends State<Commandes> {
  //
  static const platform = MethodChannel('samples.flutter.dev/battery');
  //
  double prixFranc = 0.0;
  double prixDollar = 0.0;
  //
  List accs = [];
  //
  CommandeController commandeController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("TABLES / COMMANDES"),
        actions: [
          IconButton(
            onPressed: () async {
              //
              Get.to(Historiques());
              //
              // DateTime d = DateTime.now();
              // //
              // var box = GetStorage();
              // //
              // Map c = box.read("${d.day}-${d.month}-${d.year}") ?? {};
              // //
              // String plts = getFacPlat(c['commandes'][0]['plats'] ?? []);
              // String boissons = getFacPlat(c['commandes'][0]['boissons'] ?? []);
              // String chichas = getFacPlat(c['commandes'][0]['chichas'] ?? []);
              // String accampagnements = getFacPlat(accs);
              // String fac = plts +
              //     boissons +
              //     chichas +
              //     accampagnements +
              //     "[C]--------------------------------\n" +
              //     "[R]TOTAL FRANC :[R]${prixFranc} CDF\n" +
              //     "[R]TAX :[R]4.23€\n" +
              //     "[L]\n" +
              //     "[R]TOTAL DOLLAR :[R]${prixDollar} USD\n" +
              //     "[R]TAX :[R]4.23€\n" +
              //     "[L]\n" +
              //     "[C]================================\n" +
              //     "[L]\n";

              // print("le plts vaut: $fac");
              // String batteryLevel;
              // try {
              //   final int result = await platform
              //       .invokeMethod('getBatteryLevel', {"facture": fac});
              //   batteryLevel = 'Battery level at $result % .';
              // } on PlatformException catch (e) {
              //   batteryLevel = "Failed to get battery level: '${e.message}'.";
              // }
              // print("le plts vaut: $fac");
              //////////////////////////////////////////////////////////////////
            },
            icon: const Icon(Icons.calendar_month),
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 7,
        children: List.generate(commandeController.commandes.length, (index) {
          //
          Map table = commandeController.commandes[index];
          //
          return Card(
            elevation: 1,
            child: InkWell(
              onTap: () {
                //
                Get.to(() => DetailsCommande(index));
                //
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${table['table']}",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "TABLE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "historique",
            onPressed: () {
              //
              Get.to(Rapport());
            },
            backgroundColor: Colors.red.shade900,
            child: const Icon(Icons.timelapse),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "table",
            onPressed: () {
              //
              Get.dialog(
                Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: Get.size.height,
                      width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.red.shade900,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NOUVELLE COMMANDE",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    //
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: ListView(
                                children: List.generate(
                                  100,
                                  (index) => ListTile(
                                    onTap: () {
                                      //
                                      var box = GetStorage();
                                      //
                                      Map commande = {"table": index + 1};
                                      //
                                      bool ajoute = false;
                                      //
                                      commandeController.commandes =
                                          box.read("commandes") ?? [];
                                      //
                                      for (int i = 0;
                                          i <
                                              commandeController
                                                  .commandes.length;
                                          i++) {
                                        //
                                        if (commandeController.commandes[i]
                                                ['table'] ==
                                            (index + 1)) {
                                          //
                                          ajoute = true;
                                          break;
                                        } else {
                                          //
                                          ajoute = false;
                                        }
                                      }
                                      //
                                      if (ajoute) {
                                        //
                                        Get.back();
                                        //
                                        Get.defaultDialog(
                                          title: "Erreur",
                                          titleStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                          content: const Text(
                                            "Cette table est déjà prise !",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          backgroundColor: Colors.red.shade900,

                                          //colorText: Colors.white,
                                        );
                                      } else {
                                        commandeController.commandes
                                            .add(commande);
                                        //
                                        List l = box.read("commandes") ?? [];
                                        l = commandeController.commandes;
                                        //
                                        box.write("commandes", l);
                                        //
                                        Get.back();
                                        //
                                        setState(() {});
                                      }
                                      //
                                    },
                                    title: Text(
                                      "TABLE",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            backgroundColor: Colors.red.shade900,
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

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

  //
  String getFacBoissons(List p) {
    //
    String produit = "";
    //
    for (Map plat in p) {
      //
      if (plat['devise'] != "USD") {
        prixFranc += prixFranc;
      } else {
        prixDollar += prixDollar;
      }
      produit = produit +
          "[L]\n" +
          "[L]<b>${plat['nom']}</b>[R]${plat['prix']} ${plat['devise']}\n";

      //"[L]\n";
    }
    //
    produit = produit + "[L]\n";
    //
    return produit;
  }
  //
}
