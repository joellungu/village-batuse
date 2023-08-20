import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';
import 'package:village_batuse/utils/requete.dart';

import 'plats_controller.dart';

class DetailsPlat extends StatelessWidget {
  Map plat;
  int ind;
  //
  State st;
  //
  CommandeController commandeController = Get.find();
  //
  DetailsPlat(this.plat, this.ind, this.st);
  //
  PlatController platController = Get.find();
  AppController appController = Get.find();
  //
  int choix = 1;
  //
  RxList accompagnements = [].obs;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${plat['nom']}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${Requete.urlSt}plat/photo/${plat['id']}"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.center,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "${plat['nom']}\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${plat['prix']} ${plat['devise']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Accompagnements",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: FutureBuilder(
                                    future: platController.allIfAccs(),
                                    builder: (c, t) {
                                      if (t.hasData) {
                                        List l = t.data as List;
                                        //
                                        return DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            value: choix,
                                            isExpanded: true,
                                            items: List.generate(l.length,
                                                (index) {
                                              Map acc = l[index];
                                              return DropdownMenuItem(
                                                value: index,
                                                child: Text("${acc['nom']}"),
                                              );
                                            }),
                                            onChanged: (e) {
                                              //
                                              choix = e as int;
                                              accompagnements.add(l[choix]);
                                            },
                                          ),
                                        );
                                      } else if (t.hasError) {
                                        return Container();
                                      }

                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Obx(
                                () => ListView(
                                  children: List.generate(
                                      accompagnements.length, (index) {
                                    Map acc = accompagnements[index];
                                    return Card(
                                      elevation: 1,
                                      child: SizedBox(
                                        height: 130,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                color: Colors.red.shade900,
                                                height: double.infinity,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                child: Text.rich(
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                  ),
                                                  TextSpan(
                                                    text: "${acc['nom']}\n",
                                                    children: [
                                                      TextSpan(
                                                        text: "Prix: ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${acc['prix']} ${acc['devise']}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: TextField(
                                                  onChanged: (t) {
                                                    acc["quantite"] = t;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: "Quantité",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              110),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                accompagnements.removeAt(index);
                                              },
                                              icon: Icon(Icons.delete),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    //    accompagnement
                    plat["accompagnement"] = jsonEncode(accompagnements);
                    //appController.platsLegumes.add(plat);
                    //
                    var box = GetStorage();
                    //
                    //chicha["quantite"] = nb.text;
                    //
                    commandeController.commandePlats =
                        box.read("commandePlats$ind") ?? [];
                    //
                    commandeController.commandePlats.add(plat);

                    // commandeController
                    //     .commandeBoissons
                    //     .value = bs;

                    //print(
                    //  "commandeBoissons$ind: ${commandeController.commandeBoissons.value}");
                    box.write(
                        "commandePlats$ind", commandeController.commandePlats);
                    //
                    Get.back();
                    //
                    st.setState(() {});
                    //
                    Get.snackbar("Succès", "Commande ajouté avec succès");
                  },
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "Ajouter",
                      textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
