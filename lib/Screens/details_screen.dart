// import 'package:education_system/provider/enrolled_courses.dart';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_system/provider/product_provider.dart';
import 'package:education_system/provider/user_selected.dart';
// import 'package:education_system/model/course.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static const routeName = "/detail-Screen";

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

final  uid = FirebaseAuth.instance.currentUser;

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // final course = Provider.of<Course>(context, listen: false);
    final prodId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedproduct = Provider.of<Products>(context)
        .items
        .firstWhere((prod) => prod.id == prodId);
    final userprovider=Provider.of<UserNotifier>(context);
    // final currentCourse = Provider.of<CourseNotifier>(context, listen: false);
    // final enroll=Provider.of<EnrolledCourse>(context,listen:false);
    return Scaffold(
      appBar: AppBar(title:const Text("Details")),
      body: ChangeNotifierProvider(
        create: ((context) => loadedproduct),
        child: Card(
          margin:const EdgeInsets.symmetric(horizontal: 18,vertical: 5),

          elevation: 10,
          child: Padding(
            padding:const EdgeInsets.all(8),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  loadedproduct.image!,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  loadedproduct.name!,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 30),
                Text(
                  loadedproduct.descripton!,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Text(
                  "CreditHour:     ${loadedproduct.creditHour!}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Text(
                  "Price:     ${loadedproduct.price!}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      userprovider.addUserSelected(loadedproduct.id!,loadedproduct.image!,loadedproduct.name!,loadedproduct.descripton!,loadedproduct.price!,(loadedproduct.userId==uid!.email));
                      print(loadedproduct.id);
                      FirebaseFirestore.instance.collection("selected").doc().set(
                        {
                          "image": loadedproduct.image,
                          "name": loadedproduct.name,
                          "description": loadedproduct.descripton,
                          "price": loadedproduct.price,
                          "creditHour": loadedproduct.creditHour,
                          "email": uid!.email,
                          "createdAt":Timestamp.now()
                
                          // "userId":uid,
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Course Added in RegisterList",
                            style: TextStyle(fontSize: 20),
                          ),
                          backgroundColor: Colors.pink,
                        ),
                      );
                    },
                    child: const Text("Register"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
