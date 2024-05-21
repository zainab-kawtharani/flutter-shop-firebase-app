// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shop_app/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPassswordController =
      TextEditingController();
  bool obsecureTextPassword = true;
  bool obsecureTextConPassword = true;

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
                email: _emailController.text,
                password: _passwordController.text);
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image(
                      height: 160,
                      image: AssetImage('assets/images/shop-96.png')),
                  Text(
                    'HELLO THERE!',
                    style: TextStyle(
                        fontFamily: 'Hind',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rigester now by add your details",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Iconsax.direct_right),
                            labelText: "Username"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Iconsax.direct_right),
                            labelText: "Email"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: obsecureTextPassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Iconsax.password_check),
                            suffixIcon: GestureDetector(
                              child: Icon(obsecureTextPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                              onTap: () {
                                setState(() {
                                  obsecureTextPassword = !obsecureTextPassword;
                                });
                              },
                            ),
                            labelText: "Password"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _confirmPassswordController,
                        obscureText: obsecureTextConPassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Iconsax.password_check),
                            suffixIcon: GestureDetector(
                              child: Icon(obsecureTextConPassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                              onTap: () {
                                setState(() {
                                  obsecureTextConPassword =
                                      !obsecureTextConPassword;
                                });
                              },
                            ),
                            labelText: "Confirm Password"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: registerUser,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange,
                          ),
                          child: Center(
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'login',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 152, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
