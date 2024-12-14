import 'package:flutter/material.dart';
import 'course_detail_page_content.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseId;

  const CourseDetailsPage({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with Back Button
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Course Details",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: CourseDetailsPageContent(courseId: courseId),
    );
  }
}