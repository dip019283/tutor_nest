import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutornest/pages/Admin/tutor_request_detail_page.dart';
import 'add_tutor_page.dart';
import 'add_course_page.dart';
import 'tutor_requests_page.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int totalStudents = 0;
  int totalTutors = 0;
  double totalRevenue = 0.0;
  int totalTutorRequests = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDashboardData();
    });
  }

  Future<void> _fetchDashboardData() async {
    try {
      // Fetch total students count
      final studentsSnapshot = await _firestore.collection('students').get();

      // Fetch total tutors count
      final tutorsSnapshot = await _firestore.collection('tutors').get();

      // Fetch total revenue from payments collection
      final paymentsSnapshot = await _firestore.collection('payments').get();

      // Fetch unverified tutor requests
      final tutorRequestsSnapshot = await _firestore
          .collection('tutors')
          .where('isVerified', isEqualTo: false)
          .get();

      // Add debug logs to check data
      tutorRequestsSnapshot.docs.forEach((doc) {
        print("Tutor Request Doc: ${doc.data()}");  // Log the tutor document data
      });

      // Calculate total revenue
      double revenue = 0.0;
      for (var doc in paymentsSnapshot.docs) {
        // Assuming 'amount' is a numeric field in payments collection
        revenue += (doc.data()['amount'] as num?)?.toDouble() ?? 0.0;
      }
      print('Total unverified tutor requests: ${tutorRequestsSnapshot.docs.length}'); // Log total tutor requests

      setState(() {
        totalStudents = studentsSnapshot.docs.length;
        totalTutors = tutorsSnapshot.docs.length;
        totalRevenue = revenue;
        totalTutorRequests = tutorRequestsSnapshot.docs.length;
      });
    } catch (e) {
      // Handle errors by showing a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching dashboard data: $e')),
      );
    }
  }


  // Refresh function to re-fetch data
  Future<void> _refreshDashboardData() async {
    await _fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshDashboardData,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Row: Total Students and Total Tutors
            Row(
              children: [
                Expanded(
                  child: _buildStatisticCard(
                    title: 'Total Students',
                    count: totalStudents.toString(),
                    icon: Icon(
                      Icons.person,
                      size: 40.0,
                      color: Colors.blue,
                    ),
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: _buildStatisticCard(
                    title: 'Total Tutors',
                    count: totalTutors.toString(),
                    icon: Icon(
                      Icons.school,
                      size: 40.0,
                      color: Colors.green,
                    ),
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Second Row: Total Revenue (Full Width)
            _buildStatisticCard(
              title: 'Total Revenue',
              count: 'रू ${totalRevenue.toStringAsFixed(2)}', // Nepali Rupee symbol
              icon: Text(
                'रू',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.orange,
              isFullWidth: true,
            ),
            SizedBox(height: 16.0),

            // Third Row: Add Tutor and Add Course
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Navigate to AddTutorPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTutorPage()),
                      ).then((_) => _fetchDashboardData());
                    },
                    child: _buildActionCard(
                      title: 'Add Tutor',
                      icon: Icons.add,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Navigate to AddCoursePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCoursePage()),
                      ).then((_) => _fetchDashboardData());
                    },
                    child: _buildActionCard(
                      title: 'Add Course',
                      icon: Icons.book,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Fourth Row: Tutor Requests (Full Width and Clickable)
            _buildActionCard(
              title: 'Tutor Requests',
              icon: Icons.request_page,
              color: Colors.deepOrange,
              badgeCount: totalTutorRequests,
              isFullWidth: true,
              onTap: () {
                // Navigate to TutorRequestsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerifyTutorPage()),
                ).then((_) => _fetchDashboardData());
              },
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  // Helper method to build statistic cards (remains the same as in the previous implementation)
  Widget _buildStatisticCard({
    required String title,
    required String count,
    Widget? icon,
    required Color color,
    bool isFullWidth = false,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: isFullWidth ? double.infinity : null,
        child: Column(
          children: [
            if (icon != null) icon,
            SizedBox(height: 10.0),
            Text(
              count,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build action cards (remains the same as in the previous implementation)
  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
    int? badgeCount,
    bool isFullWidth = false,
  }) {
    double cardHeight = isFullWidth ? 120.0 : 100.0;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              height: cardHeight,
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(icon, size: 30.0, color: color),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (badgeCount != null && badgeCount > 0 && !isFullWidth)
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          if (badgeCount != null && badgeCount > 0 && isFullWidth)
            Positioned(
              right: 16,
              top: 16,
              child: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}