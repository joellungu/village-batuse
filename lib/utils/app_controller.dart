import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/accueil.dart';
import 'package:village_batuse/pages/bar/bar_accueil.dart';
import 'package:village_batuse/pages/caisse/caisse.dart';
import 'package:village_batuse/pages/cuisine/cuisine.dart';
import 'package:village_batuse/utils/requete.dart';
import 'package:dio/dio.dart' as d;

class AppController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  //
  final box = GetStorage();

  loginAgent(String telephone, String mdp) async {
    //change([], status: RxStatus.loading());
    d.Response response =
        await requete.getE("utilisateur/login/$telephone/$mdp");

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      //
      Map agent = response.data;
      print(agent);
      //
      if (agent['compte'] == "vide") {
        Get.snackbar(
          "Erreur",
          "Le compte n'est pas trouvé",
          backgroundColor: Colors.red.shade900,
          colorText: Colors.white,
        );
      } else {
        //
        box.write("user", agent);
        //
        Get.offAll(Accueil());
        //
        // if (agent['type'] == "BAR") {
        //   Get.offAll(BarAccueil());
        // } else if (agent['type'] == "CUISINIER") {
        //   Get.offAll(Cuisine());
        // } else {
        //   Get.offAll(Caisse());
        // }
      }

      //change(agents, status: RxStatus.success());
    } else {
      Get.back();
      //
      Get.snackbar(
        "Erreur",
        "Un problème est survenu lors de l'authentification",
        backgroundColor: Colors.red.shade900,
        colorText: Colors.white,
      );
      //change([], status: RxStatus.empty());
    }
  }

  //
  Future<bool> updateCommande(Map a) async {
    print(a);
    d.Response response = await requete.putE("commande", a);

    if (response.statusCode == 200 || response.statusCode == 201) {
      //

      //allAgents();
      //List agents = json.decode(response.data);
      //change(agents, status: RxStatus.success());
      return response.data;
    } else {
      return false;
      //change([], status: RxStatus.empty());
    }
  }
  // allIfAgents(String categorie) async {
  //   change([], status: RxStatus.loading());
  //   d.Response response = await requete.getE("utilisateur/all/$categorie");
}
