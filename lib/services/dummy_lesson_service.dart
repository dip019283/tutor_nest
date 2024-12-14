// // // lib/services/dummy_lesson_service.dart
// //
// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'lesson_service.dart';
// // import '../models/lesson.dart';
// // import '../models/lesson_history.dart';
// // import '../models/time_slot.dart';
// //
// // /// Dummy implementation of LessonService to simulate database actions
// // class DummyLessonService implements LessonService {
// //   List<TimeSlot> _allTimeSlots = [
// //     TimeSlot(
// //         start: TimeOfDay(hour: 9, minute: 0),
// //         end: TimeOfDay(hour: 10, minute: 0)),
// //     TimeSlot(
// //         start: TimeOfDay(hour: 10, minute: 0),
// //         end: TimeOfDay(hour: 11, minute: 0)),
// //     TimeSlot(
// //         start: TimeOfDay(hour: 11, minute: 0),
// //         end: TimeOfDay(hour: 12, minute: 0)),
// //     // 12 PM - 1 PM Break
// //     TimeSlot(
// //         start: TimeOfDay(hour: 12, minute: 0),
// //         end: TimeOfDay(hour: 13, minute: 0),
// //         isBreak: true),
// //     TimeSlot(
// //         start: TimeOfDay(hour: 13, minute: 0),
// //         end: TimeOfDay(hour: 14, minute: 0)),
// //     TimeSlot(
// //         start: TimeOfDay(hour: 14, minute: 0),
// //         end: TimeOfDay(hour: 15, minute: 0)),
// //     TimeSlot(
// //         start: TimeOfDay(hour: 15, minute: 0),
// //         end: TimeOfDay(hour: 16, minute: 0)),
// //     TimeSlot(
// //         start: TimeOfDay(hour: 16, minute: 0),
// //         end: TimeOfDay(hour: 17, minute: 0)),
// //   ];
// //
// //   Map<TimeSlot, bool> _bookedTimeSlots = {};
// //
// //   List<Lesson> _scheduledLessons = [];
// //
// //   List<LessonHistory> _lessonHistory = [];
// //
// //   Timer? _timer;
// //
// //   DummyLessonService() {
// //     _initializeData();
// //     _startTimer();
// //   }
// //
// //   void _initializeData() {
// //     // Initialize all time slots as available or break
// //     for (var slot in _allTimeSlots) {
// //       _bookedTimeSlots[slot] = slot.isBreak ? true : false; // Break slots are booked
// //     }
// //
// //     // Initialize with some scheduled lessons
// //     _scheduledLessons = [
// //       Lesson(
// //           subject: "Mathematics",
// //           student: "John Doe",
// //           studentId: "S12345",
// //           dateTime: DateTime.now().add(Duration(hours: 1)),
// //           durationMinutes: 60),
// //       Lesson(
// //           subject: "Physics",
// //           student: "Jane Smith",
// //           studentId: "S23456",
// //           dateTime: DateTime.now().add(Duration(hours: 3)),
// //           durationMinutes: 60),
// //     ];
// //
// //     // Mark the booked time slots
// //     for (var lesson in _scheduledLessons) {
// //       TimeSlot? slot = _allTimeSlots.firstWhere(
// //               (ts) =>
// //           ts.start.hour == lesson.dateTime.hour &&
// //               ts.start.minute == lesson.dateTime.minute,
// //           orElse: () => TimeSlot(
// //               start: TimeOfDay(hour: 0, minute: 0),
// //               end: TimeOfDay(hour: 0, minute: 0)));
// //       if (slot.isValid) {
// //         _bookedTimeSlots[slot] = true;
// //       }
// //     }
// //
// //     // Initialize with some history data
// //     _lessonHistory = [
// //       LessonHistory(
// //           subject: "Biology",
// //           student: "Tom Hanks",
// //           studentId: "S45678",
// //           dateTime: DateTime.now().subtract(Duration(days: 1, hours: 2)),
// //           feedback: "Excellent understanding of the subject."),
// //     ];
// //   }
// //
// //   void _startTimer() {
// //     // Timer to check for completed lessons every minute
// //     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
// //       _checkCompletedLessons();
// //     });
// //   }
// //
// //   void _checkCompletedLessons() {
// //     DateTime now = DateTime.now();
// //     List<Lesson> completedLessons = _scheduledLessons
// //         .where((lesson) => now.isAfter(lesson.endTime))
// //         .toList();
// //
// //     if (completedLessons.isNotEmpty) {
// //       for (var lesson in completedLessons) {
// //         // Remove from scheduled lessons
// //         _scheduledLessons.remove(lesson);
// //
// //         // Mark the time slot as available
// //         TimeSlot slot = _allTimeSlots.firstWhere(
// //                 (ts) =>
// //             ts.start.hour == lesson.dateTime.hour &&
// //                 ts.start.minute == lesson.dateTime.minute,
// //             orElse: () => TimeSlot(
// //                 start: TimeOfDay(hour: 0, minute: 0),
// //                 end: TimeOfDay(hour: 0, minute: 0)));
// //         if (slot.isValid && !slot.isBreak) {
// //           _bookedTimeSlots[slot] = false;
// //         }
// //
// //         // Add to history with dummy feedback
// //         _lessonHistory.add(LessonHistory(
// //             subject: lesson.subject,
// //             student: lesson.student,
// //             studentId: lesson.studentId,
// //             dateTime: lesson.dateTime,
// //             feedback: "Great lesson!"));
// //       }
// //     }
// //   }
// //
// //   @override
// //   Future<List<TimeSlot>> fetchTimeSlots() async {
// //     // Simulate network delay
// //     await Future.delayed(Duration(milliseconds: 500));
// //     return _allTimeSlots;
// //   }
// //
// //   @override
// //   Future<List<Lesson>> fetchScheduledLessons() async {
// //     await Future.delayed(Duration(milliseconds: 500));
// //     return List.from(_scheduledLessons);
// //   }
// //
// //   @override
// //   Future<List<LessonHistory>> fetchLessonHistory() async {
// //     await Future.delayed(Duration(milliseconds: 500));
// //     return List.from(_lessonHistory);
// //   }
// //
// //   @override
// //   Future<void> addLesson(Lesson lesson) async {
// //     await Future.delayed(Duration(milliseconds: 500));
// //     _scheduledLessons.add(lesson);
// //
// //     TimeSlot? slot = _allTimeSlots.firstWhere(
// //             (ts) =>
// //         ts.start.hour == lesson.dateTime.hour &&
// //             ts.start.minute == lesson.dateTime.minute,
// //         orElse: () => TimeSlot(
// //             start: TimeOfDay(hour: 0, minute: 0),
// //             end: TimeOfDay(hour: 0, minute: 0)));
// //     if (slot.isValid && !slot.isBreak) {
// //       _bookedTimeSlots[slot] = true;
// //     }
// //   }
// //
// //   @override
// //   Future<void> removeLesson(Lesson lesson) async {
// //     await Future.delayed(Duration(milliseconds: 500));
// //     _scheduledLessons.remove(lesson);
// //
// //     TimeSlot slot = _allTimeSlots.firstWhere(
// //             (ts) =>
// //         ts.start.hour == lesson.dateTime.hour &&
// //             ts.start.minute == lesson.dateTime.minute,
// //         orElse: () => TimeSlot(
// //             start: TimeOfDay(hour: 0, minute: 0),
// //             end: TimeOfDay(hour: 0, minute: 0)));
// //     if (slot.isValid && !slot.isBreak) {
// //       _bookedTimeSlots[slot] = false;
// //     }
// //
// //     _lessonHistory.add(LessonHistory(
// //         subject: lesson.subject,
// //         student: lesson.student,
// //         studentId: lesson.studentId,
// //         dateTime: lesson.dateTime,
// //         feedback: "Completed successfully."));
// //   }
// //
// //   @override
// //   Future<int> getTotalUniqueStudents() async {
// //     await Future.delayed(Duration(milliseconds: 300));
// //     Set<String> students = {};
// //     for (var lesson in _lessonHistory) {
// //       students.add(lesson.student);
// //     }
// //     for (var lesson in _scheduledLessons) {
// //       students.add(lesson.student);
// //     }
// //     return students.length;
// //   }
// //
// //   @override
// //   Future<double> getAverageLessonTime() async {
// //     await Future.delayed(Duration(milliseconds: 300));
// //     if (_lessonHistory.isEmpty) return 0.0;
// //     int totalMinutes = 0;
// //     for (var lesson in _lessonHistory) {
// //       totalMinutes += lesson.durationMinutes;
// //     }
// //     return totalMinutes / _lessonHistory.length;
// //   }
// //
// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //   }
// // }
//
// // lib/services/dummy_lesson_service.dart
//
// import 'dart:async';
// import '../models/lesson.dart';
// import '../models/lesson_history.dart';
// import '../models/time_slot.dart';
// import 'lesson_service.dart';
// import 'package:flutter/material.dart';
//
// /// Dummy implementation of LessonService to simulate database actions
// class DummyLessonService implements LessonService {
//   List<TimeSlot> _allTimeSlots = [
//     TimeSlot(
//         start: TimeOfDay(hour: 9, minute: 0),
//         end: TimeOfDay(hour: 10, minute: 0)),
//     TimeSlot(
//         start: TimeOfDay(hour: 10, minute: 0),
//         end: TimeOfDay(hour: 11, minute: 0)),
//     TimeSlot(
//         start: TimeOfDay(hour: 11, minute: 0),
//         end: TimeOfDay(hour: 12, minute: 0)),
//     // 12 PM - 1 PM Break
//     TimeSlot(
//         start: TimeOfDay(hour: 12, minute: 0),
//         end: TimeOfDay(hour: 13, minute: 0),
//         isBreak: true),
//     TimeSlot(
//         start: TimeOfDay(hour: 13, minute: 0),
//         end: TimeOfDay(hour: 14, minute: 0)),
//     TimeSlot(
//         start: TimeOfDay(hour: 14, minute: 0),
//         end: TimeOfDay(hour: 15, minute: 0)),
//     TimeSlot(
//         start: TimeOfDay(hour: 15, minute: 0),
//         end: TimeOfDay(hour: 16, minute: 0)),
//     TimeSlot(
//         start: TimeOfDay(hour: 16, minute: 0),
//         end: TimeOfDay(hour: 17, minute: 0)),
//   ];
//
//   Map<TimeSlot, bool> _bookedTimeSlots = {};
//
//   List<Lesson> _scheduledLessons = [];
//
//   List<LessonHistory> _lessonHistory = [];
//
//   Timer? _timer;
//
//   DummyLessonService() {
//     _initializeData();
//     _startTimer();
//   }
//
//   void _initializeData() {
//     // Initialize all time slots as available or break
//     for (var slot in _allTimeSlots) {
//       _bookedTimeSlots[slot] = slot.isBreak ? true : false; // Break slots are booked
//     }
//
//     // Initialize with some scheduled lessons
//     _scheduledLessons = [
//       Lesson(
//           subject: "Mathematics",
//           student: "John Doe",
//           studentId: "S12345",
//           dateTime: DateTime.now().add(Duration(hours: 1)),
//           durationMinutes: 60),
//       Lesson(
//           subject: "Physics",
//           student: "Jane Smith",
//           studentId: "S23456",
//           dateTime: DateTime.now().add(Duration(hours: 3)),
//           durationMinutes: 60),
//     ];
//
//     // Mark the booked time slots
//     for (var lesson in _scheduledLessons) {
//       TimeSlot? slot = _allTimeSlots.firstWhere(
//               (ts) =>
//           ts.start.hour == lesson.dateTime.hour &&
//               ts.start.minute == lesson.dateTime.minute,
//           orElse: () => TimeSlot(
//               start: TimeOfDay(hour: 0, minute: 0),
//               end: TimeOfDay(hour: 0, minute: 0)));
//       if (slot.isValid) {
//         _bookedTimeSlots[slot] = true;
//       }
//     }
//
//     // Initialize with some history data
//     _lessonHistory = [
//       LessonHistory(
//           subject: "Biology",
//           student: "Tom Hanks",
//           studentId: "S45678",
//           dateTime: DateTime.now().subtract(Duration(days: 1, hours: 2)),
//           feedback: "Excellent understanding of the subject."),
//     ];
//   }
//
//   void _startTimer() {
//     // Timer to check for completed lessons every minute
//     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
//       _checkCompletedLessons();
//     });
//   }
//
//   void _checkCompletedLessons() {
//     DateTime now = DateTime.now();
//     List<Lesson> completedLessons = _scheduledLessons
//         .where((lesson) => now.isAfter(lesson.endTime))
//         .toList();
//
//     if (completedLessons.isNotEmpty) {
//       for (var lesson in completedLessons) {
//         // Remove from scheduled lessons
//         _scheduledLessons.remove(lesson);
//
//         // Mark the time slot as available
//         TimeSlot slot = _allTimeSlots.firstWhere(
//                 (ts) =>
//             ts.start.hour == lesson.dateTime.hour &&
//                 ts.start.minute == lesson.dateTime.minute,
//             orElse: () => TimeSlot(
//                 start: TimeOfDay(hour: 0, minute: 0),
//                 end: TimeOfDay(hour: 0, minute: 0)));
//         if (slot.isValid && !slot.isBreak) {
//           _bookedTimeSlots[slot] = false;
//         }
//
//         // Add to history with dummy feedback
//         _lessonHistory.add(LessonHistory(
//             subject: lesson.subject,
//             student: lesson.student,
//             studentId: lesson.studentId,
//             dateTime: lesson.dateTime,
//             feedback: "Great lesson!"));
//       }
//     }
//   }
//
//   @override
//   Future<List<TimeSlot>> fetchTimeSlots() async {
//     // Simulate network delay
//     await Future.delayed(Duration(milliseconds: 500));
//     return _allTimeSlots;
//   }
//
//   @override
//   Future<List<Lesson>> fetchScheduledLessons() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     return List.from(_scheduledLessons);
//   }
//
//   @override
//   Future<List<LessonHistory>> fetchLessonHistory() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     return List.from(_lessonHistory);
//   }
//
//   @override
//   Future<void> addLesson(Lesson lesson) async {
//     await Future.delayed(Duration(milliseconds: 500));
//     _scheduledLessons.add(lesson);
//
//     TimeSlot? slot = _allTimeSlots.firstWhere(
//             (ts) =>
//         ts.start.hour == lesson.dateTime.hour &&
//             ts.start.minute == lesson.dateTime.minute,
//         orElse: () => TimeSlot(
//             start: TimeOfDay(hour: 0, minute: 0),
//             end: TimeOfDay(hour: 0, minute: 0)));
//     if (slot.isValid && !slot.isBreak) {
//       _bookedTimeSlots[slot] = true;
//     }
//   }
//
//   @override
//   Future<void> removeLesson(Lesson lesson) async {
//     await Future.delayed(Duration(milliseconds: 500));
//     _scheduledLessons.remove(lesson);
//
//     TimeSlot slot = _allTimeSlots.firstWhere(
//             (ts) =>
//         ts.start.hour == lesson.dateTime.hour &&
//             ts.start.minute == lesson.dateTime.minute,
//         orElse: () => TimeSlot(
//             start: TimeOfDay(hour: 0, minute: 0),
//             end: TimeOfDay(hour: 0, minute: 0)));
//     if (slot.isValid && !slot.isBreak) {
//       _bookedTimeSlots[slot] = false;
//     }
//
//     _lessonHistory.add(LessonHistory(
//         subject: lesson.subject,
//         student: lesson.student,
//         studentId: lesson.studentId,
//         dateTime: lesson.dateTime,
//         feedback: "Completed successfully."));
//   }
//
//   @override
//   Future<int> getTotalUniqueStudents() async {
//     await Future.delayed(Duration(milliseconds: 300));
//     Set<String> students = {};
//     for (var lesson in _lessonHistory) {
//       students.add(lesson.student);
//     }
//     for (var lesson in _scheduledLessons) {
//       students.add(lesson.student);
//     }
//     return students.length;
//   }
//
//   @override
//   Future<double> getAverageLessonTime() async {
//     await Future.delayed(Duration(milliseconds: 300));
//     if (_lessonHistory.isEmpty) return 0.0;
//     int totalMinutes = 0;
//     for (var lesson in _lessonHistory) {
//       totalMinutes += lesson.durationMinutes;
//     }
//     return totalMinutes / _lessonHistory.length;
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//   }
// }

