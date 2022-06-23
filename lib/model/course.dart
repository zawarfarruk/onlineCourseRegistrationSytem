import 'package:flutter/cupertino.dart';

class Course with ChangeNotifier {
  String? id;
  String? name;
  String? userId;
  String? descripton;
  String? price;
  String? image;
  String? creditHour;
  String? email;
  // bool? isSelected = false;
  // Course(
  //     {required this.id,
  //     required this.name,
  //     required this.image,
  //     required this.price,
  //     required this.descripton,
  //     required this.creditHour,
  //     required this.email,
  //     required this.userId});
  Course.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    image = data["image"];
    price = data["price"];
    descripton = data["description"];
    creditHour = data["creditHour"];
    email=data["email"];
    userId=data["userId"];
  }
  // void toogleFavourite() {
  //   isSelected != isSelected;
  //   notifyListeners();
  // }

}
