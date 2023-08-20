import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/utils/requete.dart';

import 'rapports_controller.dart';

class Rapport extends GetView<RapportController> {
  //
  var box = GetStorage();
  //
  Map agent = {};
  Rapport() {
    agent = box.read("user");
    controller.load();
  }
  //
  RxString date = "Date".obs;
  //
  RxString section = "Avant".obs;
  RxString categorie = "boissons".obs;
  //

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rapport"),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            //
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2030),
                            ).then((d) {
                              //

                              //
                              date.value = "${d!.day}-${d.month}-${d.year}";
                              //
                            });
                          },
                          child: Text(
                            "$date",
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.grey.shade700,
                        child: Text(
                          "${agent['section']}",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Expanded(
                    //   flex: 3,
                    //   child: Container(
                    //     color: Colors.grey,
                    //     child: Obx(
                    //       () => DropdownButtonHideUnderline(
                    //         child: DropdownButton(
                    //           focusColor: Colors.grey,
                    //           //dropdownColor: ,
                    //           isExpanded: true,
                    //           value: categorie.value,
                    //           items: const [
                    //             DropdownMenuItem(
                    //               child: Text("Boissons"),
                    //               value: "boissons",
                    //             ),
                    //             DropdownMenuItem(
                    //               child: Text("Plats"),
                    //               value: "plats",
                    //             ),
                    //             DropdownMenuItem(
                    //               child: Text("Legumes"),
                    //               value: "legumes",
                    //             ),
                    //             DropdownMenuItem(
                    //               child: Text("Accompagnement"),
                    //               value: "accompagnement",
                    //             ),
                    //             //
                    //             DropdownMenuItem(
                    //               child: Text("Chichas"),
                    //               value: "chichas",
                    //             ),
                    //           ],
                    //           onChanged: (e) {
                    //             //
                    //             categorie.value = e as String;
                    //             //accompagnements.add(e);
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () async {
                          //
                          Map agent = box.read("user");
                          // if (categorie.value == "plats") {
                          //   controller.allRapportPlatsLegumes(date.value,
                          //       categorie.value, "Plat", section.value);
                          // } else if (categorie.value == "legumes") {
                          //   controller.allRapportPlatsLegumes(
                          //       date.value, "plats", "Légume", section.value);
                          // } else {
                          //   controller.allRapport(
                          //       date.value, categorie.value, section.value);
                          // }
                          controller.allRapport(
                            date.value,
                            agent['section'],
                          );
                        },
                        child: const Text(
                          "AFFICHER",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: controller.obx(
                (state) {
                  List rapports = state!;
                  print(rapports);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: p,
                                decoration: b,
                                child: Text(
                                  "Categorie",
                                  style: s,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Nom",
                                  style: s,
                                ),
                                padding: p,
                                decoration: b,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Prix unitaire",
                                  style: s,
                                ),
                                padding: p,
                                decoration: b,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Quantité",
                                  style: s,
                                ),
                                padding: p,
                                decoration: b,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Text(
                                  "Prix Total",
                                  style: s,
                                ),
                                padding: p,
                                decoration: b,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: List.generate(rapports.length, (index) {
                            Map rapport = rapports[index];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: p,
                                    decoration: b,
                                    height: 50,
                                    //alignment: Alignment.center,
                                    child: Text(
                                      "${rapport['categorie']}".toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.green.shade900,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    padding: p,
                                    decoration: b,
                                    child: Text(
                                      "${rapport['nom']}".toUpperCase(),
                                      style: s,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    padding: p,
                                    decoration: b,
                                    child: Text(
                                      "${rapport['prix-unitaire']} ${rapport['devise']}",
                                      style: s,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    padding: p,
                                    decoration: b,
                                    child: Text(
                                      "${rapport['nombre']}",
                                      style: s,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    padding: p,
                                    decoration: b,
                                    child: Text(
                                      "${rapport['prix-total']} ${rapport['devise']}",
                                      style: s,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      )
                    ],
                  );
                },
                onEmpty: Container(),
                onLoading: const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    "${controller.totalFranc.value} CDF",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    "${controller.totalDollar.value} USD",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var b = BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 1,
    ),
  );
  var p = EdgeInsets.only(left: 10);
  var s = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