// lib/services/dummy_lesson_service.dart

import 'dart:async';
import '../models/lesson.dart';
import '../models/lesson_history.dart';
import '../models/time_slot.dart';
import 'lesson_service.dart';
import 'package:flutter/material.dart';

/// Dummy implementation of LessonService to simulate database actions
class DummyLessonService implements LessonService {
  List<TimeSlot> _allTimeSlots = [
    TimeSlot(
        start: TimeOfDay(hour: 9, minute: 0),
        end: TimeOfDay(hour: 10, minute: 0)),
    TimeSlot(
        start: TimeOfDay(hour: 10, minute: 0),
        end: TimeOfDay(hour: 11, minute: 0)),
    TimeSlot(
        start: TimeOfDay(hour: 11, minute: 0),
        end: TimeOfDay(hour: 12, minute: 0)),
    // 12 PM - 1 PM Break
    TimeSlot(
        start: TimeOfDay(hour: 12, minute: 0),
        end: TimeOfDay(hour: 13, minute: 0),
        isBreak: true),
    TimeSlot(
        start: TimeOfDay(hour: 13, minute: 0),
        end: TimeOfDay(hour: 14, minute: 0)),
    TimeSlot(
        start: TimeOfDay(hour: 14, minute: 0),
        end: TimeOfDay(hour: 15, minute: 0)),
    TimeSlot(
        start: TimeOfDay(hour: 15, minute: 0),
        end: TimeOfDay(hour: 16, minute: 0)),
    TimeSlot(
        start: TimeOfDay(hour: 16, minute: 0),
        end: TimeOfDay(hour: 17, minute: 0)),
  ];

