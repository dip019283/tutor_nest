// // lib/services/courses_service.dart
// import 'dart:async';
//
// class CoursesService {
//   // Dummy data for testing
//   Future<List<Map<String, String>>> fetchCourses() async {
//     await Future.delayed(Duration(seconds: 1)); // Simulate network delay
//     return [
//       {
//         "name": "Artificial Intelligence",
//         "description":
//         "This course dives into neural networks and machine learning techniques.",
//         "image":
//         "https://via.placeholder.com/300x150.png?text=Artificial+Intelligence" // Replace with actual image URL
//       },
//       {
//         "name": "C++ Programming",
//         "description":
//         "Learn the fundamentals of C++ programming with hands-on examples and projects.",
//         "image":
//         "https://via.placeholder.com/300x150.png?text=C%2B%2B+Programming" // Replace with actual image URL
//       },
//     ];
//
//   }
// }

// lib/services/courses_service.dart
import 'dart:async';
import '../models/courseModel.dart';

class CoursesService {
  // Dummy data for testing
  Future<List<Course>> fetchCourses() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    List<Map<String, dynamic>> data = [
      {
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
      },
      {
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
      },
      // Add more courses as needed
    ];

    // Convert Map data to Course objects
    return data.map((item) => Course.fromMap(item)).toList();
  }
}
