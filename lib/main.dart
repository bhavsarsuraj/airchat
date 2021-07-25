import 'package:airchat/app_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(
    GetMaterialApp(
      title: "Airchat",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      onInit: () {
        Get.put(AppController());
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

Future initFirebase() async {
  await Firebase.initializeApp();
}
