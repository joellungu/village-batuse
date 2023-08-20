import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';
import 'package:village_batuse/utils/requete.dart';

import 'boisson_controller.dart';

class Boisson extends GetView<BoissonController> {
  //
  State st;
  //
  String categorie = "Jus";
  //
  CommandeController commandeController = Get.find();
  //
  int ind;
  //
  AppController appController = Get.find();
  //
  Boisson(this.ind, this.st) {
    controller.allIfBoissons(categorie);
  }
  //
  RxBool jus = true.obs,
      champagne = false.obs,
      mesure = false.obs,
      sucrees = false.obs,
      liqueur_wisky = false.obs,
      bieres_locales = false.obs,
      cocktail = false.obs;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boissons"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            child: Obx(
              () => ToggleButtons(
                onPressed: (e) {
                  //,,,,,,
                  if (e == 0) {
                    categorie = "Jus";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = true;
                    champagne.value = false;
                    mesure.value = false;
                    sucrees.value = false;
                    liqueur_wisky.value = false;
                    bieres_locales.value = false;
                    cocktail.value = false;
                  } else if (e == 1) {
                    categorie = "Champagne";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = false;
                    champagne.value = true;
                    mesure.value = false;
                    sucrees.value = false;
                    liqueur_wisky.value = false;
                    bieres_locales.value = false;
                    cocktail.value = false;
                  } else if (e == 2) {
                    categorie = "Mesure";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = false;
                    champagne.value = false;
                    mesure.value = true;
                    sucrees.value = false;
                    liqueur_wisky.value = false;
                    bieres_locales.value = false;
                    cocktail.value = false;
                  } else if (e == 3) {
                    categorie = "Sucrées";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = false;
                    champagne.value = false;
                    mesure.value = false;
                    sucrees.value = true;
                    liqueur_wisky.value = false;
                    bieres_locales.value = false;
                    cocktail.value = false;
                  } else if (e == 4) {
                    categorie = "Liqueur & Wisky";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = false;
                    champagne.value = false;
                    mesure.value = false;
                    sucrees.value = false;
                    liqueur_wisky.value = true;
                    bieres_locales.value = false;
                    cocktail.value = false;
                  } else if (e == 5) {
                    categorie = "Bières locales";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = false;
                    champagne.value = false;
                    mesure.value = false;
                    sucrees.value = false;
                    liqueur_wisky.value = false;
                    bieres_locales.value = true;
                    cocktail.value = false;
                  } else {
                    categorie = "Cocktail";
                    controller.allIfBoissons(categorie);
                    //
                    jus.value = false;
                    champagne.value = false;
                    mesure.value = false;
                    sucrees.value = false;
                    liqueur_wisky.value = false;
                    bieres_locales.value = false;
                    cocktail.value = true;
                  }
                },
                isSelected: [
                  jus.value,
                  champagne.value,
                  mesure.value,
                  sucrees.value,
                  liqueur_wisky.value,
                  bieres_locales.value,
                  cocktail.value,
                ],
                borderRadius: BorderRadius.circular(10),
                //textStyle: TextStyle(fontSize: 15),
                disabledBorderColor: Colors.grey.shade200,
                selectedColor: Colors.red.shade700,
                color: Colors.grey.shade700,
                fillColor: Colors.black,
                disabledColor: Colors.grey.shade200,
                borderColor: Colors.black,
                children: [
                  Text("        Jus       "),
                  Text("    Champagne     "),
                  Text("      Mesure      "),
                  Text("     Sucrees      "),
                  Text("  Liqueur  Wisky  "),
                  Text("  Bieres Locales  "),
                  Text("     Cocktail     "),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: controller.obx(
              (state) {
                List boissons = state!;
                return GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 4,
                  mainAxisSpacing: 0.9,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: List.generate(boissons.length, (index) {
                    Map boisson = boissons[index];
                    return Container(
                      //elevation: 0,
                      //shape: RoundedRectangleBorder(
                      //side: BorderSide(color: Colors.black, width: 2),
                      //),
                      child: InkWell(
                        onTap: () {
                          //
                          TextEditingController nb =
                              TextEditingController(text: "1");
                          //
                          Get.dialog(
                            AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(
                                  "Ajouter ${boisson['nom']} à la table ${commandeController.commandes[ind]['table']}"),
                              content: Container(
                                height: 200,
                                width: 200,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextField(
                                      controller: nb,
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                      decoration: InputDecoration(
                                          label: Text("Quantité"),
                                          labelStyle: TextStyle(
                                            fontSize: 30,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                  Size(
                                                    double.maxFinite,
                                                    45,
                                                  ),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red.shade900),
                                              ),
                                              onPressed: () {
                                                //
                                                Get.back();
                                                //Get.to(MProduitService({}));
                                              },
                                              child: Text("Annuler"),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                //
                                                var box = GetStorage();
                                                //
                                                boisson["quantite"] = nb.text;
                                                //
                                                commandeController
                                                    .commandeBoissons = box.read(
                                                        "commandeBoissons$ind") ??
                                                    [];
                                                //
                                                commandeController
                                                    .commandeBoissons
                                                    .add(boisson);

                                                // commandeController
                                                //     .commandeBoissons
                                                //     .value = bs;

                                                //print(
                                                //  "commandeBoissons$ind: ${commandeController.commandeBoissons.value}");
                                                box.write(
                                                    "commandeBoissons$ind",
                                                    commandeController
                                                        .commandeBoissons);
                                                //
                                                //appController.boissons
                                                //  .add(boisson);
                                                //
                                                Get.back();
                                                //
                                                st.setState(() {});
                                                //
                                                Get.snackbar("Panier",
                                                    "Votre boisson a été ajouté avec succes.");
                                                //Get.to(MProduitService({}));
                                              },
                                              style: ButtonStyle(
                                                fixedSize:
                                                    MaterialStateProperty.all(
                                                  Size(
                                                    double.maxFinite,
                                                    45,
                                                  ),
                                                ),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.green.shade900),
                                              ),
                                              child: Text("Ajouter"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          //Get.to(DetailsPlat({}));
                        },
                        child: SizedBox(
                          //height: Get.size.height / 4,
                          //width: Get.size.width / 3,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Container(
                                  //color: Colors.red,
                                  alignment: Alignment.center,
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    //height: 200,
                                    //width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${Requete.urlSt}boisson/photo/${boisson['id']}"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "${boisson['nom']}\n",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${boisson['prix']} ${boisson['devise']}",
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
                    );
                  }),
                );
              },
              onLoading: const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
              onEmpty: Container(),
            ),
          )
        ],
      ),
    );
  }
}
