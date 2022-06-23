import 'package:education_system/Screens/user_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../provider/user_selected.dart';
import 'package:education_system/Screens/home_page.dart';
import 'package:education_system/Screens/selected_course.dart';
import 'package:education_system/Screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Map<String, Object>> _pages = [
    {"page": const HomePage( ), "title": " Home Page"},
    {"page": const SelectedCourse(), "title": "Selected Course"},
    {"page": const UserRegister(), "title": "UserRegister"},
    {"page": const ChangePassword(), "title": "Settings Screen"},
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedIndex]["title"] as String),
          actions: [
            Row(children: [
              const Text("Logut"),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Provider.of<UserNotifier>(context,listen: false).clear();

                  FirebaseAuth.instance.signOut();
                },
              ),
            ]),
          ],
        ),
        body: _pages[_selectedIndex]["page"] as Widget,
        bottomNavigationBar: GNav(
          backgroundColor: Theme.of(context).primaryColor,
          onTabChange: _onItemTapped,

          activeColor: Theme.of(context).colorScheme.secondary,
          // unselectedItemColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          color: Colors.white,
          gap: 8,
          padding: const EdgeInsets.all(10),
          tabs: const [
            GButton(
              icon: (Icons.home),
              text: "home",
            ),
            GButton(
              icon: (Icons.people),
              text: "Register",
            ),
             GButton(
              icon: (Icons.feedback),
              text: "UserRegister",
            ),
            GButton(
              icon: (Icons.settings),
              text: "Settings",
            ),
           
          ],
        ),
      ),
    );
  }
}
