// // lib/services/history_service.dart
// import 'dart:async';
//
// class HistoryService {
//   // Dummy history data
//   Future<List<Map<String, dynamic>>> fetchHistory() async {
//     // Simulate delay
//     await Future.delayed(Duration(seconds: 1));
//     // Dummy data
//     return [
//       {
//         "name": "Dipesh Maharjan",
//         "rating": 5,
//         "date": "Saturday December 31 2022",
//         "time": "09:00 - 10:00",
//         "feedback": "Great lesson, learned a lot!",
//         "image": "https://example.com/dipesh_maharjan.jpg",
//       },
//       {
//         "name": "Dinesh Adhikari",
//         "rating": 4,
//         "date": "Friday December 30 2022",
//         "time": "14:00 - 15:00",
//         "feedback": "Very helpful session.",
//         "image": "https://example.com/dinesh_adhikari.jpg",
//       },
//     ];
//   }
// }

// lib/services/history_service.dart
import 'dart:async';
import '../models/history_item.dart'; // Import the HistoryItem model

class HistoryService {
  // Dummy history data with 'id' as primary key
  Future<List<HistoryItem>> fetchHistory() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Dummy data with unique 'id's
    return [
      HistoryItem(
        id: 'history1',
        name: "Dipesh Maharjan",
        rating: 5,
        date: "Saturday December 31 2022",
        time: "09:00 - 10:00",
        feedback: "Great lesson, learned a lot!",
        image: "https://example.com/dipesh_maharjan.jpg",
      ),
      HistoryItem(
        id: 'history2',
        name: "Dinesh Adhikari",
        rating: 4,
        date: "Friday December 30 2022",
        time: "14:00 - 15:00",
        feedback: "Very helpful session.",
        image: "https://example.com/dinesh_adhikari.jpg",
      ),
      // Add more dummy data as needed
    ];
  }
}
