// // lib/services/lesson_service.dart
//
// import '../models/lesson.dart';
// import '../models/lesson_history.dart';
// import '../models/time_slot.dart';
//
// /// Abstract service to manage lessons
// abstract class LessonService {
//   Future<List<TimeSlot>> fetchTimeSlots();
//   Future<List<Lesson>> fetchScheduledLessons();
//   Future<List<LessonHistory>> fetchLessonHistory();
//   Future<void> addLesson(Lesson lesson);
//   Future<void> removeLesson(Lesson lesson);
//   Future<int> getTotalUniqueStudents();
//   Future<double> getAverageLessonTime();
//   void dispose(); // To clean up any resources if needed
// }

// lib/services/lesson_service.dart

import '../models/lesson.dart';
import '../models/lesson_history.dart';
import '../models/time_slot.dart';

/// Abstract service to manage lessons
abstract class LessonService {
  Future<List<TimeSlot>> fetchTimeSlots();
  Future<List<Lesson>> fetchScheduledLessons();
  Future<List<LessonHistory>> fetchLessonHistory();
  Future<void> addLesson(Lesson lesson);
  Future<void> removeLesson(Lesson lesson);
  Future<int> getTotalUniqueStudents();
  Future<double> getAverageLessonTime();
  void dispose(); // To clean up any resources if needed
}
