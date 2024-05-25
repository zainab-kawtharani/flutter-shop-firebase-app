import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_app/auth/login_or_register.dart';
import 'package:shop_app/pages/home_page.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var isLoading = false.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialState);
  }

  setInitialState(User? user) {
    user == null
        ? Get.offAll(() => const LoginOrRegister())
        : Get.offAll(() => const HomePage());
  }

  Future<void> createUserFirebase(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      print(e.code);
    }
  }

  Future<void> loginUserFirebase(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  Future<void> logout() async => auth.signOut();
/*
  Future<UserCredential?> signInWithGoole() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }*/
}
