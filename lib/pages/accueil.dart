import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/bar/bar_accueil.dart';

import 'commandes/commande_controller.dart';
import 'commandes/commandes.dart';
import 'cuisine/cuisine.dart';

class Accueil extends StatelessWidget {
  //
  CommandeController commandeController = Get.find();
  //
  var box = GetStorage();
  //
  RxMap user = {}.obs;
  //
  Accueil() {
    user.value = box.read("user") ?? {};
    //
    commandeController.commandes = box.read("commandes") ?? [];
    //
  }
  //
  @override
  Widget build(BuildContext context) {
    return Commandes();
  }
}
