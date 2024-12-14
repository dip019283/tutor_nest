// import 'dart:async';
// import '../models/course.dart';
//
// class CourseDetailsService {
//   Future<Course> fetchCourseDetails(String courseId) async {
//     // Simulate network delay
//     await Future.delayed(Duration(seconds: 1));
//
//     // Dummy course data
//     Map<String, dynamic> courseData = {
//       "id": courseId,
//       "image": "https://via.placeholder.com/300",
//       "courseName": "C# Programming",
//       "intro": "This course equips you with the ability to code in OOP language and make you competent in programming Language in C#.",
//       "whyTakeThisCourse": "This course is made by doing state-of-the-art analysis and research to make the student a qualified programmer and help the student in real-world programming.",
//       "whatYouWillLearn": [
//         "OOP Principles",
//         "Variables",
//         "Methods",
//         "Connections",
//       ],
//       "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//       "description": "Learn C# programming from basics to advanced concepts.",
//     };
//
//     return Course.fromMap(courseData);
//   }
// }

// lib/services/course_details_service.dart
import 'dart:async';
import '../models/course.dart';

class CourseDetailsService {
  // Dummy data for testing
  Future<Course> fetchCourseDetails(String courseId) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Dummy course data based on courseId
    // In a real scenario, you'd fetch data from Firebase or an API
    Map<String, dynamic> courseData;

    if (courseId == "1") {
      courseData = {
        "id": "1",
        "image": "https://via.placeholder.com/300x150.png?text=Artificial+Intelligence",
        "courseName": "Artificial Intelligence",
        "intro": "Explore the world of AI, neural networks, and machine learning.",
        "whyTakeThisCourse": "Gain in-depth knowledge of AI technologies and their real-world applications.",
        "whatYouWillLearn": [
          "Neural Networks",
          "Machine Learning Algorithms",
          "AI Ethics",
          "Deep Learning",
        ],
        "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        "description": "Learn about artificial intelligence, its applications, and how to implement AI solutions.",
      };
    } else if (courseId == "2") {
      courseData = {
        "id": "2",
        "image": "https://via.placeholder.com/300x150.png?text=C%2B%2B+Programming",
        "courseName": "C++ Programming",
        "intro": "Master the fundamentals and advanced concepts of C++ programming.",
        "whyTakeThisCourse": "Build a strong foundation in C++ for software development, game development, and more.",
        "whatYouWillLearn": [
          "OOP Principles",
          "Memory Management",
          "Standard Template Library (STL)",
          "Multithreading",
        ],
        "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        "description": "This course covers C++ from basics to advanced topics, enabling you to develop efficient and high-performance applications.",
      };
    } else {
      // Default dummy data for unknown courseId
      courseData = {
        "id": courseId,
        "image": "https://via.placeholder.com/300x150.png?text=Course+Image",
        "courseName": "Unknown Course",
        "intro": "Introduction to the unknown course.",
        "whyTakeThisCourse": "Learn why to take this unknown course.",
        "whatYouWillLearn": [
          "Topic 1",
          "Topic 2",
        ],
        "videoUrl": "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        "description": "Detailed description of the unknown course.",
      };
    }

    return Course.fromMap(courseData);
  }
}
