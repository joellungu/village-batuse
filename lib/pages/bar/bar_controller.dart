import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/utils/requete.dart';

class BarController extends GetxController with StateMixin<List> {
  //
  Requete requete = Requete();
  //
  var box = GetStorage();
  //
  commencer() async {
    change([], status: RxStatus.empty());
  }

  //
  getCommandeBoissons() async {
    var user = box.read("user");
    DateTime dd = DateTime.now();
    //
    String datecommande = "${dd.day}-${dd.month}-${dd.year}";
    //
    //change([], status: RxStatus.loading());

    d.Response response = await requete
        .getE("commande/commande/boissons/$datecommande/${user['section']}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("la rep: ${response.data}");
      //
      change(response.data, status: RxStatus.success());
      //change(agents, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }
//
}
