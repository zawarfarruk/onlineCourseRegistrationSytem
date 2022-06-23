// ignore_for_file: avoid_function_literals_in_foreach_calls

import '../model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Course> _items = [];
  var showFavouriteOnly=false;
  List<Course> get items {
    // if(showFavouriteOnly)
    // {
    //   return _items.where((prodid) => prodid.isSelected!).toList();
    // }
    return [..._items];
  }

  final String _token;

  Products(this._token, this._items);
  // List<Course> get favouriteItem {
  //   return _items.where((prodid) => prodid.isSelected!).toList();
  // }

  // ignore: non_constant_identifier_names

  fetchAndSetData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("courses").get();
    try {
      final List<Course> loadedData = [];
      snapshot.docs.forEach((document) {
        Course course = Course.fromMap(document.data() as Map<String, dynamic>);
        loadedData.add(course);
      });
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
