import 'package:flutter/material.dart';
import 'package:friendsapp/app/data/model/usermodel.dart';
import 'package:friendsapp/app/routes/app_pages.dart';
import 'package:friendsapp/app/services/dbservice.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class LoginController extends GetxController {
  final DBService dbService = Get.find();
  final currentuserid = 0.obs;

  Future<void> loginUser(
      {required int mobile, required String password}) async {
    var user =
        await dbService.isExistingUser(mobile: mobile, password: password);
    if (user != null) {
      currentuserid.value = user.id!;
      const snackBar = SnackBar(
        content: Text('User loggedin successfully'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      Get.offAllNamed(Routes.friends);
    } else {
      const snackBar = SnackBar(
        content: Text('User login failed'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }

  Future<void> registerUser(
      {required String fname,
      required String lastname,
      required int mobile,
      required String email,
      required String password}) async {
    User user = User(
        fname: fname,
        lname: lastname,
        mobile: mobile,
        email: email,
        password: password);
    try {
      var count = await dbService.insertUser(user: user);
      if (count != 0) {
        const snackBar = SnackBar(
          content: Text('User signedup successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        Get.toNamed(Routes.initial);
      }
    } catch (e) {
     // print(e);
      if (e is DatabaseException) {
        if (e.isUniqueConstraintError()) {
          const snackBar = SnackBar(
            content: Text('User already signedup.Please login'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        }
      }
    }
  }
}
