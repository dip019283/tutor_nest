import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/course.dart';
import '../../widgets/video_popup.dart';

class CourseDetailsPageContent extends StatefulWidget {
  final String courseId;

  const CourseDetailsPageContent({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseDetailsPageContentState createState() => _CourseDetailsPageContentState();
}

class _CourseDetailsPageContentState extends State<CourseDetailsPageContent> {
  late Future<Course> _courseFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future to fetch course details
    _courseFuture = fetchCourseDetails(widget.courseId);
  }

  Future<Course> fetchCourseDetails(String courseId) async {
    try {
      // Fetch course data directly from Firestore
      final snapshot = await FirebaseFirestore.instance.collection('courses').doc(courseId).get();
      if (snapshot.exists) {
        return Course.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("Course not found");
      }
    } catch (e) {
      throw Exception("Failed to load course details: $e");
    }
  }

  void _showVideoPopup(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return VideoPopup(videoUrl: videoUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Course>(
      future: _courseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Failed to load course details."),
          );
        } else if (snapshot.hasData) {
          Course course = snapshot.data!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card with Course Details
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Course Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        child: Image.network(
                          course.image,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Course Name and Discover Button
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Course Name
                            Expanded(
                              child: Text(
                                course.courseName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Discover Button
                            ElevatedButton(
                              onPressed: () {
                                _showVideoPopup(context, course.videoUrl);
                              },
                              child: Text("Discover"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Overview Section
                Text(
                  "Overview:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Divider(thickness: 1),
                SizedBox(height: 8),
                // Intro Section
                Text(
                  "Intro:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(course.intro),
                SizedBox(height: 16),
                // Why Take This Course Section
                Text(
                  "Why take this course:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(course.whyTakeThisCourse),
                SizedBox(height: 16),
                // What You Will Learn Section
                Text(
                  "What you will learn in this course:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                // List of What You Will Learn
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: course.whatYouWillLearn.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(child: Text(item)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                // Course Description Section
                Text(
                  "Course Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(course.description),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Course not found."),
          );
        }
      },
    );
  }
}
