import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/models/bookingModel.dart';

class TutorLessonReportPage extends StatefulWidget {
  const TutorLessonReportPage({Key? key}) : super(key: key);

  @override
  _TutorLessonReportPageState createState() => _TutorLessonReportPageState();
}

class _TutorLessonReportPageState extends State<TutorLessonReportPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  String selectedMonth = "Current Month";
  String? tutorId;

  @override
  void initState() {
    super.initState();
    _loadTutorId();
  }

  Future<void> _loadTutorId() async {
    tutorId = await _secureStorage.read(key: 'userId');
    if (mounted) setState(() {});
  }

  Stream<List<BookingModel>> _getBookings() {
    if (tutorId == null) return Stream.value([]);

    final now = DateTime.now();
    final startDate = selectedMonth == "Current Month"
        ? DateTime(now.year, now.month, 1)
        : DateTime(now.year, now.month - 1, 1);

    return _firestore
        .collection('bookings')
        .where('tutor_id', isEqualTo: tutorId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .orderBy('date')
        .snapshots()
        .map((snapshot) {
      final endDate = selectedMonth == "Current Month"
          ? DateTime(now.year, now.month + 1, 1)
          : DateTime(now.year, now.month, 1);

      return snapshot.docs
          .map((doc) => BookingModel.fromFirestore(doc))
          .where((booking) => booking.date.toDate().isBefore(endDate))
          .toList();
    });
  }

  Map<String, int> _calculateStatusCounts(List<BookingModel> bookings) {
    return {
      "Completed": bookings.where((b) => b.status == "completed").length,
      "Student Absent": bookings.where((b) => b.status == "student_absent").length,
      "Tutor Absent": bookings.where((b) => b.status == "tutor_absent").length,
    };
  }

  List<Map<String, String>> _formatBookingsForTable(List<BookingModel> bookings) {
    return bookings.map((booking) {
      return {
        "Date": booking.date.toDate().toString().split(' ')[0],
        "Time": "${booking.startTime.toDate().hour}:${booking.startTime.toDate().minute.toString().padLeft(2, '0')}",
        "Subject": "Subject", // Add subject to your BookingModel if needed
        "Status": booking.status,
        "Remarks": booking.status, // Add remarks to your BookingModel if needed
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tutor Lesson Report",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue),
        centerTitle: true,
      ),
      body: tutorId == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<BookingModel>>(
        stream: _getBookings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data!;
          final statusCounts = _calculateStatusCounts(bookings);
          final tableData = _formatBookingsForTable(bookings);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Review your lessons and monitor student progress.",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
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
                      children: statusCounts.entries
                          .map((entry) => buildStatusCard(
                          entry.key, entry.value.toString()))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Total Lessons and Month Toggle
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Total lessons: ${statusCounts.values.reduce((a, b) => a + b)}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedMonth = "Current Month";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                selectedMonth == "Current Month"
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor:
                                selectedMonth == "Current Month"
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
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                            label: Text("Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text("Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text("Subject",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text("Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))),
                        DataColumn(
                            label: Text("Remarks",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: tableData.map((lesson) {
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
          );
        },
      ),
    );
  }

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
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ],
      ),
    );
  }
}