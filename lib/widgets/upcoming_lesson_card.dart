// import 'package:flutter/material.dart';
//
// class UpcomingLessonCard extends StatelessWidget {
//   final Map<String, dynamic> lesson;
//
//   const UpcomingLessonCard({Key? key, required this.lesson}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blue[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Upcoming Lesson",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(height: 8),
//           Row(
//             children: [
//               Icon(Icons.calendar_today, size: 16),
//               SizedBox(width: 8),
//               Text("${lesson['day']} ${lesson['date']}\n${lesson['time']}"),
//             ],
//           ),
//           SizedBox(height: 8),
//           ElevatedButton.icon(
//             onPressed: () {
//               // Handle entering the lesson room
//             },
//             icon: Icon(Icons.play_arrow),
//             label: Text("Enter lesson room"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             "Total lesson time: ${lesson['totalLessonTime']}",
//             style: TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }

// lib/widgets/upcoming_lesson_card.dart

import 'package:flutter/material.dart';
import '../models/upcoming_lesson_item.dart';

class UpcomingLessonCard extends StatelessWidget {
  final UpcomingLessonItem lesson;

  const UpcomingLessonCard({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Lesson",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16),
              SizedBox(width: 8),
              Text("${lesson.day} ${lesson.date}\n${lesson.time}"),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // Handle entering the lesson room
            },
            icon: Icon(Icons.play_arrow),
            label: Text("Enter lesson room"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Total lesson time: ${lesson.totalLessonTime}",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
