// // lib/models/lesson_history.dart
//
// /// Data model for lesson history
// class LessonHistory {
//   final String subject;
//   final String student;
//   final String studentId; // Student ID
//   final DateTime dateTime;
//   final String feedback;
//   final int durationMinutes;
//
//   LessonHistory({
//     required this.subject,
//     required this.student,
//     required this.studentId,
//     required this.dateTime,
//     required this.feedback,
//     this.durationMinutes = 60, // Default duration
//   });
// }

// lib/models/lesson_history.dart

/// Data model for lesson history
class LessonHistory {
  final String subject;
  final String student;
  final String studentId; // Student ID
  final DateTime dateTime;
  final String feedback;
  final int durationMinutes;

  LessonHistory({
    required this.subject,
    required this.student,
    required this.studentId, // Initialize Student ID
    required this.dateTime,
    required this.feedback,
    this.durationMinutes = 60, // Default duration
  });
}
