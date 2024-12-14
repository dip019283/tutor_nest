// // lib/models/lesson.dart
//
// /// Data model for scheduled lessons
// class Lesson {
//   final String subject;
//   final String student;
//   final String studentId; // Student ID
//   final DateTime dateTime;
//   final int durationMinutes;
//
//   Lesson({
//     required this.subject,
//     required this.student,
//     required this.studentId,
//     required this.dateTime,
//     required this.durationMinutes,
//   });
//
//   DateTime get endTime => dateTime.add(Duration(minutes: durationMinutes));
// }

// lib/models/lesson.dart

/// Data model for scheduled lessons
class Lesson {
  final String subject;
  final String student;
  final String studentId; // Student ID
  final DateTime dateTime;
  final int durationMinutes;

  Lesson({
    required this.subject,
    required this.student,
    required this.studentId, // Initialize Student ID
    required this.dateTime,
    required this.durationMinutes,
  });

  DateTime get endTime => dateTime.add(Duration(minutes: durationMinutes));
}
