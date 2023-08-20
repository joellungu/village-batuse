import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:village_batuse/pages/menu/boissons/boissons.dart';
import 'package:village_batuse/utils/requete.dart';

class CommandeBoissons extends StatefulWidget {
  int ind;
  CommandeBoissons(this.ind, {super.key});
  @override
  State<StatefulWidget> createState() {
    //
    return _CommandeBoissons();
  }
}

class _CommandeBoissons extends State<CommandeBoissons> {
  //
  CommandeController commandeController = Get.find();
  //
  var box = GetStorage();
  //
  RxDouble totalBs = 0.0.obs;
  //
  @override
  void initState() {
    super.initState();
    //

    commandeController.commandeBoissons =
        box.read("commandeBoissons${widget.ind}") ?? [].obs;
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    print("cool");
    //
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("BOISSONS"),
        centerTitle: true,
      ),
      body: ListView(
        children:
            List.generate(commandeController.commandeBoissons.length, (index) {
          //Map boisson = l[index];
          Map bs = commandeController.commandeBoissons[index];
          //
          RxDouble total = 0.0.obs;
          //
          totalBs.value += (bs['prix'] * int.parse(bs['quantite']));
          total.value += (bs['prix'] * int.parse(bs['quantite']));

          //
          return Card(
            elevation: 0,
            child: Container(
              alignment: Alignment.center,
              //height: 170,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${bs['nom']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Quantité (${bs['quantite']})",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          // child: Text(
                          //   "${pl['accompagnement'].reduce((value, element) => value["nom"] + ',' + element["nom"])}",
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.normal,
                          //     color: Colors.black,
                          //     fontSize: 13,
                          //   ),
                          // ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${bs['prix']} ${bs['devise']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.black,
                            height: 40,
                            width: 250,
                            alignment: Alignment.center,
                            child: Text(
                              "${total.value} ${bs['devise']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            commandeController.commandeBoissons.removeAt(index);
                            //
                            box.write("commandeBoissons${widget.ind}",
                                commandeController.commandeBoissons);
                          });
                          //appController.boissons
                          //  .removeAt(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      Text(""),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          Get.to(Boisson(widget.ind, this));
        },
        heroTag: "boissons",
        backgroundColor: Colors.black,
        child: Icon(Icons.wine_bar),
      ),
    );
  }
}
