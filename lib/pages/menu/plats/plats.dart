import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';
import 'package:village_batuse/utils/requete.dart';

import 'details_plat.dart';
import 'plats_controller.dart';

class Plat extends GetView<PlatController> {
  RxBool plat = true.obs, legume = false.obs;
  //
  CommandeController commandeController = Get.find();
  //
  int ind;
  //
  AppController appController = Get.find();
  //
  State st;
  //
  Plat(this.ind, this.st) {
    controller.allIfPlats(categorie);
  }
  //
  String categorie = "Plat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plats et Légumes"),
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
                    categorie = "Plat";
                    controller.allIfPlats(categorie);
                    //
                  } else {
                    plat.value = false;
                    legume.value = true;
                    categorie = "Légume";
                    controller.allIfPlats(categorie);
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
                  Text("   Plats   "),
                  Text("  Légumes  "),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: controller.obx(
              (state) {
                List plats = state!;
                return GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 4,
                  mainAxisSpacing: 0.9,
                  crossAxisSpacing: 3,
                  childAspectRatio: 0.7,
                  children: List.generate(plats.length, (index) {
                    Map plat = plats[index];
                    return Container(
                      //elevation: 0,
                      child: InkWell(
                        onTap: () {
                          //
                          //Get.snackbar(
                          //"Panier", "Votre boisson a été ajouté avec succes.");
                          Get.to(DetailsPlat(plat, ind, st));
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
                                              "${Requete.urlSt}plat/photo/${plat['id']}"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
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
                                        text:
                                            "${plat['prix']} ${plat['devise']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
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
