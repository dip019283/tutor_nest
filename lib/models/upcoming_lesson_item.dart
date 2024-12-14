// lib/models/upcoming_lesson_item.dart

class UpcomingLessonItem {
  final String id; // Primary key
  final String day;
  final String date;
  final String time;
  final String totalLessonTime;

  UpcomingLessonItem({
    required this.id,
    required this.day,
    required this.date,
    required this.time,
    required this.totalLessonTime,
  });

  // Factory method to create an UpcomingLessonItem from JSON or Firestore document
  factory UpcomingLessonItem.fromJson(Map<String, dynamic> json, String docId) {
    return UpcomingLessonItem(
      id: docId,
      day: json['day'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      totalLessonTime: json['totalLessonTime'] ?? '',
    );
  }

  // Method to convert an UpcomingLessonItem to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'date': date,
      'time': time,
      'totalLessonTime': totalLessonTime,
    };
  }
}
