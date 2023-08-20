import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/commandes/commande_controller.dart';
import 'package:village_batuse/pages/menu/chicha/chicha.dart';

class CommandeChichas extends StatefulWidget {
  int ind;

  CommandeChichas(this.ind, {super.key});
  @override
  State<StatefulWidget> createState() {
    //
    return _CommandeChichas();
  }
}

class _CommandeChichas extends State<CommandeChichas> {
  //
  CommandeController commandeController = Get.find();
  //int ind;
  var box = GetStorage();
  //
  RxDouble totalCh = 0.0.obs;
  //
  @override
  void initState() {
    super.initState();
    //

    commandeController.commandeChichas =
        box.read("commandeChichas${widget.ind}") ?? [].obs;
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("CHICHAS"),
        centerTitle: true,
      ),
      body: ListView(
        children:
            List.generate(commandeController.commandeChichas.length, (index) {
          //Map boisson = l[index];
          Map bs = commandeController.commandeChichas[index];
          //
          RxDouble total = 0.0.obs;
          //
          totalCh.value += (bs['prix'] * int.parse(bs['quantite']));
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
                              color: Colors.grey.shade700,
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
                            commandeController.commandeChichas.removeAt(index);
                            //
                            box.write("commandeChichas${widget.ind}",
                                commandeController.commandeChichas);
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
          Get.to(Chicha(widget.ind, this));
        },
        heroTag: "chichas",
        backgroundColor: Colors.black,
        child: Icon(Icons.smoking_rooms_rounded),
      ),
    );
  }
}
