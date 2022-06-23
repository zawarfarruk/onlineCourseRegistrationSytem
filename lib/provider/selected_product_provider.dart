import '../model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Selected with ChangeNotifier {
  List<Course> _items = [];
  // var showFavouriteOnly = false;
  List<Course> get items {
  
    return [..._items];
  }

  final String _token;

  Selected(this._token, this._items);

  fetchAndSetData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("selected").orderBy("createdAt",descending: true)
        .get();
    try {
      final List<Course> loadedData = [];
      for (var document in snapshot.docs) {
        Course course = Course.fromMap(document.data() as Map<String, dynamic>);
        loadedData.add(course);
      }
      _items = loadedData;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
