// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0; // Tracks the currently selected page in the bottom nav
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text("Upcoming Lesson", style: TextStyle(fontSize: 16)),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Upcoming Lesson Section
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Upcoming Lesson",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.calendar_today, size: 16),
//                       SizedBox(width: 8),
//                       Text("No lesson scheduled", style: TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Recommended Tutors Section
//             Text(
//               "Recommended Tutors",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 3, // Adjust the number of cards if needed
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 16,
//                             width: 100,
//                             color: Colors.grey[300],
//                           ),
//                           SizedBox(height: 8),
//                           Container(
//                             height: 16,
//                             width: 150,
//                             color: Colors.grey[300],
//                           ),
//                           SizedBox(height: 16),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: List.generate(3, (index) {
//                               return Container(
//                                 height: 20,
//                                 width: 50,
//                                 color: Colors.grey[300],
//                               );
//                             }),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule),
//             label: "Schedule",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: "History",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.group),
//             label: "Groups",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: "Settings",
//           ),
//         ],
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.blue, // Highlighted color for selected item
//         unselectedItemColor: Colors.grey, // Default color for unselected items
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index; // Update the selected index
//           });
//
//           // Navigate to different pages (add navigation logic here)
//           if (index == 0) {
//             // Home page logic
//           } else if (index == 1) {
//             // Schedule page logic
//           }
//           // Add additional cases for other pages
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Logo
//             Row(
//               children: [
//                 Image.asset(
//                   'assets/logo.png', // Replace with your logo asset
//                   height: 32,
//                 ),
//                 SizedBox(width: 8),
//                 Text(
//                   'EDUCATION',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//
//             // Language Selector
//             Icon(Icons.language),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Upcoming Lesson Section
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Upcoming Lesson",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.calendar_today, size: 16),
//                       SizedBox(width: 8),
//                       Text("Sun 21 Jan 2024\n00:00 - 00:25 (starts in 3 hours)"),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.play_arrow),
//                     label: Text("Enter lesson room"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Button color
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Total lesson time: 3 hours",
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Search Bar and Filters
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Find a tutor",
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Filters"),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // Button text color
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // Recommended Tutors Section
//             Text(
//               "Recommended Tutors",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 3, // Adjust the number of cards if needed
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Tutor Name
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor: Colors.orange, // Avatar color
//                               ),
//                               SizedBox(width: 8),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Tutor Name",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.grey),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16),
//
//                           // Tags
//                           Wrap(
//                             spacing: 8,
//                             children: List.generate(5, (index) {
//                               return Chip(
//                                 label: Text("Tag $index"),
//                                 backgroundColor: Colors.blue[50],
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule),
//             label: "Schedule",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: "History",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.group),
//             label: "Groups",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: "Settings",
//           ),
//         ],
//         currentIndex: 0,
//         selectedItemColor: Colors.blue, // Highlighted color for selected item
//         unselectedItemColor: Colors.grey, // Default color for unselected items
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60), // Adjust the height of the app bar
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           centerTitle: false,
//           title: Row(
//             children: [
//               Image.asset(
//                 'assets/logo.png', // Replace with your logo
//                 height: 40,
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'EDUCATION',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             // Language Selector (Flag)
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Image.asset(
//                 'assets/us_flag.png', // Replace with your flag image
//                 height: 24,
//                 width: 24,
//               ),
//             ),
//             // Menu Icon
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Icon(
//                 Icons.menu,
//                 color: Colors.black,
//                 size: 28,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Upcoming Lesson Section
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Upcoming Lesson",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Icon(Icons.calendar_today, size: 16),
//                       SizedBox(width: 8),
//                       Text("Sun 21 Jan 2024\n00:00 - 00:25 (starts in 3 hours)"),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.play_arrow),
//                     label: Text("Enter lesson room"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Button color
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Total lesson time: 3 hours",
//                     style: TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 24),
//
//             // Search Bar and Filters
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Find a tutor",
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Filters"),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // Button text color
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // Recommended Tutors Section
//             Text(
//               "Recommended Tutors",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 3, // Adjust the number of cards if needed
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Tutor Name
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor: Colors.orange, // Avatar color
//                               ),
//                               SizedBox(width: 8),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Tutor Name",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.grey),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16),
//
//                           // Tags
//                           Wrap(
//                             spacing: 8,
//                             children: List.generate(5, (index) {
//                               return Chip(
//                                 label: Text("Tag $index"),
//                                 backgroundColor: Colors.blue[50],
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 50, // Reduced height for bottom navigation bar
//         child: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.group),
//               label: "Groups",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ],
//           currentIndex: 0,
//           selectedItemColor: Colors.blue, // Highlighted color for selected item
//           unselectedItemColor: Colors.grey, // Default color for unselected items
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60), // Adjust the height of the app bar
//         child: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           centerTitle: false,
//           title: Row(
//             children: [
//               Image.asset(
//                 'assets/education_logo.png', // Replace with your logo
//                 height: 70,
//               ),
//               // SizedBox(width: 8),
//               // Text(
//               //   'EDUCATION',
//               //   style: TextStyle(
//               //     fontSize: 16,
//               //     color: Colors.black,
//               //     fontWeight: FontWeight.bold,
//               //   ),
//               // ),
//             ],
//           ),
//           actions: [
//             // Language Selector (Flag)
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Image.asset(
//                 'assets/us_flag.png', // Replace with your flag image
//                 height: 24,
//                 width: 24,
//               ),
//             ),
//             // Menu Icon
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Icon(
//                 Icons.menu,
//                 color: Colors.black,
//                 size: 28,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Upcoming Lesson Section
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Upcoming Lesson",
//                       style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.calendar_today, size: 16),
//                         SizedBox(width: 8),
//                         Text(
//                             "Sun 21 Jan 2024\n00:00 - 00:25 (starts in 3 hours)"),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     ElevatedButton.icon(
//                       onPressed: () {},
//                       icon: Icon(Icons.play_arrow),
//                       label: Text("Enter lesson room"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue, // Button color
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Total lesson time: 3 hours",
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 24),
//
//               // Search Bar and Filters
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Find a tutor",
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text("Filters"),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Colors.grey[200], // Button text color
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//
//               // Recommended Tutors Section
//               Text(
//                 "Recommended Tutors",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               ListView.builder(
//                 physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
//                 shrinkWrap: true, // Allow ListView to fit inside the parent
//                 itemCount: 3, // Adjust the number of cards if needed
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Tutor Name
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor: Colors.orange, // Avatar color
//                               ),
//                               SizedBox(width: 8),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Tutor Name",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.amber),
//                                       Icon(Icons.star, color: Colors.grey),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16),
//
//                           // Tags
//                           Wrap(
//                             spacing: 8,
//                             children: List.generate(5, (index) {
//                               return Chip(
//                                 label: Text("Tag $index"),
//                                 backgroundColor: Colors.blue[50],
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule),
//             label: "Schedule",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: "History",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu_book), // Changed icon to Courses
//             label: "Courses", // Changed label to Courses
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: "Settings",
//           ),
//         ],
//         currentIndex: 0,
//         selectedItemColor: Colors.blue, // Highlighted color for selected item
//         unselectedItemColor: Colors.grey, // Default color for unselected items
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // Track the selected language
//   Map<String, String> selectedLanguage = {
//     "name": "English",
//     "image": "assets/us_flag.png"
//   };
//
//   int _currentIndex = 0;
//   bool _isLanguageSelectorVisible = false;
//
//   final List<Map<String, String>> languages = [
//     {"name": "English", "image": "assets/us_flag.png"},
//     {"name": "Nepali", "image": "assets/np_flag.png"},
//     {"name": "Spain", "image": "assets/sp_flag.png"},
//   ];
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<Map<String, dynamic>> fetchUpcomingLesson() async {
//     await Future.delayed(Duration(seconds: 2));
//     bool hasLesson = false; // Change to true to simulate data
//     return hasLesson
//         ? {
//       "day": "Sun",
//       "date": "21 Jan 2024",
//       "time": "00:00 - 00:25 (starts in 3 hours)",
//       "totalLessonTime": "3 hours"
//     }
//         : {};
//   }
//
//   Future<List<Map<String, dynamic>>> fetchRecommendedTutors() async {
//     await Future.delayed(Duration(seconds: 2));
//     return []; // Change to simulate no tutors
//   }
//
//   void showFilterOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Filter Options",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Filter options can be added here for future upgrades."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // void showLanguageSelector() {
//   //   setState(() {
//   //     _isLanguageSelectorVisible = !_isLanguageSelectorVisible;
//   //   });
//   // }
//
//   void toggleLanguageSelector() {
//     setState(() {
//       _isLanguageSelectorVisible = !_isLanguageSelectorVisible;
//     });
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//       _isLanguageSelectorVisible = false; // Hide the dropdown menu
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     // return WillPopScope(
//
//
//       // onWillPop: () async {
//       //   final shouldExit = await showDialog<bool>(
//       //     context: context,
//       //     builder: (context) {
//       //       return AlertDialog(
//       //         title: Text("Exit App"),
//       //         content: Text("Are you sure you want to exit the app?"),
//       //         actions: [
//       //           TextButton(
//       //             onPressed: () => Navigator.of(context).pop(false), // Dismiss dialog
//       //             child: Text("Cancel"),
//       //           ),
//       //           TextButton(
//       //             onPressed: () {
//       //               SystemNavigator.pop(); // Exit the application
//       //             },
//       //             child: Text("Exit"),
//       //           ),
//       //         ],
//       //       );
//       //     },
//       //   );
//       //   return shouldExit ?? false;
//       // },
//
//       // onWillPop: () async {
//       //   // Show confirmation dialog
//       //   final shouldExit = await showDialog<bool>(
//       //     context: context,
//       //     builder: (context) {
//       //       return AlertDialog(
//       //         title: Text("Exit App"),
//       //         content: Text("Are you sure you want to exit the app?"),
//       //         actions: [
//       //           TextButton(
//       //             onPressed: () => Navigator.of(context).pop(false), // Dismiss dialog
//       //             child: Text("Cancel"),
//       //           ),
//       //           TextButton(
//       //             onPressed: () {
//       //               exit(0); // Completely exits the app
//       //             },
//       //             child: Text("Exit"),
//       //           ),
//       //         ],
//       //       );
//       //     },
//       //   );
//       //
//       //   // If user cancels the dialog, do not exit
//       //   return shouldExit ?? false;
//       // },
//
//     return WillPopScope(
//       onWillPop: () async {
//         // Show confirmation dialog
//         final shouldExit = await showDialog<bool>(
//           context: context,
//           barrierDismissible: false, // Prevent dialog from closing automatically
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Exit App"),
//               content: Text("Are you sure you want to exit the app?"),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false); // Dismiss dialog without exiting
//                   },
//                   child: Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true); // Close dialog and trigger exit
//                   },
//                   child: Text("Exit"),
//                 ),
//               ],
//             );
//           },
//         );
//
//         if (shouldExit ?? false) {
//           exit(0); // Fully exit the application
//         }
//
//         return shouldExit ?? false;
//       },
//
//          child: Scaffold(
//         key: _scaffoldKey,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Row(
//               children: [
//                 Image.asset(
//                   'assets/education_logo.png',
//                   height: 70,
//                 ),
//               ],
//             ),
//             actions: [
//               GestureDetector(
//                 onTap: toggleLanguageSelector, // Toggle dropdown visibility
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16.0),
//                   child: Image.asset(
//                     selectedLanguage['image']!, // Dynamically display the selected language icon
//                     height: 24,
//                     width: 24,
//                   ),
//                 ),
//               ),
//
//
//               IconButton(
//                 icon: Icon(Icons.menu, color: Colors.black, size: 28),
//                 onPressed: () {
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.schedule),
//                 title: Text("Schedule"),
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.history),
//                 title: Text("History"),
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 2;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.menu_book),
//                 title: Text("Courses"),
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 3;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 4;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Welcome to the platform!",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   FutureBuilder<Map<String, dynamic>>(
//                     future: fetchUpcomingLesson(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                         var lesson = snapshot.data!;
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Upcoming Lesson",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Icon(Icons.calendar_today, size: 16),
//                                   SizedBox(width: 8),
//                                   Text("${lesson['day']} ${lesson['date']}\n${lesson['time']}"),
//                                 ],
//                               ),
//                               SizedBox(height: 8),
//                               ElevatedButton.icon(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.play_arrow),
//                                 label: Text("Enter lesson room"),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 "Total lesson time: ${lesson['totalLessonTime']}",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.red[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             "No upcoming lessons.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: "Find a tutor",
//                             prefixIcon: Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: showFilterOptions,
//                         child: Text("Filters"),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.grey[200],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Recommended Tutors",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//                   FutureBuilder<List<Map<String, dynamic>>>(
//                     future: fetchRecommendedTutors(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                         return ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             var tutor = snapshot.data![index];
//                             return Card(
//                               margin: EdgeInsets.only(bottom: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 20,
//                                           backgroundColor: Colors.orange,
//                                         ),
//                                         SizedBox(width: 16),
//                                         Text(
//                                           tutor['name'] ?? "Unknown Tutor",
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       tutor['subject'] ?? "Subject not provided",
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Text("No recommended tutors available.");
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             // if (_isLanguageSelectorVisible)
//             //   Positioned(
//             //     top: 60,
//             //     right: 16,
//             //     child: Material(
//             //       elevation: 4,
//             //       borderRadius: BorderRadius.circular(8),
//             //       child: Column(
//             //         children: languages.map((language) {
//             //           return GestureDetector(
//             //             onTap: () {
//             //               setState(() {
//             //                 // Change the language or set an action
//             //               });
//             //             },
//             //             child: Container(
//             //               padding: EdgeInsets.all(8),
//             //               child: Row(
//             //                 children: [
//             //                   Image.asset(language['image']!,
//             //                       width: 24, height: 24),
//             //                   SizedBox(width: 8),
//             //                   Text(language['name']!),
//             //                 ],
//             //               ),
//             //             ),
//             //           );
//             //         }).toList(),
//             //       ),
//             //     ),
//             //   ),
//             if (_isLanguageSelectorVisible)
//               Positioned(
//                 top: 0, // Adjusted position upwards
//                 right: 30,
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(8),
//                   child: Column(
//                     children: languages.map((language) {
//                       return GestureDetector(
//                         onTap: () => selectLanguage(language), // Call selectLanguage
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 language['image']!,
//                                 width: 24,
//                                 height: 24,
//                               ),
//                               SizedBox(width: 8),
//                               Text(language['name']!),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//
//
//           ],
//
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               label: "Courses",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ],
//           currentIndex: _currentIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 12),
//           iconSize: 24,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
//

