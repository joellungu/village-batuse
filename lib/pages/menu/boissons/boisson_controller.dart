import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:village_batuse/utils/requete.dart';

class BoissonController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  //
  allIfBoissons(String categorie) async {
    change([], status: RxStatus.loading());
    d.Response response = await requete.getE("boisson/all/$categorie");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List boissons = response.data;
      print("les boissons: $boissons");
      change(boissons, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }
}
