import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutornest/pages/Student/student_live_stream_page.dart';

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> data;  // Booking data
  final String tutorName;          // Tutor name fetched

  const BookingCard({Key? key, required this.data, required this.tutorName}) : super(key: key);

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Unknown Time";
    try {
      return timestamp.toDate().toString().substring(0, 19); // Format: YYYY-MM-DD HH:mm:ss
    } catch (e) {
      print('Error formatting timestamp: $e');
      return "Invalid Time";
    }
  }


  @override
  Widget build(BuildContext context) {


    void CancelBooking(String date, String startTime, String endTime) async {
      try {
        // Convert start and end time strings back to DateTime for querying
        DateTime parsedStartTime = DateTime.parse(startTime);
        DateTime parsedEndTime = DateTime.parse(endTime);
        DateTime parsedDate = DateTime.parse(date);

        // Query the bookings collection for a matching document
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('date', isEqualTo: Timestamp.fromDate(parsedDate))
            .where('start_time', isEqualTo: Timestamp.fromDate(parsedStartTime))
            .where('end_time', isEqualTo: Timestamp.fromDate(parsedEndTime))
            .get();

        // Iterate through and delete matching documents
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
          print("Booking with ID ${doc.id} has been successfully canceled.");
        }
      } catch (e) {
        print("Error canceling booking: $e");
      }
    }



    print('BookingCard Data: $data');
    print('Tutor Name: $tutorName');

    // Safely extract timestamps
    final startTime = data['start_time'] is Timestamp
        ? formatTimestamp(data['start_time'] as Timestamp)
        : "Unknown Start Time";

    final endTime = data['end_time'] is Timestamp
        ? formatTimestamp(data['end_time'] as Timestamp)
        : "Unknown End Time";

    // Safely extract date
    final date = data['date'] is Timestamp
        ? (data['date'] as Timestamp).toDate().toString().substring(0, 10)
        : "Unknown Date";

    // Safely extract status
    final status = data['status']?.toString() ?? "Unknown Status";

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tutor Info Row
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    tutorName.isNotEmpty ? tutorName[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tutorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (data['rating'] != null) Text(
                  "⭐ ${data['rating']?.toString() ?? '5.0'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Date and Time
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              "$startTime - $endTime",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            // Status
            Row(
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: status.toLowerCase() == 'confirmed'
                        ? Colors.green.shade100
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: status.toLowerCase() == 'confirmed'
                          ? Colors.green.shade700
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>CancelBooking(date, startTime, endTime),
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          StudentLiveStreamPage()));
                    },
                    icon: const Icon(Icons.video_call),
                    label: const Text("Go to class"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}