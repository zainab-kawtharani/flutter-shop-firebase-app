import 'dart:convert';

import 'package:get/get.dart';
import 'package:shop_app/models/shoe.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  static ApiController get instance => Get.find();

  RxList<Shoe> itemList = <Shoe>[].obs;
  RxList<Shoe> itemShoes = <Shoe>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllShoes();
  }

  Future<void> getAllShoes() async {
    var response = await http.get(
        Uri.parse("https://663e66d7e1913c4767978ac4.mockapi.io/api/v1/Items"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
   
      for (Map<String, dynamic> index in data) {
        itemList.add(Shoe.fromJson(index));
      }
    } else {
      print(response.statusCode);
    }
  }
}
