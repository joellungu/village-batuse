import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/menu/plats/plats.dart';

import 'commande_controller.dart';

class CommandePlats extends StatefulWidget {
  //
  int ind;
  CommandePlats(this.ind, {super.key});
  @override
  State<StatefulWidget> createState() {
    //
    return _CommandePlats();
  }
}

class _CommandePlats extends State<CommandePlats> {
  //
  CommandeController commandeController = Get.find();

  //
  var box = GetStorage();
  //
  RxDouble totalPL = 0.0.obs;
  //
  @override
  void initState() {
    super.initState();
    //

    commandeController.commandePlats =
        box.read("commandePlats${widget.ind}") ?? [].obs;
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PLATS ET LÉGUMES"),
        centerTitle: true,
      ),
      body: ListView(
        children:
            List.generate(commandeController.commandePlats.length, (index) {
          Map pl = commandeController.commandePlats[index];
          //
          RxDouble total = 0.0.obs;
          //
          totalPL.value += pl['prix'];
          total.value += pl['prix'];

          //
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
                  // Expanded(
                  //   flex: 3,
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     padding: const EdgeInsets.all(10),
                  //     child: Container(
                  //       height: 120,
                  //       width: 200,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         image: const DecorationImage(
                  //           image: ExactAssetImage(
                  //               "assets/bouffe 3.jpg"),
                  //           fit: BoxFit.cover,
                  //         ),
                  //         borderRadius:
                  //             BorderRadius.circular(100),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${pl['nom']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${pl['prix']} ${pl['devise']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Kwanga (2), Pilipili, Makemba (3), Fufu (2)
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              children: pl['accompagnement'] != null
                                  ? List.generate(
                                      jsonDecode(pl['accompagnement']).length,
                                      (udex) {
                                        Map acc = jsonDecode(
                                            pl['accompagnement'])[udex];
                                        print('le acc vaut: $acc');
                                        //
                                        //totalPL.value +=
                                        //  acc['prix'];
                                        // total.value += (acc['prix'] *
                                        //     int.parse(acc['quantite']));
                                        //////////
                                        totalPL.value += (acc['prix'] *
                                            int.parse(acc['quantite']));
                                        //
                                        return TextSpan(
                                          //${acc['prix']} ${acc['devise']}
                                          text: "${acc['nom']}\n",
                                          style: TextStyle(
                                            color: Colors.green.shade900,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                                text:
                                                    "${acc['prix']} ${acc['devise']} x (${acc['quantite']})\n"),
                                            WidgetSpan(
                                              child: Container(
                                                height: 2,
                                                width: 150,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(text: "\n")
                                          ],
                                        );
                                      },
                                    )
                                  : [],
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
                          child: Container(
                              color: Colors.black,
                              height: 40,
                              width: 250,
                              alignment: Alignment.center,
                              child: Obx(
                                () => Text(
                                  "${total.value} ${pl['devise']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              )),
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
                            commandeController.commandePlats.removeAt(index);
                            //
                            box.write("commandePlats${widget.ind}",
                                commandeController.commandePlats);
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
          Get.to(Plat(widget.ind, this));
        },
        heroTag: "plats",
        backgroundColor: Colors.black,
        child: Icon(Icons.restaurant),
      ),
    );
  }
}
