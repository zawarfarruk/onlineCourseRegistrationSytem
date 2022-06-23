import 'package:flutter/material.dart';

class UserSelected {
  String? id;
  String? name;
  // bool? udId;
  String? price;
  String? image;
  String? details;
  UserSelected(
      {required this.id,
      required this.name,
      // this.udId,
      required this.image,
      required this.details,
      required this.price});
}

class UserNotifier with ChangeNotifier {
 Map<String, UserSelected> _list = {};
  Map<String, UserSelected> get list {
    return {..._list};
  }

  void addUserSelected(String proid, String image, String name, String details,
      String price, bool uId) {
    if (_list.containsKey(proid)) {
      return;
    } else {
      _list.putIfAbsent(
          proid,
          () => UserSelected(
              id: DateTime.now().toString(),
              name: name,
              image: image,
              details: details,
              price: price));
    }
    notifyListeners();
  }

  void removeItem(String? prodid) {
    _list.remove(prodid!);
    notifyListeners();
  }
  void clear(){
    _list={};
    notifyListeners();
  }
}
