import 'package:friendsapp/app/controllers/logincontroller.dart';
import 'package:friendsapp/app/services/dbservice.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DBService());
    Get.put(LoginController());
  }
}
