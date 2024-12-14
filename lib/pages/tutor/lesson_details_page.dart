import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutornest/models/bookingModel.dart';
import 'package:tutornest/pages/tutor/tutor_live_stream_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A page that displays detailed information about a lesson.
class LessonDetailsPage extends StatelessWidget {
  final BookingModel lesson;

  LessonDetailsPage({required this.lesson});

  Future<String?> _fetchStudentUsername(String studentId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('students').doc(studentId).get();
      return doc.exists ? doc['username'] as String? : null;
    } catch (e) {
      return null; // Handle error gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson Details"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String?>(
              future: _fetchStudentUsername(lesson.studentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    "Fetching student username...",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    "Error fetching student username",
                    style: TextStyle(color: Colors.red),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Text(
                    "Student: ${snapshot.data}",
                    style: const TextStyle(fontSize: 18),
                  );
                } else {
                  return const Text(
                    "Student: Unknown",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Text(
              "Student ID: ${lesson.studentId}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "Start Time: ${DateFormat.yMMMd().format(lesson.startTime.toDate())} at ${DateFormat.jm().format(lesson.startTime.toDate())}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              "End Time: ${DateFormat.yMMMd().format(lesson.endTime.toDate())} at ${DateFormat.jm().format(lesson.endTime.toDate())}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                "Start Live Stream",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TutorLiveStreamPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}