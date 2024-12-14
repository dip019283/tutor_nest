// class Course {
//   final String id;
//   final String image;
//   final String courseName;
//   final String intro;
//   final String whyTakeThisCourse;
//   final List<String> whatYouWillLearn;
//   final String videoUrl;
//   final String description;
//
//   Course({
//     required this.id,
//     required this.image,
//     required this.courseName,
//     required this.intro,
//     required this.whyTakeThisCourse,
//     required this.whatYouWillLearn,
//     required this.videoUrl,
//     required this.description,
//   });
//
//   factory Course.fromMap(Map<String, dynamic> data) {
//     return Course(
//       id: data['id'] ?? '',
//       image: data['image'] ?? '',
//       courseName: data['courseName'] ?? '',
//       intro: data['intro'] ?? '',
//       whyTakeThisCourse: data['whyTakeThisCourse'] ?? '',
//       whatYouWillLearn: List<String>.from(data['whatYouWillLearn'] ?? []),
//       videoUrl: data['videoUrl'] ?? '',
//       description: data['description'] ?? '',
//     );
//   }
//
//   // String get name => null;
// }

// lib/models/course.dart

class Course {
  final String id;
  final String image;
  final String courseName;
  final String intro;
  final String whyTakeThisCourse;
  final List<String> whatYouWillLearn;
  final String videoUrl;
  final String description;

  Course({
    required this.id,
    required this.image,
    required this.courseName,
    required this.intro,
    required this.whyTakeThisCourse,
    required this.whatYouWillLearn,
    required this.videoUrl,
    required this.description,
  });

  factory Course.fromMap(Map<String, dynamic> data) {
    return Course(
      id: data['id'] ?? '',
      image: data['image'] ?? '',
      courseName: data['courseName'] ?? '',
      intro: data['intro'] ?? '',
      whyTakeThisCourse: data['whyTakeThisCourse'] ?? '',
      whatYouWillLearn: List<String>.from(data['whatYouWillLearn'] ?? []),
      videoUrl: data['videoUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
