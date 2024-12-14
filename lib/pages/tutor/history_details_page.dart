import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/models/bookingModel.dart';
import 'package:tutornest/pages/tutor/lesson_details_page.dart';

class HistoryDetailsPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String _formatDateTime(BuildContext context, DateTime dateTime) {
    return "${_formatTimeOfDay(context, TimeOfDay.fromDateTime(dateTime))}";
  }

  String _formatTimeOfDay(BuildContext context, TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(time,
        alwaysUse24HourFormat: false);
  }

  Future<String> _fetchStudentUsername(String studentId) async {
    try {
      DocumentSnapshot userDoc = await firestore.collection('students').doc(studentId).get();
      if (userDoc.exists) {
        return userDoc.get('username') ?? 'Unknown User';
      }
      return 'Unknown User';
    } catch (e) {
      print('Error fetching username: $e');
      return 'Unknown User';
    }
  }

  Stream<List<BookingModel>> _fetchBookingsBeforeToday(String tutorId) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    print('Fetching bookings for tutor: $tutorId'); // Debug print
    print('Today date: $today'); // Debug print

    return firestore
        .collection('bookings')
        .where('tutor_id', isEqualTo: tutorId)
        .where('start_time', isLessThan: Timestamp.fromDate(today)) // Changed from start_date to start_time
        .snapshots()
        .map((querySnapshot) {
      print('Number of documents: ${querySnapshot.docs.length}'); // Debug print

      final bookings = querySnapshot.docs.map((doc) {
        print('Document data: ${doc.data()}'); // Debug print
        try {
          return BookingModel.fromFirestore(doc);
        } catch (e) {
          print('Error parsing booking: $e');
          return null;
        }
      })
          .where((booking) => booking != null)
          .map((booking) => booking!)
          .toList();

      print('Number of valid bookings: ${bookings.length}'); // Debug print
      return bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: secureStorage.read(key: 'userId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text("Tutor ID not found")),
          );
        }

        String tutorId = snapshot.data!;
        print('Retrieved tutor ID: $tutorId'); // Debug print

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 10),
                const Text(
                  "History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                StreamBuilder<List<BookingModel>>(
                  stream: _fetchBookingsBeforeToday(tutorId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('StreamBuilder error: ${snapshot.error}'); // Debug print
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No bookings before today.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    var bookings = snapshot.data!;
                    print('Displaying ${bookings.length} bookings'); // Debug print

                    return Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: bookings.length,
                            itemBuilder: (context, index) {
                              var booking = bookings[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        FutureBuilder<String>(
                                          future: _fetchStudentUsername(booking.studentId),
                                          builder: (context, usernameSnapshot) {
                                            if (usernameSnapshot.connectionState == ConnectionState.waiting) {
                                              return const Text("Loading username...");
                                            }
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Student: ${usernameSnapshot.data}",
                                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "Student ID: ${booking.studentId}",
                                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Start Time: ${_formatDateTime(context, booking.startTime.toDate())}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "End Time: ${_formatDateTime(context, booking.endTime.toDate())}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                            "Status: ${booking.status}",
                                            style: const TextStyle(fontSize: 16)
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}