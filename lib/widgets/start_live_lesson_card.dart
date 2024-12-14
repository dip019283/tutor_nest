// // lib/widgets/start_live_lesson_card.dart
//
// import 'package:flutter/material.dart';
//
// /// Widget for Start Live Lesson Card
// class StartLiveLessonCard extends StatelessWidget {
//   final VoidCallback onTap;
//
//   StartLiveLessonCard({required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         color: Colors.blue.shade100,
//         elevation: 4,
//         child: Container(
//           height: 100, // Adjust height as needed
//           child: Center(
//             child: Text(
//               "Start Live Lesson",
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue.shade800),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/widgets/start_live_lesson_card.dart

import 'package:flutter/material.dart';

/// Widget for Start Live Lesson Card
class StartLiveLessonCard extends StatelessWidget {
  final VoidCallback onTap;

  StartLiveLessonCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.blue.shade100,
        elevation: 4,
        child: Container(
          height: 100, // Adjust height as needed
          child: Center(
            child: Text(
              "Start Live Lesson",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800),
            ),
          ),
        ),
      ),
    );
  }
}
