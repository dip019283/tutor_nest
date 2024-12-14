// // lib/services/schedule_service.dart
// import 'dart:async';
//
// class ScheduleService {
//   // Dummy bookings data
//   Future<List<Map<String, dynamic>>> fetchBookings() async {
//     // Simulate delay
//     await Future.delayed(Duration(seconds: 1));
//     // Dummy data
//     return [
//       {
//         "name": "Dipesh Maharjan",
//         "rating": 5,
//         "date": "Sunday January 1 2023",
//         "time": "10:45 - 11:50",
//         "request":
//         "Please bring necessary course materials for the class and maintain silence while teaching to better.",
//         "image": "https://example.com/dipesh_maharjan.jpg",
//       },
//       {
//         "name": "Dinesh Adhikari",
//         "rating": 4,
//         "date": "Sunday January 1 2023",
//         "time": "12:00 - 13:00",
//         "request": "Looking forward to our session on advanced mathematics.",
//         "image": "https://example.com/dinesh_adhikari.jpg",
//       },
//     ];
//   }
// }

// lib/services/schedule_service.dart

import 'dart:async';
import '../models/booking_item.dart';

class ScheduleService {
  // Dummy bookings data with 'id' as primary key
  Future<List<BookingItem>> fetchBookings() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Dummy data with unique 'id's
    return [
      BookingItem(
        id: 'booking1',
        name: "Dipesh Maharjan",
        rating: 5,
        date: "Sunday January 1 2023",
        time: "10:45 - 11:50",
        request:
        "Please bring necessary course materials for the class and maintain silence while teaching to better.",
        image: "https://example.com/dipesh_maharjan.jpg",
      ),
      BookingItem(
        id: 'booking2',
        name: "Dinesh Adhikari",
        rating: 4,
        date: "Sunday January 1 2023",
        time: "12:00 - 13:00",
        request: "Looking forward to our session on advanced mathematics.",
        image: "https://example.com/dinesh_adhikari.jpg",
      ),
      // Add more dummy data as needed
    ];
  }

// Example of how to fetch from Firestore in the future
/*
  Future<List<BookingItem>> fetchBookingsFromFirestore() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookings').get();
      return snapshot.docs.map((doc) => BookingItem.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      throw Exception('Failed to load bookings: $e');
    }
  }
  */
}
