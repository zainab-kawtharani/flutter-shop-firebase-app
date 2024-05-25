// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/authentication_controller/signout_controller.dart';
import 'package:shop_app/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignoutController());
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ShopPage(),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: [
            DrawerHeader(
                child: Image.asset(
              'assets/images/shop-96.png',
              width: 80,
            )),
            Padding(padding: EdgeInsets.only(top: 25)),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  Get.back();
                },
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.orange,
                  ),
                  title: Text(
                    'Home',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: GestureDetector(
                onTap: () => controller.logoutUser(),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.orange,
                  ),
                  title: Text('logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
