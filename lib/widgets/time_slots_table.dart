import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/time_slot.dart';

class TimeSlotsTable extends StatelessWidget {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Helper function to format time range
  String _formatTimeRange(BuildContext context, TimeOfDay start, TimeOfDay end) {
    return "${_formatTimeOfDay(context, start)} - ${_formatTimeOfDay(context, end)}";
  }

  // Helper function to format TimeOfDay
  String _formatTimeOfDay(BuildContext context, TimeOfDay time) {
    return MaterialLocalizations.of(context).formatTimeOfDay(time,
        alwaysUse24HourFormat: false);
  }

  // Helper function to format DateTime into a readable date
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // Function to fetch booked time slots from Firestore based on tutorId
  Future<List<Map<String, dynamic>>> _fetchBookedTimeSlots(String tutorId) async {
    List<Map<String, dynamic>> bookedTimeSlots = [];

    try {
      // Query bookings where tutor_id matches
      QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('tutor_id', isEqualTo: tutorId)
          .get();

      // Process the bookings and add them to the list
      for (var doc in bookingsSnapshot.docs) {
        Timestamp startTimestamp = doc['start_time'];
        Timestamp endTimestamp = doc['end_time'];
        Timestamp dateTimestamp = doc['date']; // Assuming there is a date field

        DateTime startTime = startTimestamp.toDate();
        DateTime endTime = endTimestamp.toDate();
        DateTime dateTime = dateTimestamp.toDate(); // Convert date timestamp

        TimeOfDay start = TimeOfDay.fromDateTime(startTime);
        TimeOfDay end = TimeOfDay.fromDateTime(endTime);

        // Create a new Map with time and date information
        bookedTimeSlots.add({
          'start': start,
          'end': end,
          'date': dateTime,
        });
      }
    } catch (e) {
      print('Error fetching bookings: $e');
    }

    return bookedTimeSlots;
  }

  // Function to get the tutorId from secure storage
  Future<String?> _getTutorId() async {
    return await secureStorage.read(key: 'userId');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getTutorId(), // Get the tutorId from secure storage
      builder: (context, tutorIdSnapshot) {
        if (tutorIdSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (tutorIdSnapshot.hasError || !tutorIdSnapshot.hasData) {
          return Center(child: Text('Error loading tutor ID'));
        }

        final tutorId = tutorIdSnapshot.data;

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchBookedTimeSlots(tutorId!), // Fetch booked time slots based on tutorId
          builder: (context, bookedSlotsSnapshot) {
            if (bookedSlotsSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (bookedSlotsSnapshot.hasError) {
              return Center(child: Text('Error loading booked slots'));
            }

            if (!bookedSlotsSnapshot.hasData || bookedSlotsSnapshot.data!.isEmpty) {
              return Center(child: Text('No booked slots found.'));
            }

            // List of booked time slots with date
            List<Map<String, dynamic>> bookedTimeSlots = bookedSlotsSnapshot.data!;

            return Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Booked Time Slots",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.blue.shade50),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Time",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Date",
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        // Only show booked time slots
                        ...bookedTimeSlots.map((slot) {
                          DateTime date = slot['date'];
                          return TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "${_formatTimeRange(context, slot['start'], slot['end'])}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  _formatDate(date),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
