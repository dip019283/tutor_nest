// // lib/widgets/course_card.dart
// import 'package:flutter/material.dart';
//
// class CourseCard extends StatelessWidget {
//   final Map<String, String> data;
//   final VoidCallback? onTap;
//
//   const CourseCard({Key? key, required this.data, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Course image
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//             child: Image.network(
//               data['image']!,
//               width: double.infinity,
//               height: 150,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Course name
//                 Text(
//                   data['name']!,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 // Course description
//                 Text(
//                   data['description']!,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 14),
//                 ),
//
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class CourseCard extends StatelessWidget {
//   final Map<String, String> data;
//   final VoidCallback? onTap;
//
//   const CourseCard({Key? key, required this.data, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       elevation: 2,
//       child: InkWell(
//         onTap: onTap, // Handle tap events
//         borderRadius: BorderRadius.circular(8), // For ripple effect within the card's border radius
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Course image
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//               child: Image.network(
//                 data['image']!,
//                 width: double.infinity,
//                 height: 150,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Course name
//                   Text(
//                     data['name']!,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   // Course description
//                   Text(
//                     data['description']!,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../models/course.dart';
//
// class CourseCard extends StatelessWidget {
//   final Course course;
//   final VoidCallback? onTap;
//
//   const CourseCard({Key? key, required this.course, this.onTap}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       elevation: 2,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8), // For ripple effect within the card's border radius
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Course image
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
//               child: Image.network(
//                 course.image,
//                 width: double.infinity,
//                 height: 150,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Course name
//                   Text(
//                     course.name,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   // Course description
//                   Text(
//                     course.description,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/widgets/course_card.dart
import 'package:flutter/material.dart';
import '../models/courseModel.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const CourseCard({Key? key, required this.course, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8), // Ensures ripple effect respects border radius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                course.image,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Course Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Name
                  Text(
                    course.courseName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Course Description
                  Text(
                    course.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

