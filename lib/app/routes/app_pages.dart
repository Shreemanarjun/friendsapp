import 'package:friendsapp/app/controllers/friendscontroller.dart';
import 'package:friendsapp/app/ui/android/friendlist/friendlist_page.dart';
import 'package:friendsapp/app/ui/android/friendlist/pages/addfriend_page.dart';
import 'package:friendsapp/app/ui/android/friendlist/pages/updatefriend_page.dart';
import 'package:friendsapp/app/ui/android/login/login_page.dart';
import 'package:friendsapp/app/ui/android/signup/signup_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => SignupPage(),
    ),
    GetPage(
        name: Routes.friends,
        page: () => const FriendListPage(),
        binding: BindingsBuilder.put(() => FriendsController())),
    GetPage(
        name: Routes.addfriend,
        page: () => AddFriendPage(),
        binding: BindingsBuilder.put(() => FriendsController())),
    GetPage(
        name: Routes.updatefriend,
        page: () => UpdateFriendPage(),
        binding: BindingsBuilder.put(() => FriendsController()))
    //dependencias de details via rota
  ];
}
