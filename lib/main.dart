import 'package:flutter/material.dart';
import 'package:friendsapp/app/bindings/initialbindings.dart';
import 'package:friendsapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Friends App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
      initialRoute: Routes.initial,
    );
  }
}
