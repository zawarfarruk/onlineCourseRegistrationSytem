
import 'package:education_system/provider/user_selected.dart';
import 'package:education_system/widget/user_course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);
  static const routeName = "/User-register";

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  @override
  Widget build(BuildContext context) {
    final userSelected = Provider.of<UserNotifier>(context);
    final currentUser=FirebaseAuth.instance.currentUser;
    // print("userSelected");
    return Scaffold(
      
        // body: Text(userSelected.),
        body: ListView.builder(
      itemBuilder: ((context, index) => UserCourse(
          userSelected.list.values.toList()[index].id,
          
          userSelected.list.values.toList()[index].image,
          userSelected.list.keys.toList()[index],
          userSelected.list.values.toList()[index].details,
          userSelected.list.values.toList()[index].price)),
      itemCount: userSelected.list.length,
    ));
  }
}
