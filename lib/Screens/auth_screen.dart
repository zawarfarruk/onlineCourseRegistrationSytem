import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/auth_form.dart';
import 'package:flutter/material.dart';
 import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String userName,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    final UserCredential response;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        response = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        response = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection("user")
            .doc(response.user!.uid)
            .set({
          "userName": userName,
          "email": email,
          // "password":password
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.pink,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.pink,
            content: Text(
              "email is already exist",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        );
      } else if (e.code == 'user-not-found') {
        // print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.pink,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        // print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.pink,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, ),
            ),
          ),
        );
      }
    }
   
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Online Education System"),
      ),
      body: AuthForm(_submitAuthForm, _isLoading),
      
    
    );
  }
}