  Map<TimeSlot, bool> _bookedTimeSlots = {};

  List<Lesson> _scheduledLessons = [];

  List<LessonHistory> _lessonHistory = [];

  Timer? _timer;

  DummyLessonService() {
    _initializeData();
    _startTimer();
  }

  void _initializeData() {
    // Initialize all time slots as available or break
    for (var slot in _allTimeSlots) {
      _bookedTimeSlots[slot] = slot.isBreak ? true : false; // Break slots are booked
    }

    // Initialize with some scheduled lessons
    _scheduledLessons = [
      Lesson(
          subject: "Mathematics",
          student: "John Doe",
          studentId: "S12345",
          dateTime: DateTime.now().add(Duration(hours: 1)),
          durationMinutes: 60),
      Lesson(
          subject: "Physics",
          student: "Jane Smith",
          studentId: "S23456",
          dateTime: DateTime.now().add(Duration(hours: 3)),
          durationMinutes: 60),
    ];

    // Mark the booked time slots
    for (var lesson in _scheduledLessons) {
      TimeSlot? slot = _allTimeSlots.firstWhere(
              (ts) =>
          ts.start.hour == lesson.dateTime.hour &&
              ts.start.minute == lesson.dateTime.minute,
          orElse: () => TimeSlot(
              start: TimeOfDay(hour: 0, minute: 0),
              end: TimeOfDay(hour: 0, minute: 0)));
      if (slot.isValid) {
        _bookedTimeSlots[slot] = true;
      }
    }

    // Initialize with some history data
    _lessonHistory = [
      LessonHistory(
        subject: "Biology",
        student: "Tom Hanks",
        studentId: "S45678",
        dateTime: DateTime.now().subtract(Duration(days: 1, hours: 2)),
        feedback: "Excellent understanding of the subject.",
        durationMinutes: 60, // Provide durationMinutes
      ),
    ];
  }

