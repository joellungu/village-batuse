import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_batuse/pages/bar/bar_controller.dart';
import 'package:village_batuse/pages/bar/chicha_controller.dart';
import 'package:village_batuse/pages/cuisine/cuisine_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';

class DetailsCommande extends StatelessWidget {
  Map e;
  int type;
  DetailsCommande(this.e, this.type);
  //
  AppController appController = Get.find();
  //
  BarController barController = Get.find();
  //
  ChichaController chichaController = Get.find();
  //
  CuisineController cuisineController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table n° ${e['nTable']}"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          width: 500,
          child: type == 1
              ? ListView(
                  children: List.generate(e['boissons'].length, (index) {
                    Map boisson = e['boissons'][index];
                    return Card(
                      elevation: 0,
                      child: Container(
                        //height: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${boisson['nom']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: Text(
                                  //     "${boisson['prix']} ${boisson['devise']}",
                                  //     style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.black,
                                  //       fontSize: 20,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${boisson['categorie']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.grey.shade700,
                                        fontStyle: FontStyle.italic,
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
                                      "Nombre ${boisson['quantite']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade700,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                )
              : type == 2
                  ? ListView(
                      children: List.generate(e['chichas'].length, (index) {
                        Map chicha = e['chichas'][index];
                        return Card(
                          elevation: 0,
                          child: Container(
                            //height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "\n${chicha['nom']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),

                                      // Align(
                                      //   alignment: Alignment.center,
                                      //   child: Text(
                                      //     "${boisson['prix']} ${boisson['devise']}",
                                      //     style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.black,
                                      //       fontSize: 20,
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${chicha['categorie']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.grey.shade700,
                                            fontStyle: FontStyle.italic,
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
                                          "Nombre ${chicha['quantite']}\n",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade700,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : ListView(
                      children: List.generate(e['plats'].length, (index) {
                        Map plat = e['plats'][index];
                        return Card(
                          elevation: 0,
                          child: Container(
                            //height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${plat['nom']}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // ),

                                      // Align(
                                      //   alignment: Alignment.center,
                                      //   child: Text(
                                      //     "${boisson['prix']} ${boisson['devise']}",
                                      //     style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.black,
                                      //       fontSize: 20,
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${plat['categorie']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Align(
                                      //   alignment: Alignment.center,
                                      //   child: Text(
                                      //     "Nombre ${plat['quantite']}",
                                      //     style: TextStyle(
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Colors.grey.shade700,
                                      //       fontSize: 25,
                                      //     ),
                                      //   ),
                                      // ),
                                      //
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      //
                                      Align(
                                        alignment: Alignment.center,
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Accompagnement: \n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.grey.shade700,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 20,
                                              ),
                                              children: List.generate(
                                                  jsonDecode(plat[
                                                          'accompagnement'])
                                                      .length, (udex) {
                                                Map acc = jsonDecode(
                                                        plat['accompagnement'])[
                                                    udex];
                                                print('le acc vaut: $acc');
                                                //

                                                //
                                                return TextSpan(
                                                  //${acc['prix']} ${acc['devise']}
                                                  text:
                                                      "${acc['nom']} (${acc['quantite']})\n",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 25,
                                                  ),
                                                );
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () async {
            //
            if (type == 1) {
              e["boissonsLivre"] = "oui";
            } else if (type == 2) {
              e["chichasLivre"] = "oui";
            } else {
              e["platsLivre"] = "oui";
            }
            //
            Get.dialog(
              Center(
                child: Container(
                  height: 40,
                  width: 40,
                  child: const CircularProgressIndicator(),
                  alignment: Alignment.center,
                ),
              ),
            );
            //
            bool v = await appController.updateCommande(e);
            if (v) {
              /**
               * BarController barController = Get.find();
  //
  ChichaController chichaController = Get.find();
  //
  CuisineController cuisineController = Get.find();
               */
              //
              if (type == 1) {
                barController.getCommandeBoissons();
                //e["boissonsLivre"] = "oui";
              } else if (type == 2) {
                chichaController.getCommandeChicha();
                //e["chichasLivre"] = "oui";
              } else {
                cuisineController.getCommandeCuisine();
                //e["platsLivre"] = "oui";
              }
              //
              Get.back();
              Get.back();
              Get.snackbar("Commande", "Commande livré");
            } else {
              Get.back();
              Get.back();
              Get.snackbar("Commande", "La Commande n'est pas livré");
            }
          },
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
              Size(
                250,
                45,
              ),
            ),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
            backgroundColor: MaterialStateProperty.all(Colors.green.shade700),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 200,
            child: Text("Valider"),
          ),
        ),
      ),
    );
  }
}
