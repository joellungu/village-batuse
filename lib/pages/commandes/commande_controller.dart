import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:village_batuse/utils/requete.dart';

class CommandeController extends GetxController {
  //
  Requete requete = Requete();
  //
  List commandePlats = [];
  //
  List commandeBoissons = [];
  //
  List commandeChichas = [];
  //
  List commandes = [];
  //
  RxInt i = 0.obs;
  //
  Future<bool> saveCommande(Map a) async {
    print(a);
    d.Response response = await requete.postE("commande", a);

    if (response.statusCode == 200 || response.statusCode == 201) {
      //

      //allAgents();
      //List agents = json.decode(response.data);
      //change(agents, status: RxStatus.success());
      return true;
    } else {
      return false;
      //change([], status: RxStatus.empty());
    }
  }
}
