import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/helper/helper_functions.dart';
import 'package:shop_app/repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  var isLoading = false.obs;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    if (password.text != confirmPassword.text) {
      print("passwords not match");
    } else {
      isLoading.value = true;
      await AuthenticationRepository.instance
          .createUserFirebase(email.text.trim(), password.text.trim());
      isLoading.value = false;
    }
  }
}

/** 
void registerUser() async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  if (_passwordController.text != _confirmPassswordController.text) {
    Navigator.pop(context);
    displayMessageToUser("Passwords dont Match", context);
  } else {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        displayMessageToUser("The email already used", context);
      } else {
        displayMessageToUser(e.code, context);
      }
    }
  }
}*/
