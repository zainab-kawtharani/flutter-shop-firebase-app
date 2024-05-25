import 'package:get/get.dart';
import 'package:shop_app/repository/authentication_repository/authentication_repository.dart';

class SignoutController extends GetxController {
  static SignoutController get instance => Get.find();

  Future <void> logoutUser() async {
    await AuthenticationRepository.instance.logout();
  }
}
