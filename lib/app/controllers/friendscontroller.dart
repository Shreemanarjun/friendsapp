import 'package:flutter/material.dart';
import 'package:friendsapp/app/controllers/logincontroller.dart';
import 'package:friendsapp/app/data/model/friendmodel.dart';
import 'package:friendsapp/app/services/dbservice.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class FriendsController extends GetxController with StateMixin<List<Friend>> {
  final DBService dbService = Get.find();
  final LoginController loginController = Get.find();
  final currentquery = "".obs;
  @override
  void onInit() async {
    debounce(currentquery, (_) async {
      if (currentquery.value.isEmpty) {
        print("query changes");
        await getAllFriends();
      } else {
        await getFriendsByName(currentquery.value);
      }
    }, time: const Duration(milliseconds: 200));
    await getAllFriends();
    super.onInit();
  }

  Future<void> getFriendsByName(String name) async {
    change(null, status: RxStatus.loading());
    var currentid = loginController.currentuserid.value;
    if (currentid != 0) {
      var friends = await dbService.getSearchByName(fid: currentid, name: name);
      if (friends.isEmpty) {
        change(null, status: RxStatus.error("No friend have name '$name'"));
      } else {
        change(friends, status: RxStatus.success());
      }
    }
  }

  Future<void> getAllFriends() async {
    var currentid = loginController.currentuserid.value;
    if (currentid != 0) {
      var friends = await dbService.getCurrentUserAllFriend(fid: currentid);
      change(friends, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> addaFriend(
      {required String fname,
      required String lname,
      required String mobile,
      required String email}) async {
    try {
      var id = await dbService.insertFriend(
          friend: Friend(
              fname: fname,
              lname: lname,
              mobile: int.parse(mobile),
              email: email,
              fid: loginController.currentuserid.value));
      if (id != 0) {
        var snackBar = const SnackBar(
          content: Text('Friend added successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        await getAllFriends();
      
        Get.back();
      } else {
        var snackBar = const SnackBar(
          content: Text('Error in adding friend'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    } catch (e) {
      if (e is DatabaseException) {
        if (e.isUniqueConstraintError()) {
          var snackBar = const SnackBar(
            content: Text(
                'Error in adding friend due to Mobile Number or Email already being used'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        }
      }
    }
  }

  Future<void> updateFriend(Friend friend) async {
    try {
      var isUpdated = await dbService.updateFriend(friend: friend);
      if (isUpdated) {
        var snackBar = const SnackBar(
          content: Text('Friend Updated successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        await getAllFriends();
        Get.back();
      } else {
        var snackBar = const SnackBar(
          content: Text('Error in updating friend'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    } catch (e) {
      if (e is DatabaseException) {
        if (e.isUniqueConstraintError()) {
          var snackBar = const SnackBar(
            content: Text(
                'Error in adding friend due to Mobile Number or Email already being used'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        }
      } else {
        var snackBar = SnackBar(
          content: Text('Error in updating friend due to ${e.toString()}'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    }
  }

  Future<void> deleteaFriend(Friend friend) async {
    try {
      var isDeleted = await dbService.deleteFriend(friend: friend);
      if (isDeleted) {
        var snackBar = const SnackBar(
          content: Text('Deleted successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        await getAllFriends();
      } else {
        var snackBar = const SnackBar(
          content: Text('Deletion failed'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      }
    } catch (e) {
      var snackBar = SnackBar(
        content: Text('Deletion failed due to ${e.toString()}'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }
  }
}
