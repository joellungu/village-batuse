import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:village_batuse/utils/requete.dart';

class RapportController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  //
  RxDouble totalFranc = 0.0.obs;
  RxDouble totalDollar = 0.0.obs;
  //
  load() async {
    change([], status: RxStatus.empty());
  }

  //
  allRapportPlatsLegumes(
      String date, String categorie, String type, String section) async {
    change([], status: RxStatus.loading());
    d.Response response = await requete
        .getE("historique/commande/$categorie/$date/$section/$type");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List boissons = response.data;
      print("les boissons: $boissons");
      change(boissons, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }

  //
  allRapport(String date, String section) async {
    totalFranc.value = 0;
    totalDollar.value = 0;
    change([], status: RxStatus.loading());
    d.Response response =
        await requete.getE("historique/commande/$date/$section");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List boissons = response.data;
      print("les boissons: $boissons");
      boissons.forEach((rapport) {
        //
        if (rapport['devise'] == "USD") {
          totalDollar.value += rapport['prix-unitaire'] * rapport['nombre'];
        } else {
          totalFranc.value += rapport['prix-unitaire'] * rapport['nombre'];
        }
      });
      change(boissons, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }
}
