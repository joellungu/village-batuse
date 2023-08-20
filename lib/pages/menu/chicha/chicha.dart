import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';
import 'package:village_batuse/utils/requete.dart';

import 'chicha_controller.dart';

class Chicha extends GetView<ChichaController> {
  RxBool plat = true.obs, legume = false.obs;
  //
  int ind;
  //
  State st;
  //
  AppController appController = Get.find();
  //
  CommandeController commandeController = Get.find();
  //
  Chicha(this.ind, this.st) {
    controller.allIfChichas(categorie);
  }
  //
  String categorie = "Plain air";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chicha"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  //
                  if (e == 0) {
                    plat.value = true;
                    legume.value = false;
                    categorie = "Plain air";
                    controller.allIfChichas(categorie);
                    //
                  } else {
                    plat.value = false;
                    legume.value = true;
                    categorie = "En boite";
                    controller.allIfChichas(categorie);
                    //
                  }
                },
                isSelected: [plat.value, legume.value],
                borderRadius: BorderRadius.circular(10),
                //textStyle: TextStyle(fontSize: 15),
                disabledBorderColor: Colors.grey.shade200,
                selectedColor: Colors.red.shade700,
                color: Colors.grey.shade700,
                fillColor: Colors.black,
                disabledColor: Colors.grey.shade200,
                borderColor: Colors.black,
                children: [
                  Text("  Plain air  "),
                  Text("  En boite   "),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: controller.obx(
              (state) {
                List chichas = state!;
                return GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 4,
                  mainAxisSpacing: 0.9,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: List.generate(chichas.length, (index) {
                    Map chicha = chichas[index];
                    return Container(
                      //elevation: 0,
                      child: InkWell(
                        onTap: () {
                          //
                          TextEditingController nb =
                              TextEditingController(text: "1");
                          //
                          //"Panier", "Votre boisson a été ajouté avec succes.");
                          Get.dialog(
                            AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(
                                  "Ajouter ${chicha['nom']} à la table ${commandeController.commandes[ind]['table']}"),
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
                                                chicha["quantite"] = nb.text;
                                                //
                                                commandeController
                                                    .commandeChichas = box.read(
                                                        "commandeChichas$ind") ??
                                                    [];
                                                //
                                                //
                                                commandeController
                                                    .commandeChichas
                                                    .add(chicha);
                                                //
                                                box.write(
                                                    "commandeChichas$ind",
                                                    commandeController
                                                        .commandeChichas);
                                                //
                                                //appController.boissons
                                                //  .add(boisson);
                                                //
                                                Get.back();
                                                //
                                                st.setState(() {});
                                                //
                                                Get.snackbar("Panier",
                                                    "Votre chicha a été ajouté avec succes.");
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
                          //width: Get.size.width / 4,
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
                                              "${Requete.urlSt}chicha/photo/${chicha['id']}"),
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
                                      text: "${chicha['nom']}\n",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${chicha['prix']} ${chicha['devise']}",
                                          style: const TextStyle(
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
          ),
        ],
      ),
    );
  }
}
