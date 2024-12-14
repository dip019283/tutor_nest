import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/models/lesson.dart';
import 'package:tutornest/models/lesson_history.dart';
import 'package:tutornest/models/time_slot.dart';
import 'package:tutornest/services/lesson_service.dart';
import 'package:tutornest/services/dummy_lesson_service.dart';
import 'package:tutornest/widgets/summary_cards.dart';
import 'package:tutornest/widgets/time_slots_table.dart';
import 'package:tutornest/widgets/schedule_cards.dart';
import 'package:tutornest/widgets/history_card.dart';
import 'package:tutornest/pages/tutor/history_details_page.dart';
import 'package:tutornest/pages/tutor/lesson_details_page.dart';

class DashboardPageContent extends StatefulWidget {
  @override
  _DashboardPageContentState createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<DashboardPageContent> {
  late LessonService _lessonService;

  List<TimeSlot> allTimeSlots = [];
  Map<TimeSlot, bool> bookedTimeSlots = {};
  List<Lesson> scheduledLessons = [];
  List<LessonHistory> lessonHistory = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _lessonService = DummyLessonService();

    // Fetch initial data
    _loadData();

    // Start timer to check for completed lessons every 1 minute
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkCompletedLessons();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _lessonService.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    List<TimeSlot> slots = await _lessonService.fetchTimeSlots();
    List<Lesson> lessons = await _lessonService.fetchScheduledLessons();
    List<LessonHistory> history = await _lessonService.fetchLessonHistory();

    setState(() {
      allTimeSlots = slots;
      scheduledLessons = lessons;
      lessonHistory = history;

      // Initialize bookedTimeSlots map
      bookedTimeSlots = {};
      for (var slot in allTimeSlots) {
        bookedTimeSlots[slot] = slot.isBreak
            ? true
            : scheduledLessons.any((lesson) =>
        lesson.dateTime.hour == slot.start.hour &&
            lesson.dateTime.minute == slot.start.minute);
      }
    });
  }

  // Function to check and handle completed lessons
  Future<void> _checkCompletedLessons() async {
    await _loadData();
  }

  final _storage = FlutterSecureStorage();

  // Function to calculate total unique students
  Future<int> _totalUniqueStudents() async {
    try {
      String? tutorId = await _storage.read(key: 'userId');
      if (tutorId != null) {
        // Query the bookings collection where tutor_id matches
        QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('tutor_id', isEqualTo: tutorId)
            .get();

        // Extract student IDs and store them in a Set to ensure uniqueness
        Set<String> uniqueStudentIds = Set();

        for (var doc in bookingsSnapshot.docs) {
          String studentId = doc['student_id'];
          uniqueStudentIds.add(studentId); // Add student_id to the set
        }

        return uniqueStudentIds.length;
      } else {
        print('No tutor ID found in secure storage');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
    }
    return 0; // Return 0 if error occurs
  }

  // Function to calculate average lesson time
  // Function to calculate average lesson time based on bookings
  Future<double?> _averageLessonTime() async {
    try {
      String? tutorId = await _storage.read(key: 'userId');
      if (tutorId != null) {
        // Query the bookings collection where tutor_id matches
        QuerySnapshot bookingsSnapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('tutor_id', isEqualTo: tutorId)
            .get();

        int totalBookingCount = bookingsSnapshot.docs.length;

        if (totalBookingCount == 0) {
          return 0.0;
        }

        double totalLessonDuration = totalBookingCount * 60;

        double avgLessonTime = totalLessonDuration / totalBookingCount;

        return avgLessonTime;
      } else {
        print('No tutor ID found in secure storage');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
      return 0.0;
    }
  }


  /// Function to navigate to History Details Screen
  void _navigateToHistoryDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HistoryDetailsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards at the Top
          FutureBuilder(
            future: Future.wait([_totalUniqueStudents(), _averageLessonTime()]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("Error loading summary data.");
              }

              int totalStudents = snapshot.data![0];
              double avgLessonTime = snapshot.data![1];

              return SummaryCards(
                totalStudents: totalStudents,
                avgLessonTime: avgLessonTime,
              );
            },
          ),
          SizedBox(height: 20),
          // Available Time & Booked Time Table
          TimeSlotsTable(),
          SizedBox(height: 20),
          // Schedule Cards
          ScheduleCards(),
          SizedBox(height: 20),
          // History Card
          HistoryCard(
            recordCount: lessonHistory.length,
            onTap: _navigateToHistoryDetails,
          ),
        ],
      ),
    );
  }
}
