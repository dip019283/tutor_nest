// lib/models/history_item.dart
class HistoryItem {
  final String id; // Primary key
  final String name;
  final int rating;
  final String date;
  final String time;
  final String feedback;
  final String image;

  HistoryItem({
    required this.id,
    required this.name,
    required this.rating,
    required this.date,
    required this.time,
    required this.feedback,
    required this.image,
  });

  // Factory method to create a HistoryItem from JSON
  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      name: json['name'],
      rating: json['rating'],
      date: json['date'],
      time: json['time'],
      feedback: json['feedback'],
      image: json['image'],
    );
  }

  // Method to convert a HistoryItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'date': date,
      'time': time,
      'feedback': feedback,
      'image': image,
    };
  }
}
