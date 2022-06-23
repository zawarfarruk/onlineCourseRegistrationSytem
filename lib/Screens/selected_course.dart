// import 'package:education_system/widget/bottom_navigation.dart';
import 'package:education_system/widget/show_allselected.dart';
import 'package:flutter/material.dart';
// import '../provider/enrolled_courses.dart';

class SelectedCourse extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SelectedCourse();

  static const routeName = "/selected-Course";

  @override
  State<SelectedCourse> createState() => _SelectedCourseState();
}

class _SelectedCourseState extends State<SelectedCourse> {
  @override
  Widget build(BuildContext context) {
    // final selected = Provider.of<EnrolledCourse>(context);
    return const Scaffold(
      body: ShowSelected(),
    );
  }
}
