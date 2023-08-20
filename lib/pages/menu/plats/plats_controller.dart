import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:village_batuse/utils/requete.dart';

class PlatController extends GetxController with StateMixin<List> {
  Requete requete = Requete();
  //
  allIfPlats(String categorie) async {
    change([], status: RxStatus.loading());
    d.Response response = await requete.getE("plat/all/$categorie");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List boissons = response.data;
      print("les boissons: $boissons");
      change(boissons, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }

  //
  Future<List> allIfAccs() async {
    //change([], status: RxStatus.loading());
    d.Response response = await requete.getE("accompagnement/all");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List boissons = response.data;
      print("les boissons: $boissons");
      return boissons;
      //change(boissons, status: RxStatus.success());
    } else {
      return [];
      //change([], status: RxStatus.empty());
    }
  }
}
