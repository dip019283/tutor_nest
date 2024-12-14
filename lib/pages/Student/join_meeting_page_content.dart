import 'package:flutter/material.dart';

class JoinMeetingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for now (to be replaced with Firebase data)
    String lessonDate = "Sun, 21 Jan 2024";
    String lessonTime = "00:00 - 00:25";
    String remainingTime = "03 : 27 : 45";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Join Meeting',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Big blue icon or illustration
            Icon(
              Icons.videocam_outlined,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            // Upcoming lesson text
            Text(
              'Upcoming Lesson',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            // Date and Lesson Time
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lessonDate,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(width: 10),
                Text(
                  lessonTime,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Remaining Time
            Text(
              remainingTime,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            // Join Meeting Button
            ElevatedButton(
              onPressed: () {
                // Add your join meeting functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Join Meeting',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JoinMeetingPage(),
  ));
}
