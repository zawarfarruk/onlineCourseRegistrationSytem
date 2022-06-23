import 'package:education_system/Screens/details_screen.dart';
import 'package:education_system/Screens/user_register.dart';
import 'package:education_system/provider/product_provider.dart';
import 'package:education_system/provider/user_selected.dart';
import 'package:provider/provider.dart';
import 'provider/selected_product_provider.dart';

import 'widget/navigate.dart';
import '../Screens/setting_screen.dart';
// import '../Screens/feed_back.dart';
import '../Screens/selected_course.dart';
import 'Screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Selected("",[]),
        ),
        ChangeNotifierProvider.value(
          value: Products("", [])),
          ChangeNotifierProvider.value(
            value: UserNotifier(),
          )
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, usersnapshot) {
            if (usersnapshot.hasData) {
              return const MyStatefulWidget();
            }
            return const AuthScreen();
          },
        ),
        routes: {
          SelectedCourse.routeName: (context) => const SelectedCourse(),
          UserRegister.routeName:(context) => const UserRegister(),
          // FeedBack.routeName: (context) => const FeedBack(),
          ChangePassword.routeName: (context) => const ChangePassword(),
          DetailsScreen.routeName: (context) => const DetailsScreen(),
        },
      ),
    ),
  );
}
