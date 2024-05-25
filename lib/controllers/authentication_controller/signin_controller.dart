import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shop_app/repository/authentication_repository/authentication_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future <void> signInUser() async {
    await AuthenticationRepository.instance
        .loginUserFirebase(email.text.trim(), password.text.trim());
  }

  void signInWithGoogle() async {
    final userCredential = AuthenticationRepository.instance.signInWithGoole();
  }
}
