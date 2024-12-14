
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/history_service.dart'; // Import the service
import '../../widgets/student_history_card.dart';    // Import the HistoryCard widget
import '../../models/history_item.dart';     // Import the HistoryItem model

class HistoryPageContent extends StatefulWidget {
  @override
  _HistoryPageContentState createState() => _HistoryPageContentState();
}

class _HistoryPageContentState extends State<HistoryPageContent> {
  final HistoryService _historyService = HistoryService();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Stream<QuerySnapshot>? _bookingsStream;

  @override
  void initState() {
    super.initState();
    _initializeBookingsStream();
  }

  void _initializeBookingsStream() async {
    try {
      String? studentId = await _storage.read(key: 'userId');
      print('Student ID: $studentId'); // Debug print

      if (studentId != null) {
        setState(() {
          _bookingsStream = FirebaseFirestore.instance
              .collection('bookings')
              .where('student_id', isEqualTo: studentId).where('start_time',isLessThan: Timestamp.now())
              .snapshots();
        });
      } else {
        print('No student ID found in storage'); // Debug print
      }
    } catch (e) {
      print('Error initializing stream: $e'); // Debug print
    }
  }

  Future<String> _fetchTutorDetails(String? tutorId) async {
    if (tutorId == null) return 'Unknown Tutor';

    try {
      DocumentSnapshot tutorDoc = await FirebaseFirestore.instance
          .collection('tutors')
          .doc(tutorId)
          .get();

      if (tutorDoc.exists) {
        final data = tutorDoc.data() as Map<String, dynamic>?;
        return data?['username']?.toString() ?? 'Unknown Tutor';
      }
    } catch (e) {
      print('Error fetching tutor details: $e');
    }
    return 'Unknown Tutor';
  }

  @override
  Widget build(BuildContext context) {
    if (_bookingsStream == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _bookingsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Stream error: ${snapshot.error}'); // Debug print
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs;
        if (docs == null || docs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  "No History available",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        print('Found ${docs.length} bookings'); // Debug print

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/schedule.png',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "History",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Booking History are listed here",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final bookingData = doc.data() as Map<String, dynamic>;

                    // Debug print booking data
                    print('Booking data for index $index: $bookingData');

                    final tutorId = bookingData['tutor_id']?.toString();

                    return FutureBuilder<String>(
                      future: _fetchTutorDetails(tutorId),
                      builder: (context, tutorSnapshot) {
                        if (tutorSnapshot.connectionState == ConnectionState.waiting) {
                          return const Card(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        }

                        final tutorName = tutorSnapshot.data ?? 'Unknown Tutor';

                        return HistoryCard(
                          data: bookingData,
                          tutorName: tutorName,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
