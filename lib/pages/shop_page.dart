// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/components/shoe_tile.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/controllers/apis_controller/get_all_controller.dart';
import 'package:shop_app/models/shoe.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Shoe> shoes = [];

  @override
  void initState() {
    super.initState();
    //getShoes();
  }

  Future<void> getShoes() async {
    var response = await http.get(
        Uri.parse("https://663e66d7e1913c4767978ac4.mockapi.io/api/v1/Items"));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        shoes = jsonData.map((data) => Shoe.fromJson(data)).toList();
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApiController());
    List<Shoe> shoesList = controller.itemList;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "everyone flies... some fly longer than others..",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Hot picks🔥",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "see all",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Expanded(
            child:  Obx( ()=> ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shoesList.length,
                itemBuilder: (context, index) {
                  return ShoeTile(shoe: shoesList[index]);
                }))
        )],
    ));
  }
}
