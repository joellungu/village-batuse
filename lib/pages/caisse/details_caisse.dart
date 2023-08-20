import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_batuse/pages/caisse/caisse_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';

class DetailsCaisse extends StatelessWidget {
  Map e;
  DetailsCaisse(this.e);
  //
  RxDouble totalPL = 0.0.obs;
  RxDouble totalBs = 0.0.obs;
  RxDouble totalCh = 0.0.obs;
  //
  AppController appController = Get.find();
  //
  CaisseController caisseController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          width: 500,
          child: ListView(
            children: [
              Column(
                children: List.generate(e['boissons'].length, (index) {
                  Map boisson = e['boissons'][index];
                  totalBs.value += (boisson['prix'] * boisson['quantite']);
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
                                    "\n${boisson['nom']}",
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
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${boisson['prix']} ${boisson['devise']}\n",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
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
              ),
              e['boissons'].isEmpty
                  ? Container()
                  : Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          "total boissons : $totalBs USD",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: List.generate(e['chichas'].length, (index) {
                  Map chicha = e['chichas'][index];
                  totalCh.value += (chicha['prix'] * chicha['quantite']);
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
              ),
              e['chichas'].isEmpty
                  ? Container()
                  : Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          "total chicas : $totalCh USD",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: List.generate(e['plats'].length, (index) {
                  Map plat = e['plats'][index];
                  totalPL.value += plat['prix'];
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
                                    "\n${plat['nom']}",
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
                                            jsonDecode(plat['accompagnement'])
                                                .length, (udex) {
                                          Map acc = jsonDecode(
                                              plat['accompagnement'])[udex];
                                          print('le acc vaut: $acc');
                                          //
                                          totalPL.value += (acc['prix'] *
                                              int.parse(acc['quantite']));
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
              e['plats'].isEmpty
                  ? Container()
                  : Container(
                      height: 50,
                      width: 500,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          "total plats : $totalPL USD",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
            ],
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
            e["imprimer"] = "oui";
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
              //
              caisseController.getCommandeCaisse();
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
            child: Text("IMPRIMER"),
          ),
        ),
      ),
    );
  }
}