//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
// import 'package:tutor_nest/main.dart';
// import 'package:tutor_nest/pages/schedule_page_content.dart';
//
// // void main() {
// //   runApp(MyApp());
// // }
//
//
//
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // Track the selected language
//   Map<String, String> selectedLanguage = {
//     "name": "English",
//     "image": "assets/us_flag.png"
//   };
//
//   int _currentIndex = 0;
//   bool _isLanguageSelectorVisible = false;
//
//   final List<Map<String, String>> languages = [
//     {"name": "English", "image": "assets/us_flag.png"},
//     {"name": "Nepali", "image": "assets/np_flag.png"},
//     {"name": "Spain", "image": "assets/sp_flag.png"},
//   ];
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Dummy upcoming lesson data
//   Future<Map<String, dynamic>> fetchUpcomingLesson() async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate delay
//     return {
//       "day": "Sun",
//       "date": "21 Jan 2024",
//       "time": "00:00 - 00:25 (starts in 3 hours)",
//       "totalLessonTime": "3 hours"
//     };
//   }
//
//   // Dummy recommended tutors data
//   Future<List<Map<String, dynamic>>> fetchRecommendedTutors() async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate delay
//     return [
//       {
//         "name": "John Doe",
//         "subject": "Mathematics",
//         "rating": 4.8,
//         "profilePicture": "assets/user_placeholder.png"
//       },
//       {
//         "name": "Jane Smith",
//         "subject": "Physics",
//         "rating": 4.6,
//         "profilePicture": "assets/user_placeholder.png"
//       },
//       {
//         "name": "Mike Johnson",
//         "subject": "English Literature",
//         "rating": 4.5,
//         "profilePicture": "assets/user_placeholder.png"
//       },
//       {
//         "name": "Mike Johnson",
//         "subject": "English Literature",
//         "rating": 4.5,
//         "profilePicture": "assets/user_placeholder.png"
//       },
//     ];
//   }
//
//   void showFilterOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Filter Options",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Filter options can be added here for future upgrades."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // void showLanguageSelector() {
//   //   setState(() {
//   //     _isLanguageSelectorVisible = !_isLanguageSelectorVisible;
//   //   });
//   // }
//
//   void toggleLanguageSelector() {
//     setState(() {
//       _isLanguageSelectorVisible = !_isLanguageSelectorVisible;
//     });
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//       _isLanguageSelectorVisible = false; // Hide the dropdown menu
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return WillPopScope(
//       onWillPop: () async {
//         // Show confirmation dialog
//         final shouldExit = await showDialog<bool>(
//           context: context,
//           barrierDismissible: false, // Prevent dialog from closing automatically
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Exit App"),
//               content: Text("Are you sure you want to exit the app?"),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(false); // Dismiss dialog without exiting
//                   },
//                   child: Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(true); // Close dialog and trigger exit
//                   },
//                   child: Text("Exit"),
//                 ),
//               ],
//             );
//           },
//         );
//
//         if (shouldExit ?? false) {
//           exit(0); // Fully exit the application
//         }
//
//         return shouldExit ?? false;
//       },
//
//          child: Scaffold(
//         key: _scaffoldKey,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Row(
//               children: [
//                 Image.asset(
//                   'assets/education_logo.png',
//                   height: 70,
//                 ),
//               ],
//             ),
//             actions: [
//               GestureDetector(
//                 onTap: toggleLanguageSelector, // Toggle dropdown visibility
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16.0),
//                   child: Image.asset(
//                     selectedLanguage['image']!, // Dynamically display the selected language icon
//                     height: 24,
//                     width: 24,
//                   ),
//                 ),
//               ),
//
//
//               IconButton(
//                 icon: Icon(Icons.menu, color: Colors.black, size: 28),
//                 onPressed: () {
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 selected: _currentIndex == 0, // Highlight if _currentIndex is 0
//                 selectedTileColor: Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               // ListTile(
//               //   leading: Icon(Icons.schedule),
//               //   title: Text("Schedule"),
//               //   onTap: () {
//               //     setState(() {
//               //       _currentIndex = 1;
//               //     });
//               //     Navigator.pop(context);
//               //   },
//                ListTile(
//                  leading: Icon(Icons.schedule),
//                  title: Text("Schedule"),
//                  selected: _currentIndex == 1, // Highlight if _currentIndex is 1
//                  selectedTileColor: Colors.blue[100], // Background color when selected
//                  onTap: () {
//                    setState(() {
//                      _currentIndex = 1;
//                    });
//                    Navigator.pop(context); // Close the drawer first
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => SchedulePage()),
//                    );
//                  },
//                ),
//
//
//
//               ListTile(
//                 leading: Icon(Icons.history),
//                 title: Text("History"),
//                 selected: _currentIndex == 2, // Highlight if _currentIndex is 2
//                 selectedTileColor: Colors.blue[100], // Background color when selected // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 2;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.menu_book),
//                 title: Text("Courses"),
//                 selected: _currentIndex == 3, // Highlight if _currentIndex is 3
//                 selectedTileColor: Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 3;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 selected: _currentIndex == 4, // Highlight if _currentIndex is 4
//                 selectedTileColor: Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 4;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Welcome to the platform!",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   FutureBuilder<Map<String, dynamic>>(
//                     future: fetchUpcomingLesson(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                         var lesson = snapshot.data!;
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Upcoming Lesson",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Icon(Icons.calendar_today, size: 16),
//                                   SizedBox(width: 8),
//                                   Text("${lesson['day']} ${lesson['date']}\n${lesson['time']}"),
//                                 ],
//                               ),
//                               SizedBox(height: 8),
//                               ElevatedButton.icon(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.play_arrow),
//                                 label: Text("Enter lesson room"),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 "Total lesson time: ${lesson['totalLessonTime']}",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.red[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             "No upcoming lessons.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: "Find a tutor",
//                             prefixIcon: Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: showFilterOptions,
//                         child: Text("Filters"),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.grey[200],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Recommended Tutors",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//                   FutureBuilder<List<Map<String, dynamic>>>(
//                     future: fetchRecommendedTutors(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                         return ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             var tutor = snapshot.data![index];
//                             return Card(
//                               margin: EdgeInsets.only(bottom: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 20,
//                                           backgroundColor: Colors.orange,
//                                         ),
//                                         SizedBox(width: 16),
//                                         Text(
//                                           tutor['name'] ?? "Unknown Tutor",
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       tutor['subject'] ?? "Subject not provided",
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Text("No recommended tutors available.");
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             if (_isLanguageSelectorVisible)
//               Positioned(
//                 top: 0, // Adjusted position upwards
//                 right: 30,
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(8),
//                   child: Column(
//                     children: languages.map((language) {
//                       return GestureDetector(
//                         onTap: () => selectLanguage(language), // Call selectLanguage
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 language['image']!,
//                                 width: 24,
//                                 height: 24,
//                               ),
//                               SizedBox(width: 8),
//                               Text(language['name']!),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//
//
//           ],
//
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               label: "Courses",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ],
//           currentIndex: _currentIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 12),
//           iconSize: 24,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//             if (index == 0) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage()),
//               );
//             } else if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SchedulePage()),
//               );
//             }
//             // else if (index == 2) {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => HistoryPage()),
//             //   );
//             // } else if (index == 3) {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => CoursesPage()),
//             //   );
//             // } else if (index == 4) {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => SettingsPage()),
//             //   );
//             // }
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:tutor_nest/pages/schedule_page_content.dart';
//
// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// // Entry point of the app
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Tutor Nest',
//         home: HomePage(),
//         debugShowCheckedModeBanner: false);
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // Track the selected language
//   Map<String, String> selectedLanguage = {
//     "name": "English",
//     "image": "assets/us_flag.png"
//   };
//
//   int _currentIndex = 0;
//   bool _isLanguageSelectorVisible = false;
//
//   final List<Map<String, String>> languages = [
//     {"name": "English", "image": "assets/us_flag.png"},
//     {"name": "Nepali", "image": "assets/np_flag.png"},
//     {"name": "Spain", "image": "assets/sp_flag.png"},
//   ];
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Dummy upcoming lesson data
//   Future<Map<String, dynamic>> fetchUpcomingLesson() async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate delay
//     return {
//       "day": "Sun",
//       "date": "21 Jan 2024",
//       "time": "00:00 - 00:25 (starts in 3 hours)",
//       "totalLessonTime": "3 hours"
//     };
//   }
//
//   // Fetch recommended tutors from Firebase Firestore (Commented out for now)
//   // Future<List<Map<String, dynamic>>> fetchRecommendedTutors() async {
//   //   // Fetch data from Firestore
//   //   QuerySnapshot snapshot =
//   //       await FirebaseFirestore.instance.collection('tutors').get();
//
//   //   // Map the fetched documents to a list of maps
//   //   return snapshot.docs.map((doc) {
//   //     return {
//   //       "name": doc['name'] ?? "Unknown Tutor",
//   //       "subject": doc['subject'] ?? "Subject not provided",
//   //       "rating": doc['rating'] ?? 0.0,
//   //       "profilePicture": doc['profilePicture'] ?? "",
//   //     };
//   //   }).toList();
//   // }
//
//   // Dummy recommended tutors data
//   Future<List<Map<String, dynamic>>> fetchRecommendedTutors() async {
//     // Simulate delay
//     await Future.delayed(Duration(seconds: 2));
//     // Dummy data with image URLs from Firebase Storage
//     return [
//       {
//         "name": "John Doe",
//         "subject": "Mathematics",
//         "rating": 4.8,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Fjohn_doe.jpg?alt=media",
//       },
//       {
//         "name": "Jane Smith",
//         "subject": "Physics",
//         "rating": 4.6,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Fjane_smith.jpg?alt=media",
//       },
//       {
//         "name": "Mike Johnson",
//         "subject": "English Literature",
//         "rating": 4.5,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Fmike_johnson.jpg?alt=media",
//       },
//       {
//         "name": "Emily Davis",
//         "subject": "Biology",
//         "rating": 4.7,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Femily_davis.jpg?alt=media",
//       },
//     ];
//   }
//
//   void showFilterOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Filter Options",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Filter options can be added here for future upgrades."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void toggleLanguageSelector() {
//     setState(() {
//       _isLanguageSelectorVisible = !_isLanguageSelectorVisible;
//     });
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//       _isLanguageSelectorVisible = false; // Hide the dropdown menu
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Show confirmation dialog
//         final shouldExit = await showDialog<bool>(
//           context: context,
//           barrierDismissible: false, // Prevent dialog from closing automatically
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Exit App"),
//               content: Text("Are you sure you want to exit the app?"),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pop(false); // Dismiss dialog without exiting
//                   },
//                   child: Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pop(true); // Close dialog and trigger exit
//                   },
//                   child: Text("Exit"),
//                 ),
//               ],
//             );
//           },
//         );
//
//         if (shouldExit ?? false) {
//           exit(0); // Fully exit the application
//         }
//
//         return shouldExit ?? false;
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Row(
//               children: [
//                 Image.asset(
//                   'assets/education_logo.png',
//                   height: 70,
//                 ),
//               ],
//             ),
//             actions: [
//               GestureDetector(
//                 onTap: toggleLanguageSelector, // Toggle dropdown visibility
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16.0),
//                   child: Image.asset(
//                     selectedLanguage[
//                     'image']!, // Dynamically display the selected language icon
//                     height: 24,
//                     width: 24,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.menu, color: Colors.black, size: 28),
//                 onPressed: () {
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 selected: _currentIndex == 0, // Highlight if _currentIndex is 0
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.schedule),
//                 title: Text("Schedule"),
//                 selected: _currentIndex == 1, // Highlight if _currentIndex is 1
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                   Navigator.pop(context); // Close the drawer first
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SchedulePage()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.history),
//                 title: Text("History"),
//                 selected: _currentIndex == 2, // Highlight if _currentIndex is 2
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 2;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.menu_book),
//                 title: Text("Courses"),
//                 selected: _currentIndex == 3, // Highlight if _currentIndex is 3
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 3;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 selected: _currentIndex == 4, // Highlight if _currentIndex is 4
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 4;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Welcome to the platform!",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 16),
//                   FutureBuilder<Map<String, dynamic>>(
//                     future: fetchUpcomingLesson(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasData &&
//                           snapshot.data!.isNotEmpty) {
//                         var lesson = snapshot.data!;
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Upcoming Lesson",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),
//                               ),
//                               SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Icon(Icons.calendar_today, size: 16),
//                                   SizedBox(width: 8),
//                                   Text(
//                                       "${lesson['day']} ${lesson['date']}\n${lesson['time']}"),
//                                 ],
//                               ),
//                               SizedBox(height: 8),
//                               ElevatedButton.icon(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.play_arrow),
//                                 label: Text("Enter lesson room"),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.blue,
//                                 ),
//                               ),
//                               SizedBox(height: 8),
//                               Text(
//                                 "Total lesson time: ${lesson['totalLessonTime']}",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.red[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             "No upcoming lessons.",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: "Find a tutor",
//                             prefixIcon: Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       ElevatedButton(
//                         onPressed: showFilterOptions,
//                         child: Text("Filters"),
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.grey[200],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Recommended Tutors",
//                     style:
//                     TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//                   FutureBuilder<List<Map<String, dynamic>>>(
//                     future: fetchRecommendedTutors(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasData &&
//                           snapshot.data!.isNotEmpty) {
//                         return ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             var tutor = snapshot.data![index];
//                             return Card(
//                               margin: EdgeInsets.only(bottom: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 20,
//                                           backgroundImage: NetworkImage(
//                                               tutor['profilePicture']),
//                                           backgroundColor: Colors.grey,
//                                           child: tutor['profilePicture'] ==
//                                               ""
//                                               ? Icon(
//                                             Icons.person,
//                                             color: Colors.white,
//                                           )
//                                               : null,
//                                         ),
//                                         SizedBox(width: 16),
//                                         Text(
//                                           tutor['name'] ?? "Unknown Tutor",
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       tutor['subject'] ??
//                                           "Subject not provided",
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Text(
//                             "No recommended tutors available.");
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             if (_isLanguageSelectorVisible)
//               Positioned(
//                 top: 0,
//                 right: 30,
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(8),
//                   child: Column(
//                     children: languages.map((language) {
//                       return GestureDetector(
//                         onTap: () => selectLanguage(
//                             language), // Call selectLanguage
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 language['image']!,
//                                 width: 24,
//                                 height: 24,
//                               ),
//                               SizedBox(width: 8),
//                               Text(language['name']!),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               label: "Courses",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ],
//           currentIndex: _currentIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle:
//           TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 12),
//           iconSize: 24,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//             if (index == 0) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage()),
//               );
//             } else if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SchedulePage()),
//               );
//             }
//             // Additional navigation can be added here
//           },
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tutor_nest/pages/courses_page_content.dart';
// import 'package:tutor_nest/pages/history_page_content.dart';
// import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:tutor_nest/pages/schedule_page_content.dart';
//
// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// // Entry point of the app
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Tutor Nest',
//         home: HomePageContent(),
//         debugShowCheckedModeBanner: false);
//   }
// }
//
// class HomePageContent extends StatefulWidget {
//   @override
//   _HomePageContentState createState() => _HomePageContentState();
// }
//
// class _HomePageContentState extends State<HomePageContent> {
//   // Track the selected language
//   Map<String, String> selectedLanguage = {
//     "name": "English",
//     "image": "assets/us_flag.png"
//   };
//
//   int _currentIndex = 0;
//   // Removed _isLanguageSelectorVisible as it's no longer needed
//   // bool _isLanguageSelectorVisible = false;
//
//   final List<Map<String, String>> languages = [
//     {"name": "English", "image": "assets/us_flag.png"},
//     {"name": "Nepali", "image": "assets/np_flag.png"},
//     {"name": "Spain", "image": "assets/sp_flag.png"},
//   ];
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Dummy upcoming lesson data
//   Future<Map<String, dynamic>> fetchUpcomingLesson() async {
//     await Future.delayed(Duration(seconds: 2)); // Simulate delay
//     return {
//       "day": "Sun",
//       "date": "21 Jan 2024",
//       "time": "00:00 - 00:25 (starts in 3 hours)",
//       "totalLessonTime": "3 hours"
//     };
//   }
//
//   // Dummy recommended tutors data
//   Future<List<Map<String, dynamic>>> fetchRecommendedTutors() async {
//     // Simulate delay
//     await Future.delayed(Duration(seconds: 2));
//     // Dummy data with image URLs from Firebase Storage
//     return [
//       {
//         "name": "John Doe",
//         "subject": "Mathematics",
//         "rating": 4.8,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Fjohn_doe.jpg?alt=media",
//       },
//       {
//         "name": "Jane Smith",
//         "subject": "Physics",
//         "rating": 4.6,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Fjane_smith.jpg?alt=media",
//       },
//       {
//         "name": "Mike Johnson",
//         "subject": "English Literature",
//         "rating": 4.5,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Fmike_johnson.jpg?alt=media",
//       },
//       {
//         "name": "Emily Davis",
//         "subject": "Biology",
//         "rating": 4.7,
//         "profilePicture":
//         "https://firebasestorage.googleapis.com/v0/b/your-project-id.appspot.com/o/profile_pictures%2Femily_davis.jpg?alt=media",
//       },
//     ];
//   }
//
//   void showFilterOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Filter Options",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Filter options can be added here for future upgrades."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   // Removed toggleLanguageSelector as it's no longer needed
//   // void toggleLanguageSelector() {
//   //   setState(() {
//   //     _isLanguageSelectorVisible = !_isLanguageSelectorVisible;
//   //   });
//   // }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//       // No need to hide the dropdown menu manually
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Show confirmation dialog
//         final shouldExit = await showDialog<bool>(
//           context: context,
//           barrierDismissible: false, // Prevent dialog from closing automatically
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Exit App"),
//               content: Text("Are you sure you want to exit the app?"),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pop(false); // Dismiss dialog without exiting
//                   },
//                   child: Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pop(true); // Close dialog and trigger exit
//                   },
//                   child: Text("Exit"),
//                 ),
//               ],
//             );
//           },
//         );
//
//         if (shouldExit ?? false) {
//           exit(0); // Fully exit the application
//         }
//
//         return shouldExit ?? false;
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Row(
//               children: [
//                 Image.asset(
//                   'assets/education_logo.png',
//                   height: 70,
//                 ),
//               ],
//             ),
//             actions: [
//               // Replaced GestureDetector with PopupMenuButton
//               PopupMenuButton<Map<String, String>>(
//                 icon: Image.asset(
//                   selectedLanguage['image']!,
//                   height: 24,
//                   width: 24,
//                 ),
//                 onSelected: (Map<String, String> language) {
//                   selectLanguage(language);
//                 },
//                 itemBuilder: (BuildContext context) {
//                   return languages.map((language) {
//                     return PopupMenuItem<Map<String, String>>(
//                       value: language,
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             language['image']!,
//                             width: 24,
//                             height: 24,
//                           ),
//                           SizedBox(width: 8),
//                           Text(language['name']!),
//                         ],
//                       ),
//                     );
//                   }).toList();
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.menu, color: Colors.black, size: 28),
//                 onPressed: () {
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 selected: _currentIndex == 0, // Highlight if _currentIndex is 0
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.schedule),
//                 title: Text("Schedule"),
//                 selected: _currentIndex == 1, // Highlight if _currentIndex is 1
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                   Navigator.pop(context); // Close the drawer first
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SchedulePageContent()),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.history),
//                 title: Text("History"),
//                 selected: _currentIndex == 2, // Highlight if _currentIndex is 2
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 2;
//                   });
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => HistoryPageContent()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.menu_book),
//                 title: Text("Courses"),
//                 selected: _currentIndex == 3, // Highlight if _currentIndex is 3
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 3;
//                   });
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => CoursesPageContent()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 selected: _currentIndex == 4, // Highlight if _currentIndex is 4
//                 selectedTileColor:
//                 Colors.blue[100], // Background color when selected
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 4;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                 },
//               ),
//             ],
//           ),
//         ),
//         // Removed Stack and _isLanguageSelectorVisible logic
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Welcome to the platform!",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               FutureBuilder<Map<String, dynamic>>(
//                 future: fetchUpcomingLesson(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                     var lesson = snapshot.data!;
//                     return Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.blue[100],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Upcoming Lesson",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           SizedBox(height: 8),
//                           Row(
//                             children: [
//                               Icon(Icons.calendar_today, size: 16),
//                               SizedBox(width: 8),
//                               Text(
//                                   "${lesson['day']} ${lesson['date']}\n${lesson['time']}"),
//                             ],
//                           ),
//                           SizedBox(height: 8),
//                           ElevatedButton.icon(
//                             onPressed: () {},
//                             icon: Icon(Icons.play_arrow),
//                             label: Text("Enter lesson room"),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             "Total lesson time: ${lesson['totalLessonTime']}",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.red[100],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         "No upcoming lessons.",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                     );
//                   }
//                 },
//               ),
//               SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Find a tutor",
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: showFilterOptions,
//                     child: Text("Filters"),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Colors.grey[200],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Text(
//                 "Recommended Tutors",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               FutureBuilder<List<Map<String, dynamic>>>(
//                 future: fetchRecommendedTutors(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                     return ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         var tutor = snapshot.data![index];
//                         return Card(
//                           margin: EdgeInsets.only(bottom: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 20,
//                                       backgroundImage: NetworkImage(
//                                           tutor['profilePicture']),
//                                       backgroundColor: Colors.grey,
//                                       child: tutor['profilePicture'] == ""
//                                           ? Icon(
//                                         Icons.person,
//                                         color: Colors.white,
//                                       )
//                                           : null,
//                                     ),
//                                     SizedBox(width: 16),
//                                     Text(
//                                       tutor['name'] ?? "Unknown Tutor",
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   tutor['subject'] ?? "Subject not provided",
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return Text("No recommended tutors available.");
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               label: "Courses",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ],
//           currentIndex: _currentIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle:
//           TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 12),
//           iconSize: 24,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//             if (index == 0) {
//               // Avoid pushing the same page onto the stack
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => HomePage()),
//               // );
//             } else if (index == 1) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SchedulePageContent()),
//               );
//             }else if (index == 2) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HistoryPageContent()),
//               );
//             }else if (index == 2) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HistoryPageContent()),);
//             }else if (index == 3) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CoursesPageContent()),
//               );
//             }
//
//             // Additional navigation can be added here
//           },
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import '../services/home_service.dart'; // Import the service
//
// class HomePageContent extends StatefulWidget {
//   @override
//   _HomePageContentState createState() => _HomePageContentState();
// }
//
// class _HomePageContentState extends State<HomePageContent> {
//   final HomeService _homeService = HomeService(); // Instantiate the service
//
//   void showFilterOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Filter Options",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Filter options can be added here for future upgrades."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Note: Removed the Scaffold, AppBar, Drawer, and BottomNavigationBar
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Welcome to the platform!",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           FutureBuilder<Map<String, dynamic>>(
//             future: _homeService.fetchUpcomingLesson(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 var lesson = snapshot.data!;
//                 return Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.blue[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Upcoming Lesson",
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(Icons.calendar_today, size: 16),
//                           SizedBox(width: 8),
//                           Text(
//                               "${lesson['day']} ${lesson['date']}\n${lesson['time']}"),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.play_arrow),
//                         label: Text("Enter lesson room"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Total lesson time: ${lesson['totalLessonTime']}",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 return Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.red[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     "No upcoming lessons.",
//                     style:
//                     TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 );
//               }
//             },
//           ),
//           SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Find a tutor",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: showFilterOptions,
//                 child: Text("Filters"),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.grey[200],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Text(
//             "Recommended Tutors",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(height: 16),
//           FutureBuilder<List<Map<String, dynamic>>>(
//             future: _homeService.fetchRecommendedTutors(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 return ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     var tutor = snapshot.data![index];
//                     return Card(
//                       margin: EdgeInsets.only(bottom: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundImage:
//                                   NetworkImage(tutor['profilePicture']),
//                                   backgroundColor: Colors.grey,
//                                   child: tutor['profilePicture'] == ""
//                                       ? Icon(
//                                     Icons.person,
//                                     color: Colors.white,
//                                   )
//                                       : null,
//                                 ),
//                                 SizedBox(width: 16),
//                                 Text(
//                                   tutor['name'] ?? "Unknown Tutor",
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               tutor['subject'] ?? "Subject not provided",
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return Text("No recommended tutors available.");
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../services/home_service.dart'; // Import the service
// import '../widgets/upcoming_lesson_card.dart'; // Import the UpcomingLessonCard
// import '../widgets/tutor_card.dart'; // Import the TutorCard
//
// class HomePageContent extends StatefulWidget {
//   @override
//   _HomePageContentState createState() => _HomePageContentState();
// }
//
// class _HomePageContentState extends State<HomePageContent> {
//   final HomeService _homeService = HomeService(); // Instantiate the service
//
//   void showFilterOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Filter Options",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text("Filter options can be added here for future upgrades."),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Note: Removed the Scaffold, AppBar, Drawer, and BottomNavigationBar
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Welcome to the platform!",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 16),
//           FutureBuilder<Map<String, dynamic>>(
//             future: _homeService.fetchUpcomingLesson(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 var lesson = snapshot.data!;
//                 return UpcomingLessonCard(lesson: lesson); // Use the widget
//               } else {
//                 return Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.red[100],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     "No upcoming lessons.",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 );
//               }
//             },
//           ),
//           SizedBox(height: 24),
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: "Find a tutor",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: showFilterOptions,
//                 child: Text("Filters"),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.grey[200],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           Text(
//             "Recommended Tutors",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(height: 16),
//           FutureBuilder<List<Map<String, dynamic>>>(
//             future: _homeService.fetchRecommendedTutors(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                 return ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     var tutor = snapshot.data![index];
//                     return TutorCard(tutor: tutor); // Use the widget
//                   },
//                 );
//               } else {
//                 return Text("No recommended tutors available.");
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/pages/home_page_content.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:tutornest/models/tutorModel.dart';
import 'package:tutornest/pages/Student/tutor_details_content.dart';
import '../../services/home_service.dart'; // Import the service
import '../../widgets/upcoming_lesson_card.dart'; // Import the UpcomingLessonCard
import '../../widgets/tutor_card.dart'; // Import the TutorCard
import '../../models/tutor_item.dart';
import '../../models/upcoming_lesson_item.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final HomeService _homeService = HomeService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  List<Tutor> _allTutors = [];
  List<Tutor> _filteredTutors = [];
  bool _isLoading = true;
  String _searchQuery = '';

  Future<List<Tutor>> _fetchTutors() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('tutors').get();

      return snapshot.docs.map((doc) => Tutor.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load tutors: $e');
    }
  }


  Future<void> _initializeTutors() async {
    try {
      final tutors = await _fetchTutors();
      setState(() {
        _allTutors = tutors;
        _filteredTutors = tutors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error initializing tutors: $e');
    }
  }

  void _filterTutors(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredTutors = _allTutors;
      } else {
        _filteredTutors = _allTutors.where((tutor) {
          final nameMatch = tutor.username?.toLowerCase().contains(_searchQuery) ?? false;
          final specialtiesMatch = tutor.specialties.any(
                  (specialty) => specialty.toLowerCase().contains(_searchQuery)
          );
          return nameMatch || specialtiesMatch;
        }).toList();
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _initializeTutors();
  }


  void showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("Filter options can be added here for future upgrades."),
              // Add more filter options as needed
            ],
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchBookings() async {
    final storage = FlutterSecureStorage();
    final studentId = await storage.read(key: 'userId');
    print('Student ID: $studentId');

    if (studentId == null) {
      print('No Student ID found');
      return [];
    }

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('student_id', isEqualTo: studentId)
          .where('start_time',isGreaterThan: Timestamp.now()).orderBy('start_time',descending: false)
          .get();

      print('Fetched ${querySnapshot.docs.length} bookings');
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching bookings: $e');
      throw e;
    }
  }


  String _formatDateTime(DateTime dateTime) {
    final date = DateFormat('MMMM d, yyyy').format(dateTime);
    final time = DateFormat('h:mm a').format(dateTime);
    final day = DateFormat('EEEE').format(dateTime);
    return '$day $date\n$time';
  }

  String _calculateDuration(DateTime startTime, DateTime endTime) {
    final duration = endTime.difference(startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  @override

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to the platform!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchBookings(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(child: Text('Error loading bookings: ${snapshot.error}'));
              }

              final bookings = snapshot.data ?? [];
              final containerHeight = bookings.isEmpty ? 0.0 : 200.0;

              return Container(
                height: containerHeight,
                child: bookings.isEmpty
                    ? Center() // Empty container for no bookings
                    : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    final startTime = (booking['start_time'] as Timestamp).toDate();
                    final endTime = (booking['end_time'] as Timestamp).toDate();

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(_formatDateTime(startTime)),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/livestreamstudent');
                              },
                              icon: Icon(Icons.play_arrow),
                              label: Text("Enter lesson room"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Total lesson time: ${_calculateDuration(startTime, endTime)}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child:
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Find a tutor by name or subject",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add a clear button when there's text
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _filterTutors('');
                      },
                    )
                        : null,
                  ),
                  onChanged: _filterTutors,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? "Recommended Tutors"
                : "Search Results (${_filteredTutors.length})",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 16),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_filteredTutors.isEmpty)
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _searchQuery.isEmpty
                      ? "No recommended tutors available."
                      : "No tutors found matching '$_searchQuery'",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            )
          else
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _filteredTutors.length,
              itemBuilder: (context, index) {
                var tutor = _filteredTutors[index];
                return TutorCard(
                  tutor: TutorItem(
                    id: tutor.tutorId,
                    name: tutor.username ?? 'Unknown Tutor',
                    subjects: tutor.specialties,
                    rating: 4.5, // You might want to fetch this from Firestore
                    profilePicture: tutor.photo ?? 'https://example.com/default_profile.jpg',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TutorDetailsPage(tutorId: tutor.tutorId),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

  // Widget build(BuildContext context) {
  //   // Note: Removed the Scaffold, AppBar, Drawer, and BottomNavigationBar
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Welcome to the platform!",
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 16),
  //         FutureBuilder<UpcomingLessonItem>(
  //           future: _homeService.fetchUpcomingLesson(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Center(child: CircularProgressIndicator());
  //             } else if (snapshot.hasData && snapshot.data!.id.isNotEmpty) {
  //               var lesson = snapshot.data!;
  //               return UpcomingLessonCard(lesson: lesson); // Use the widget
  //             } else {
  //               return Container(
  //                 padding: EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: Colors.red[100],
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Text(
  //                   "No upcoming lessons.",
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //                 ),
  //               );
  //             }
  //           },
  //         ),
  //         SizedBox(height: 24),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   hintText: "Find a tutor",
  //                   prefixIcon: Icon(Icons.search),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 onSubmitted: (value) {
  //                   // Handle search functionality
  //                 },
  //               ),
  //             ),
  //             SizedBox(width: 8),
  //             ElevatedButton(
  //               onPressed: showFilterOptions,
  //               child: Text("Filters"),
  //               style: ElevatedButton.styleFrom(
  //                 foregroundColor: Colors.black,
  //                 backgroundColor: Colors.grey[200],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Text(
  //           "Recommended Tutors",
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //         ),
  //         SizedBox(height: 16),
  //         FutureBuilder<List<Tutor>>(
  //           future: getAllTutors(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Center(child: CircularProgressIndicator());
  //             } else if (snapshot.hasError) {
  //               return Center(
  //                 child: Text(
  //                   'Failed to load tutors: ${snapshot.error}',
  //                   style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //                 ),
  //               );
  //             } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
  //               return ListView.builder(
  //                 physics: NeverScrollableScrollPhysics(),
  //                 shrinkWrap: true,
  //                 itemCount: snapshot.data!.length,
  //                 itemBuilder: (context, index) {
  //                   var tutor = snapshot.data![index];
  //                   return TutorCard(
  //                     tutor: tutor,
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => TutorDetailsPage(tutor: tutor),
  //                         ),
  //                       );
  //                     },
  //                   );
  //                 },
  //               );
  //             } else {
  //               return Center(
  //                 child: Container(
  //                   padding: EdgeInsets.all(16),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[200],
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Text(
  //                     "No recommended tutors available.",
  //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //                   ),
  //                 ),
  //               );
  //             }
  //           },
  //         )
  //
  //
  //       ],
  //     ),
  //   );
  // }
