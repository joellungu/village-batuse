import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsHistorique extends StatelessWidget {
  Map appController;
  DetailsHistorique(this.appController);
  //
  RxDouble totalPL = 0.0.obs;
  RxDouble totalBs = 0.0.obs;
  RxDouble totalCh = 0.0.obs;
  //
  //
  double prixFranc = 0.0;
  double prixDollar = 0.0;
  //
  static const platform = MethodChannel('samples.flutter.dev/battery');
  //
  List accs = [];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "TABLE N° ${appController["nTable"]} || SECTION ${appController["lieuCommande"]}"),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "PLATS ET LÉGUMES",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: appController["platsLegumes"] != null
                        ? ListView(
                            children: List.generate(
                                appController["platsLegumes"].length, (index) {
                              Map pl = appController["platsLegumes"][index];
                              //
                              RxDouble total = 0.0.obs;
                              //
                              totalPL.value += pl['prix'];
                              total.value += pl['prix'];
                              //
                              return Card(
                                elevation: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 170,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Expanded(
                                      //   flex: 3,
                                      //   child: Container(
                                      //     alignment: Alignment.center,
                                      //     padding: const EdgeInsets.all(10),
                                      //     child: Container(
                                      //       height: 120,
                                      //       width: 200,
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         image: const DecorationImage(
                                      //           image: ExactAssetImage(
                                      //               "assets/bouffe 3.jpg"),
                                      //           fit: BoxFit.cover,
                                      //         ),
                                      //         borderRadius:
                                      //             BorderRadius.circular(100),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${pl['nom']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${pl['prix']} ${pl['devise']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            //Kwanga (2), Pilipili, Makemba (3), Fufu (2)
                                            Align(
                                              alignment: Alignment.center,
                                              child: RichText(
                                                text: TextSpan(
                                                    text: "",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    children: List.generate(
                                                        jsonDecode(pl[
                                                                'accompagnement'])
                                                            .length, (udex) {
                                                      Map acc = jsonDecode(pl[
                                                              'accompagnement'])[
                                                          udex];
                                                      print(
                                                          'le acc vaut: $acc');
                                                      //
                                                      //totalPL.value +=
                                                      //  acc['prix'];
                                                      total.value += (acc[
                                                              'prix'] *
                                                          int.parse(
                                                              acc['quantite']));
                                                      //////////
                                                      totalPL.value += (acc[
                                                              'prix'] *
                                                          int.parse(
                                                              acc['quantite']));
                                                      //
                                                      return TextSpan(
                                                          //${acc['prix']} ${acc['devise']}
                                                          text:
                                                              "${acc['nom']} (${acc['quantite']})");
                                                    })),
                                              ),
                                              // child: Text(
                                              //   "${pl['accompagnement'].reduce((value, element) => value["nom"] + ',' + element["nom"])}",
                                              //   style: TextStyle(
                                              //     fontWeight: FontWeight.normal,
                                              //     color: Colors.black,
                                              //     fontSize: 13,
                                              //   ),
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Obx(
                                                () => Text(
                                                  "TOTAL ${total.value} ${pl['devise']}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     //
                                      //     appController.platsLegumes
                                      //         .removeAt(index);
                                      //   },
                                      //   icon: const Icon(Icons.delete),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        : Container(),
                  ),
                  Container(
                    height: 40,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        "TOTAL ${totalPL.value} USD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "BOISSONS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: appController["boissons"] != null
                        ? ListView(
                            children: List.generate(
                              appController["boissons"].length,
                              (index) {
                                Map bs = appController["boissons"][index];
                                //
                                RxDouble total = 0.0.obs;
                                //
                                totalBs.value +=
                                    (bs['prix'] * int.parse(bs['quantite']));
                                total.value +=
                                    (bs['prix'] * int.parse(bs['quantite']));

                                //
                                return Card(
                                  elevation: 0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 170,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${bs['nom']}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        "Quantité (${bs['quantite']})",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                // child: Text(
                                                //   "${pl['accompagnement'].reduce((value, element) => value["nom"] + ',' + element["nom"])}",
                                                //   style: TextStyle(
                                                //     fontWeight: FontWeight.normal,
                                                //     color: Colors.black,
                                                //     fontSize: 13,
                                                //   ),
                                                // ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${bs['prix']} ${bs['devise']}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     //
                                        //     appController.boissons
                                        //         .removeAt(index);
                                        //   },
                                        //   icon: const Icon(Icons.delete),
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    height: 40,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        "TOTAL ${totalBs.value} USD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "CHICHA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: appController["chichas"] != null
                        ? ListView(
                            children: List.generate(
                                appController["chichas"].length, (index) {
                              Map ch = appController["chichas"][index];
                              //
                              RxDouble total = 0.0.obs;
                              //
                              totalCh.value +=
                                  (ch['prix'] * int.parse(ch['quantite']));
                              total.value +=
                                  (ch['prix'] * int.parse(ch['quantite']));
                              //
                              return Card(
                                elevation: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 170,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${ch['nom']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      "Quantité (${ch['quantite']})",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              // child: Text(
                                              //   "${pl['accompagnement'].reduce((value, element) => value["nom"] + ',' + element["nom"])}",
                                              //   style: TextStyle(
                                              //     fontWeight: FontWeight.normal,
                                              //     color: Colors.black,
                                              //     fontSize: 13,
                                              //   ),
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${ch['prix']} ${ch['devise']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // IconButton(
                                      //   onPressed: () {
                                      //     //
                                      //     appController.chichas.removeAt(index);
                                      //   },
                                      //   icon: const Icon(Icons.delete),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        : Container(),
                  ),
                  Container(
                    height: 40,
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Obx(
                      () => Text(
                        "TOTAL ${totalCh.value} USD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () async {
            //
            //////////////////////////////////////////////////////////
            //
            accs = [];
            //
            String plts = getFacPlat(appController["platsLegumes"] ?? []);
            String boissons = getFacPlat(appController["boissons"] ?? []);
            String chichas = getFacPlat(appController["chichas"] ?? []);
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
              batteryLevel = "Failed to get battery level: '${e.message}'.";
            }
            print("le plts vaut: $fac");
            //////////////////////////////////////////////////////////////////
          },
          child: const Text("IMPRIMER"),
        ),
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
