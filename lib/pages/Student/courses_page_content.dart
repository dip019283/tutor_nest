import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/courseModel.dart';
import '../../widgets/course_card.dart';
import 'course_details_page.dart';

class CoursesPageContent extends StatefulWidget {
  @override
  _CoursesPageContentState createState() => _CoursesPageContentState();
}

class _CoursesPageContentState extends State<CoursesPageContent> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  Stream<List<Course>> searchCourses(String query) {
    return _db
        .collection('courses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Course.fromMap(doc.data() as Map<String, dynamic>))
          .where((course) =>
      query.isEmpty ||
          course.courseName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          // Search Bar with Controller
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search courses...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add clear button when there's text
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                        : null,
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
          // Courses List with StreamBuilder
          Expanded(
            child: StreamBuilder<List<Course>>(
              stream: searchCourses(_searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final course = snapshot.data![index];
                      return CourseCard(
                        course: course,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CourseDetailsPage(courseId: course.courseId),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? "No courses available."
                          : "No courses found matching '$_searchQuery'",
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}