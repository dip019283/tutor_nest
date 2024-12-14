// lib/models/booking_item.dart

class BookingItem {
  final String id; // Primary key
  final String name;
  final int rating;
  final String date;
  final String time;
  final String request;
  final String image;

  BookingItem({
    required this.id,
    required this.name,
    required this.rating,
    required this.date,
    required this.time,
    required this.request,
    required this.image,
  });

  // Factory method to create a BookingItem from JSON or Firestore document
  factory BookingItem.fromJson(Map<String, dynamic> json, String docId) {
    return BookingItem(
      id: docId,
      name: json['name'],
      rating: json['rating'],
      date: json['date'],
      time: json['time'],
      request: json['request'],
      image: json['image'],
    );
  }

  // Method to convert a BookingItem to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rating': rating,
      'date': date,
      'time': time,
      'request': request,
      'image': image,
    };
  }
}
