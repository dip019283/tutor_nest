import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutornest/widgets/history_card.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> data;  // Booking data
  final String tutorName;          // Tutor name fetched

  const HistoryCard({Key? key, required this.data, required this.tutorName}) : super(key: key);

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
                    onPressed: () {
                      // Handle Cancel action
                    },
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
                      // Handle Go to Class action
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