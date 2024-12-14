import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/models/bookingModel.dart';
import 'package:tutornest/pages/tutor/lesson_details_page.dart';

class ScheduleCards extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Helper function to format DateTime
  String _formatDateTime(BuildContext context, DateTime dateTime) {
    return "${_formatTimeOfDay(context, TimeOfDay.fromDateTime(dateTime))}";
  }

  // Helper function to format TimeOfDay
  String _formatTimeOfDay(BuildContext context, TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(time,
        alwaysUse24HourFormat: false);
  }

  // Function to fetch student username
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

  // Fetch today's bookings with tutorId
  Stream<List<BookingModel>> _fetchTodayBookings(String tutorId) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    return firestore
        .collection('bookings')
        .where('tutor_id', isEqualTo: tutorId)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) {
        BookingModel booking = BookingModel.fromFirestore(doc);
        DateTime bookingDate = booking.startTime.toDate();
        DateTime bookingDay = DateTime(bookingDate.year, bookingDate.month, bookingDate.day);

        if (bookingDay.isAtSameMomentAs(today)) {
          return booking;
        } else {
          return null;
        }
      })
          .where((booking) => booking != null)
          .map((booking) => booking!)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: secureStorage.read(key: 'userId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("Tutor ID not found"));
        }

        String tutorId = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Bookings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            StreamBuilder<List<BookingModel>>(
              stream: _fetchTodayBookings(tutorId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No bookings for today.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                var bookings = snapshot.data!;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LessonDetailsPage(lesson: booking)));
                          },
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  FutureBuilder<String>(
                                    future: _fetchStudentUsername(booking.studentId),
                                    builder: (context, usernameSnapshot) {
                                      if (usernameSnapshot.connectionState == ConnectionState.waiting) {
                                        return Text("Loading username...");
                                      }
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Student: ${usernameSnapshot.data}",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Student ID: ${booking.studentId}",
                                            style: TextStyle(fontSize: 14, color: Colors.grey),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Start Time: ${_formatDateTime(context, booking.startTime.toDate())}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "End Time: ${_formatDateTime(context, booking.endTime.toDate())}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 10),
                                  Text("Status: ${booking.status}", style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}