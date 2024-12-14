// // lib/widgets/summary_cards.dart
//
// import 'package:flutter/material.dart';
//
// /// Widget for displaying summary cards
// class SummaryCards extends StatelessWidget {
//   final int totalStudents;
//   final double avgLessonTime;
//
//   SummaryCards({required this.totalStudents, required this.avgLessonTime});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Total Students Taught
//         Expanded(
//           child: Card(
//             color: Colors.green.shade100,
//             elevation: 4,
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Icon(Icons.group,
//                       color: Colors.green.shade700, size: 40),
//                   SizedBox(height: 10),
//                   Text(
//                     "Total Students",
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     "$totalStudents",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade700),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 10),
//         // Average Lesson Time
//         Expanded(
//           child: Card(
//             color: Colors.orange.shade100,
//             elevation: 4,
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Icon(Icons.timer,
//                       color: Colors.orange.shade700, size: 40),
//                   SizedBox(height: 10),
//                   Text(
//                     "Avg Lesson Time",
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     "${avgLessonTime.toStringAsFixed(1)} mins",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange.shade700),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// lib/widgets/summary_cards.dart

import 'package:flutter/material.dart';

/// Widget for displaying summary cards
class SummaryCards extends StatelessWidget {
  final int totalStudents;
  final double avgLessonTime;

  SummaryCards({required this.totalStudents, required this.avgLessonTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Total Students Taught
        Expanded(
          child: Card(
            color: Colors.green.shade100,
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.group,
                      color: Colors.green.shade700, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Total Students",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$totalStudents",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        // Average Lesson Time
        Expanded(
          child: Card(
            color: Colors.orange.shade100,
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(Icons.timer,
                      color: Colors.orange.shade700, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Avg Lesson Time",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${avgLessonTime.toStringAsFixed(1)} mins",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
