// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(LessonReportApp());
// }
//
// class LessonReportApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LessonReportPage(),
//     );
//   }
// }
//
// class LessonReportPage extends StatefulWidget {
//   @override
//   _LessonReportPageState createState() => _LessonReportPageState();
// }
//
// class _LessonReportPageState extends State<LessonReportPage> {
//   // Static data for the cards (dynamic for now, can be replaced with API later)
//   int completedLessons = 5; // Static value for "Completed"
//   int studentAbsent = 3; // Static value for "Student Absent"
//   int tutorAbsent = 2; // Static value for "Tutor Absent"
//
//   String selectedMonth = "Current Month"; // Default selection
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Lessons Report",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.blue),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.blue,
//                     child: Icon(Icons.phone, color: Colors.white, size: 30),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "The following is a report of lessons by status for the current or last month. You can see the details of the lessons you have learned.",
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                       maxLines: 3,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Horizontal Scrollable Cards
//               SizedBox(
//                 height: 120, // Adjusted height for mobile screens
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     buildStatusCard("Completed", completedLessons.toString(), Colors.green),
//                     buildStatusCard("Student Absent", studentAbsent.toString(), Colors.orange),
//                     buildStatusCard("Tutor Absent", tutorAbsent.toString(), Colors.purple),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Total Lessons Learned and Month Toggle
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Total lessons learned: ${completedLessons + studentAbsent + tutorAbsent}",
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Row(
//                     children: [
//                       // Last Month Button
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedMonth = "Last Month";
//                             // Example: Update static data (can be fetched from API later)
//                             completedLessons = 3;
//                             studentAbsent = 2;
//                             tutorAbsent = 1;
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: selectedMonth == "Last Month"
//                               ? Colors.white
//                               : Colors.black, backgroundColor: selectedMonth == "Last Month"
//                               ? Colors.blue
//                               : Colors.grey[300],
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                         ),
//                         child: const Text(
//                           "Last Month",
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       // Current Month Button
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedMonth = "Current Month";
//                             // Example: Update static data (can be fetched from API later)
//                             completedLessons = 5;
//                             studentAbsent = 3;
//                             tutorAbsent = 2;
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: selectedMonth == "Current Month"
//                               ? Colors.white
//                               : Colors.black, backgroundColor: selectedMonth == "Current Month"
//                               ? Colors.blue
//                               : Colors.grey[300],
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 5),
//                         ),
//                         child: const Text(
//                           "Current Month",
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Empty Data Placeholder
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.insert_drive_file,
//                         size: 60, color: Colors.grey),
//                     SizedBox(height: 10),
//                     Text(
//                       "Empty data",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Method to Build Status Card
//   Widget buildStatusCard(String title, String value, Color color) {
//     return Container(
//       width: 150, // Width adjusted for mobile-friendly horizontal scrolling
//       margin: const EdgeInsets.only(right: 16),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: const TextStyle(
//                 color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(LessonReportApp());
// }
//
// class LessonReportApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LessonReportPage(),
//     );
//   }
// }
//
// class LessonReportPage extends StatefulWidget {
//   @override
//   _LessonReportPageState createState() => _LessonReportPageState();
// }
//
// class _LessonReportPageState extends State<LessonReportPage> {
//   // Data for different months
//   final Map<String, Map<String, int>> monthlyData = {
//     "Current Month": {
//       "Completed": 5,
//       "Student Absent": 3,
//       "Tutor Absent": 2,
//     },
//     "Last Month": {
//       "Completed": 7,
//       "Student Absent": 1,
//       "Tutor Absent": 1,
//     },
//   };
//
//   String selectedMonth = "Current Month"; // Default selection
//
//   int get completedLessons => monthlyData[selectedMonth]!["Completed"]!;
//   int get studentAbsent => monthlyData[selectedMonth]!["Student Absent"]!;
//   int get tutorAbsent => monthlyData[selectedMonth]!["Tutor Absent"]!;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Lessons Report",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.blue),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.blue,
//                     child: Icon(Icons.phone, color: Colors.white, size: 30),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "The following is a report of lessons by status for the current or last month. You can see the details of the lessons you have learned.",
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                       maxLines: 3,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Horizontal Scrollable Cards
//               SizedBox(
//                 height: 120,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     buildStatusCard("Completed", completedLessons.toString(), Colors.green),
//                     buildStatusCard("Student Absent", studentAbsent.toString(), Colors.orange),
//                     buildStatusCard("Tutor Absent", tutorAbsent.toString(), Colors.purple),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Centered Total Lessons Learned
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       "Total lessons learned: ${completedLessons + studentAbsent + tutorAbsent}",
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     // Centered Month Toggle Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Last Month Button
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedMonth = "Last Month";
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: selectedMonth == "Last Month"
//                                 ? Colors.white
//                                 : Colors.black, backgroundColor: selectedMonth == "Last Month"
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                           ),
//                           child: const Text("Last Month", style: TextStyle(fontSize: 12)),
//                         ),
//                         const SizedBox(width: 8),
//                         // Current Month Button
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedMonth = "Current Month";
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: selectedMonth == "Current Month"
//                                 ? Colors.white
//                                 : Colors.black, backgroundColor: selectedMonth == "Current Month"
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                           ),
//                           child: const Text("Current Month", style: TextStyle(fontSize: 12)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Placeholder for Empty Data
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.insert_drive_file,
//                         size: 60, color: Colors.grey),
//                     SizedBox(height: 10),
//                     Text(
//                       "Empty data",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Method to Build Status Card
//   Widget buildStatusCard(String title, String value, Color color) {
//     return Container(
//       width: 150,
//       margin: const EdgeInsets.only(right: 16),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(LessonReportApp());
// }
//
// class LessonReportApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LessonReportPage(),
//     );
//   }
// }
//
// class LessonReportPage extends StatefulWidget {
//   @override
//   _LessonReportPageState createState() => _LessonReportPageState();
// }
//
// class _LessonReportPageState extends State<LessonReportPage> {
//   // Data for different months
//   final Map<String, Map<String, int>> monthlyData = {
//     "Current Month": {
//       "Completed": 5,
//       "Student Absent": 3,
//       "Tutor Absent": 2,
//     },
//     "Last Month": {
//       "Completed": 7,
//       "Student Absent": 1,
//       "Tutor Absent": 1,
//     },
//   };
//
//   // Dummy data simulating database values for lesson details
//   final Map<String, List<Map<String, String>>> lessonsData = {
//     "Current Month": [
//       {
//         "Date": "2024-12-01",
//         "Time": "10:00 AM",
//         "Subject": "Mathematics",
//         "Status": "Completed",
//         "Remarks": "Good progress"
//       },
//       {
//         "Date": "2024-12-02",
//         "Time": "11:00 AM",
//         "Subject": "Science",
//         "Status": "Student Absent",
//         "Remarks": "Student was unavailable"
//       },
//       {
//         "Date": "2024-12-03",
//         "Time": "01:00 PM",
//         "Subject": "English",
//         "Status": "Tutor Absent",
//         "Remarks": "Tutor had an emergency"
//       },
//     ],
//     "Last Month": [
//       {
//         "Date": "2024-11-15",
//         "Time": "09:00 AM",
//         "Subject": "Physics",
//         "Status": "Completed",
//         "Remarks": "Excellent performance"
//       },
//       {
//         "Date": "2024-11-18",
//         "Time": "10:30 AM",
//         "Subject": "Chemistry",
//         "Status": "Student Absent",
//         "Remarks": "Absent without notice"
//       },
//       {
//         "Date": "2024-11-22",
//         "Time": "02:00 PM",
//         "Subject": "History",
//         "Status": "Tutor Absent",
//         "Remarks": "Emergency leave"
//       },
//     ],
//   };
//
//   String selectedMonth = "Current Month"; // Default selection
//
//   int get completedLessons => monthlyData[selectedMonth]!["Completed"]!;
//   int get studentAbsent => monthlyData[selectedMonth]!["Student Absent"]!;
//   int get tutorAbsent => monthlyData[selectedMonth]!["Tutor Absent"]!;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Lessons Report",
//           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.blue),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.blue,
//                     child: Icon(Icons.phone, color: Colors.white, size: 30),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "The following is a report of lessons by status for the current or last month. You can see the details of the lessons you have learned.",
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                       maxLines: 3,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Horizontal Scrollable Cards
//               SizedBox(
//                 height: 120,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     buildStatusCard("Completed", completedLessons.toString(), Colors.green),
//                     buildStatusCard("Student Absent", studentAbsent.toString(), Colors.orange),
//                     buildStatusCard("Tutor Absent", tutorAbsent.toString(), Colors.purple),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Centered Total Lessons Learned
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       "Total lessons learned: ${completedLessons + studentAbsent + tutorAbsent}",
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     // Centered Month Toggle Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Last Month Button
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedMonth = "Last Month";
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: selectedMonth == "Last Month"
//                                 ? Colors.white
//                                 : Colors.black, backgroundColor: selectedMonth == "Last Month"
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                           ),
//                           child: const Text("Last Month", style: TextStyle(fontSize: 12)),
//                         ),
//                         const SizedBox(width: 8),
//                         // Current Month Button
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               selectedMonth = "Current Month";
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: selectedMonth == "Current Month"
//                                 ? Colors.white
//                                 : Colors.black, backgroundColor: selectedMonth == "Current Month"
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                           ),
//                           child: const Text("Current Month", style: TextStyle(fontSize: 12)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Table Section for Lesson Details
//               const Text(
//                 "Lesson Details",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   columns: const [
//                     DataColumn(label: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
//                     DataColumn(label: Text("Time", style: TextStyle(fontWeight: FontWeight.bold))),
//                     DataColumn(label: Text("Subject", style: TextStyle(fontWeight: FontWeight.bold))),
//                     DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
//                     DataColumn(label: Text("Remarks", style: TextStyle(fontWeight: FontWeight.bold))),
//                   ],
//                   rows: lessonsData[selectedMonth]!.map((lesson) {
//                     return DataRow(cells: [
//                       DataCell(Text(lesson["Date"]!)),
//                       DataCell(Text(lesson["Time"]!)),
//                       DataCell(Text(lesson["Subject"]!)),
//                       DataCell(Text(lesson["Status"]!)),
//                       DataCell(Text(lesson["Remarks"]!)),
//                     ]);
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Method to Build Status Card
//   Widget buildStatusCard(String title, String value, Color color) {
//     return Container(
//       width: 150,
//       margin: const EdgeInsets.only(right: 16),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LessonReportPage extends StatefulWidget {
  final bool isTutor; // Flag to differentiate between Tutor and Student

  const LessonReportPage({Key? key, required this.isTutor}) : super(key: key);

  @override
  _LessonReportPageState createState() => _LessonReportPageState();
}

