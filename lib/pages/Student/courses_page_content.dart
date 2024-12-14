import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/courseModel.dart';
import '../../services/courses_service.dart'; // Import the service
import '../../widgets/course_card.dart';      // Import the CourseCard widget
import 'course_details_page.dart';        // Import the CourseDetailsPage

class CoursesPageContent extends StatefulWidget {
  @override
  _CoursesPageContentState createState() => _CoursesPageContentState();
}

class _CoursesPageContentState extends State<CoursesPageContent> {
  final CoursesService _coursesService = CoursesService();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Course>> fetchCourses() async {
    try {
      final snapshot = await _db.collection('courses').get();
      return snapshot.docs.map((doc) {
        return Course.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception("Failed to load courses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Removed the Scaffold, AppBar, Drawer, and BottomNavigationBar as they are handled in MainPage
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with Icon
          Row(
            children: [
              Icon(Icons.school, size: 50, color: Colors.purple),
              const SizedBox(width: 16),
              const Text(
                "Discover Courses",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search Bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          const Text(
            "Discover courses in various fields. Choose from a variety of topics and start learning today.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            "Courses",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Courses List
          Expanded(
            child: FutureBuilder<List<Course>>(
              // Call the fetchCourses() method here
              future: fetchCourses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Failed to load courses."));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final course = snapshot.data![index];
                      return CourseCard(
                        course: course,
                        onTap: () {
                          // Navigate to CourseDetailsPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailsPage(courseId: course.courseId),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No courses available."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
