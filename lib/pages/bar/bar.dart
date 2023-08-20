import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:village_batuse/pages/bar/bar_controller.dart';
import 'package:village_batuse/pages/cuisine/details_cuisine.dart';

class Bar extends GetView<BarController> {
  Bar() {
    controller.commencer();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      controller.getCommandeBoissons();
      print("je vois s'il y a une commande bar");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          child: const Text(
            "Commande boissons",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: controller.obx(
              (state) {
                //
                List list = state!;
                return ListView(
                  children: List.generate(list.length, (index) {
                    Map commande = list[index];
                    print("resultat: $commande");
                    if (commande['boissons'].isEmpty) {
                      return Container();
                    } else {
                      return Card(
                        elevation: 2,
                        child: SizedBox(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  //color: Colors.yellow,
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "Table \n",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "n° ${commande['nTable']}",
                                          style: TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //
                                      Container(
                                        //color: Colors.yellow,
                                        alignment: Alignment.center,
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: "Section \n",
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${commande['lieuCommande']}",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          //
                                          Get.to(DetailsCommande(commande, 1));
                                          //
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Colors.black,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Details",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     //
                                      //   },
                                      //   style: ButtonStyle(
                                      //     backgroundColor:
                                      //         MaterialStateProperty.all(
                                      //       Colors.green.shade700,
                                      //     ),
                                      //     shape: MaterialStateProperty.all(
                                      //       RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(20),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   child: Container(
                                      //     width: 250,
                                      //     height: 50,
                                      //     alignment: Alignment.center,
                                      //     child: const Text(
                                      //       "Livré",
                                      //       style: TextStyle(
                                      //         fontSize: 25,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                );
              },
              onEmpty: Container(),
              onLoading: const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