class _LessonReportPageState extends State<LessonReportPage> {
  late Map<String, Map<String, int>> monthlyData;
  late Map<String, List<Map<String, String>>> lessonsData;

  @override
  void initState() {
    super.initState();

    // Use different data for Tutor and Student
    if (widget.isTutor) {
      monthlyData = {
        "Current Month": {
          "Completed": 10,
          "Student Absent": 3,
          "Tutor Absent": 1,
        },
        "Last Month": {
          "Completed": 8,
          "Student Absent": 2,
          "Tutor Absent": 1,
        },
      };
      lessonsData = {
        "Current Month": [
          {
            "Date": "2024-12-01",
            "Time": "10:00 AM",
            "Subject": "Math",
            "Status": "Completed",
            "Remarks": "Good performance by students"
          },
          {
            "Date": "2024-12-03",
            "Time": "11:00 AM",
            "Subject": "Science",
            "Status": "Student Absent",
            "Remarks": "Student was unavailable"
          },
        ],
        "Last Month": [
          {
            "Date": "2024-11-15",
            "Time": "10:00 AM",
            "Subject": "History",
            "Status": "Completed",
            "Remarks": "Excellent class"
          },
        ],
      };
    } else {
      monthlyData = {
        "Current Month": {
          "Attended": 8,
          "Missed": 2,
          "Cancelled": 1,
        },
        "Last Month": {
          "Attended": 7,
          "Missed": 3,
          "Cancelled": 0,
        },
      };
      lessonsData = {
        "Current Month": [
          {
            "Date": "2024-12-01",
            "Time": "10:00 AM",
            "Subject": "Math",
            "Status": "Attended",
            "Remarks": "Very engaging"
          },
          {
            "Date": "2024-12-02",
            "Time": "11:00 AM",
            "Subject": "Science",
            "Status": "Missed",
            "Remarks": "Absent"
          },
        ],
        "Last Month": [
          {
            "Date": "2024-11-15",
            "Time": "10:00 AM",
            "Subject": "History",
            "Status": "Attended",
            "Remarks": "Interesting lecture"
          },
        ],
      };
    }
  }

