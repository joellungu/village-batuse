import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:village_batuse/pages/bar/bar_controller.dart';
import 'package:village_batuse/pages/bar/chicha_controller.dart';
import 'package:village_batuse/pages/login/login.dart';
import 'package:village_batuse/pages/menu/boissons/boisson_controller.dart';
import 'package:village_batuse/pages/menu/plats/plats_controller.dart';
import 'package:village_batuse/utils/app_controller.dart';

import 'pages/accueil.dart';
import 'pages/caisse/caisse_controller.dart';
import 'pages/commandes/commande_controller.dart';
import 'pages/cuisine/cuisine_controller.dart';
import 'pages/rapports/rapports_controller.dart';

void main() async {
  //
  await GetStorage.init();
  //
  AppController appController = Get.put(AppController());
  //
  BarController barController = Get.put(BarController());
  //
  ChichaController chichaController = Get.put(ChichaController());
  //
  CuisineController cuisineController = Get.put(CuisineController());
  //
  CaisseController caisseController = Get.put(CaisseController());
  //
  CommandeController commandeController = Get.put(CommandeController());
  //
  BoissonController boissonController = Get.put(BoissonController());
  //
  PlatController platController = Get.put(PlatController());
  //
  RapportController rapportController = Get.put(RapportController());
  //
  //ChichaController chichaController = Get.put(ChichaController());
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Village Batuse',
      // The Mandy red, light theme.
      theme: FlexThemeData.light(scheme: FlexScheme.redM3),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.redM3),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      //
      home:
          //Accueil()
          Login(),
    );
  }
}