  void _startTimer() {
    // Timer to check for completed lessons every minute
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkCompletedLessons();
    });
  }

  void _checkCompletedLessons() {
    DateTime now = DateTime.now();
    List<Lesson> completedLessons = _scheduledLessons
        .where((lesson) => now.isAfter(lesson.endTime))
        .toList();

    if (completedLessons.isNotEmpty) {
      for (var lesson in completedLessons) {
        // Remove from scheduled lessons
        _scheduledLessons.remove(lesson);

        // Mark the time slot as available
        TimeSlot slot = _allTimeSlots.firstWhere(
                (ts) =>
            ts.start.hour == lesson.dateTime.hour &&
                ts.start.minute == lesson.dateTime.minute,
            orElse: () => TimeSlot(
                start: TimeOfDay(hour: 0, minute: 0),
                end: TimeOfDay(hour: 0, minute: 0)));
        if (slot.isValid && !slot.isBreak) {
          _bookedTimeSlots[slot] = false;
        }

        // Add to history with dummy feedback
        _lessonHistory.add(LessonHistory(
          subject: lesson.subject,
          student: lesson.student,
          studentId: lesson.studentId,
          dateTime: lesson.dateTime,
          feedback: "Great lesson!",
          durationMinutes: lesson.durationMinutes, // Pass durationMinutes
        ));
      }
    }
  }

  @override
  Future<List<TimeSlot>> fetchTimeSlots() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    return _allTimeSlots;
  }

  @override
  Future<List<Lesson>> fetchScheduledLessons() async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.from(_scheduledLessons);
  }

  @override
  Future<List<LessonHistory>> fetchLessonHistory() async {
    await Future.delayed(Duration(milliseconds: 500));
    return List.from(_lessonHistory);
  }

  @override
  Future<void> addLesson(Lesson lesson) async {
    await Future.delayed(Duration(milliseconds: 500));
    _scheduledLessons.add(lesson);

    TimeSlot? slot = _allTimeSlots.firstWhere(
            (ts) =>
        ts.start.hour == lesson.dateTime.hour &&
            ts.start.minute == lesson.dateTime.minute,
        orElse: () => TimeSlot(
            start: TimeOfDay(hour: 0, minute: 0),
            end: TimeOfDay(hour: 0, minute: 0)));
    if (slot.isValid && !slot.isBreak) {
      _bookedTimeSlots[slot] = true;
    }
  }

  @override
  Future<void> removeLesson(Lesson lesson) async {
    await Future.delayed(Duration(milliseconds: 500));
    _scheduledLessons.remove(lesson);

    TimeSlot slot = _allTimeSlots.firstWhere(
            (ts) =>
        ts.start.hour == lesson.dateTime.hour &&
            ts.start.minute == lesson.dateTime.minute,
        orElse: () => TimeSlot(
            start: TimeOfDay(hour: 0, minute: 0),
            end: TimeOfDay(hour: 0, minute: 0)));
    if (slot.isValid && !slot.isBreak) {
      _bookedTimeSlots[slot] = false;
    }

    _lessonHistory.add(LessonHistory(
      subject: lesson.subject,
      student: lesson.student,
      studentId: lesson.studentId,
      dateTime: lesson.dateTime,
      feedback: "Completed successfully.",
      durationMinutes: lesson.durationMinutes,
    ));
  }

  @override
  Future<int> getTotalUniqueStudents() async {
    await Future.delayed(Duration(milliseconds: 300));
    Set<String> students = {};
    for (var lesson in _lessonHistory) {
      students.add(lesson.student);
    }
    for (var lesson in _scheduledLessons) {
      students.add(lesson.student);
    }
    return students.length;
  }

  @override
  Future<double> getAverageLessonTime() async {
    await Future.delayed(Duration(milliseconds: 300));
    if (_lessonHistory.isEmpty) return 0.0;
    int totalMinutes = 0;
    for (var lesson in _lessonHistory) {
      totalMinutes += lesson.durationMinutes;
    }
    return totalMinutes / _lessonHistory.length;
  }

  @override
  void dispose() {
    _timer?.cancel();
  }
}