  String selectedMonth = "Current Month";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isTutor ? "Tutor Lesson Report" : "Student Lesson Report",
          style: const TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      widget.isTutor ? Icons.school : Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.isTutor
                          ? "Review your lessons and monitor student progress."
                          : "Track your attended, missed, and cancelled lessons.",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Status Cards Section
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...monthlyData[selectedMonth]!.entries.map((entry) {
                      return buildStatusCard(entry.key, entry.value.toString());
                    }).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Total Lessons and Month Toggle
              Center(
                child: Column(
                  children: [
                    Text(
                      "Total lessons: ${monthlyData[selectedMonth]!.values.reduce((a, b) => a + b)}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Last Month Button
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedMonth = "Last Month";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: selectedMonth == "Last Month"
                                ? Colors.white
                                : Colors.black,
                            backgroundColor: selectedMonth == "Last Month"
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          child: const Text("Last Month"),
                        ),
                        const SizedBox(width: 10),
                        // Current Month Button
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedMonth = "Current Month";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: selectedMonth == "Current Month"
                                ? Colors.white
                                : Colors.black,
                            backgroundColor: selectedMonth == "Current Month"
                                ? Colors.blue
                                : Colors.grey[300],
                          ),
                          child: const Text("Current Month"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Lesson Details Table
              const Text(
                "Lesson Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Time", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Subject", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Remarks", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: lessonsData[selectedMonth]!.map((lesson) {
                    return DataRow(cells: [
                      DataCell(Text(lesson["Date"]!)),
                      DataCell(Text(lesson["Time"]!)),
                      DataCell(Text(lesson["Subject"]!)),
                      DataCell(Text(lesson["Status"]!)),
                      DataCell(Text(lesson["Remarks"]!)),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to Build Status Card
  Widget buildStatusCard(String title, String value) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ],
      ),
    );
  }
}
