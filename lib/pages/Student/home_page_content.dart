import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:tutornest/models/tutorModel.dart';
import 'package:tutornest/pages/Student/tutor_details_content.dart';
import '../../services/home_service.dart'; // Import the service
import '../../widgets/upcoming_lesson_card.dart'; // Import the UpcomingLessonCard
import '../../widgets/tutor_card.dart'; // Import the TutorCard
import '../../models/tutor_item.dart';
import '../../models/upcoming_lesson_item.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final HomeService _homeService = HomeService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  List<Tutor> _allTutors = [];
  List<Tutor> _filteredTutors = [];
  bool _isLoading = true;
  String _searchQuery = '';

  Future<List<Tutor>> _fetchTutors() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('tutors').where('isVerified',isEqualTo: true).get();

      return snapshot.docs.map((doc) => Tutor.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load tutors: $e');
    }
  }


  Future<void> _initializeTutors() async {
    try {
      final tutors = await _fetchTutors();
      setState(() {
        _allTutors = tutors;
        _filteredTutors = tutors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error initializing tutors: $e');
    }
  }

  Future<double> _fetchTutorRating(String tutorId) async {
    try {
      final QuerySnapshot ratingsSnapshot = await _firestore
          .collection('ratings')
          .where('tutorId', isEqualTo: tutorId)
          .get();

      if (ratingsSnapshot.docs.isEmpty) return 0.0;

      final totalRating = ratingsSnapshot.docs.fold(0.0, (sum, doc) {
        return sum + (doc['rating'] ?? 0.0);
      });

      return totalRating / ratingsSnapshot.docs.length;
    } catch (e) {
      print('Error fetching ratings for tutor $tutorId: $e');
      return 0.0;
    }
  }


  void _filterTutors(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredTutors = _allTutors;
      } else {
        _filteredTutors = _allTutors.where((tutor) {
          final nameMatch = tutor.username?.toLowerCase().contains(_searchQuery) ?? false;
          final specialtiesMatch = tutor.specialties.any(
                  (specialty) => specialty.toLowerCase().contains(_searchQuery)
          );
          return nameMatch || specialtiesMatch;
        }).toList();
      }
    });
  }


  @override
  void initState() {
    super.initState();
    _initializeTutors();
  }


  void showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("Filter options can be added here for future upgrades."),
              // Add more filter options as needed
            ],
          ),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchBookings() async {
    final storage = FlutterSecureStorage();
    final studentId = await storage.read(key: 'userId');
    print('Student ID: $studentId');

    if (studentId == null) {
      print('No Student ID found');
      return [];
    }

    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('student_id', isEqualTo: studentId)
          .where('start_time',isGreaterThan: Timestamp.now()).orderBy('start_time',descending: false)
          .get();

      print('Fetched ${querySnapshot.docs.length} bookings');
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching bookings: $e');
      throw e;
    }
  }


  String _formatDateTime(DateTime dateTime) {
    final date = DateFormat('MMMM d, yyyy').format(dateTime);
    final time = DateFormat('h:mm a').format(dateTime);
    final day = DateFormat('EEEE').format(dateTime);
    return '$day $date\n$time';
  }

  String _calculateDuration(DateTime startTime, DateTime endTime) {
    final duration = endTime.difference(startTime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  @override

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to the platform!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchBookings(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Center(child: Text('Error loading bookings: ${snapshot.error}'));
              }

              final bookings = snapshot.data ?? [];
              final containerHeight = bookings.isEmpty ? 0.0 : 200.0;

              return Container(
                height: containerHeight,
                child: bookings.isEmpty
                    ? Center() // Empty container for no bookings
                    : ListView.builder(
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    final startTime = (booking['start_time'] as Timestamp).toDate();
                    final endTime = (booking['end_time'] as Timestamp).toDate();

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upcoming Lesson",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(_formatDateTime(startTime)),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/livestreamstudent');
                              },
                              icon: Icon(Icons.play_arrow),
                              label: Text("Enter lesson room"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Total lesson time: ${_calculateDuration(startTime, endTime)}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child:
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Find a tutor by name or subject",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Add a clear button when there's text
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _filterTutors('');
                      },
                    )
                        : null,
                  ),
                  onChanged: _filterTutors,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? "Recommended Tutors"
                : "Search Results (${_filteredTutors.length})",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 16),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_filteredTutors.isEmpty)
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _searchQuery.isEmpty
                      ? "No recommended tutors available."
                      : "No tutors found matching '$_searchQuery'",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            )
          else
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _filteredTutors.length,
              itemBuilder: (context, index) {
                var tutor = _filteredTutors[index];
                return FutureBuilder<double>(
                  future: _fetchTutorRating(tutor.tutorId),
                  builder: (context, snapshot) {
                    final rating = snapshot.data ?? 0.0;
                    return TutorCard(
                      tutor: TutorItem(
                        id: tutor.tutorId,
                        name: tutor.username ?? 'Unknown Tutor',
                        subjects: tutor.specialties,
                        rating: rating,
                        profilePicture:
                        tutor.photo ?? 'https://example.com/default_profile.jpg',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TutorDetailsPage(tutorId: tutor.tutorId),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),

        ],
      ),
    );
  }
}

  // Widget build(BuildContext context) {
  //   // Note: Removed the Scaffold, AppBar, Drawer, and BottomNavigationBar
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Welcome to the platform!",
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 16),
  //         FutureBuilder<UpcomingLessonItem>(
  //           future: _homeService.fetchUpcomingLesson(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Center(child: CircularProgressIndicator());
  //             } else if (snapshot.hasData && snapshot.data!.id.isNotEmpty) {
  //               var lesson = snapshot.data!;
  //               return UpcomingLessonCard(lesson: lesson); // Use the widget
  //             } else {
  //               return Container(
  //                 padding: EdgeInsets.all(16),
  //                 decoration: BoxDecoration(
  //                   color: Colors.red[100],
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Text(
  //                   "No upcoming lessons.",
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //                 ),
  //               );
  //             }
  //           },
  //         ),
  //         SizedBox(height: 24),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: TextField(
  //                 decoration: InputDecoration(
  //                   hintText: "Find a tutor",
  //                   prefixIcon: Icon(Icons.search),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //                 onSubmitted: (value) {
  //                   // Handle search functionality
  //                 },
  //               ),
  //             ),
  //             SizedBox(width: 8),
  //             ElevatedButton(
  //               onPressed: showFilterOptions,
  //               child: Text("Filters"),
  //               style: ElevatedButton.styleFrom(
  //                 foregroundColor: Colors.black,
  //                 backgroundColor: Colors.grey[200],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Text(
  //           "Recommended Tutors",
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //         ),
  //         SizedBox(height: 16),
  //         FutureBuilder<List<Tutor>>(
  //           future: getAllTutors(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Center(child: CircularProgressIndicator());
  //             } else if (snapshot.hasError) {
  //               return Center(
  //                 child: Text(
  //                   'Failed to load tutors: ${snapshot.error}',
  //                   style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //                 ),
  //               );
  //             } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
  //               return ListView.builder(
  //                 physics: NeverScrollableScrollPhysics(),
  //                 shrinkWrap: true,
  //                 itemCount: snapshot.data!.length,
  //                 itemBuilder: (context, index) {
  //                   var tutor = snapshot.data![index];
  //                   return TutorCard(
  //                     tutor: tutor,
  //                     onTap: () {
  //                       Navigator.push(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => TutorDetailsPage(tutor: tutor),
  //                         ),
  //                       );
  //                     },
  //                   );
  //                 },
  //               );
  //             } else {
  //               return Center(
  //                 child: Container(
  //                   padding: EdgeInsets.all(16),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[200],
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Text(
  //                     "No recommended tutors available.",
  //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  //                   ),
  //                 ),
  //               );
  //             }
  //           },
  //         )
  //
  //
  //       ],
  //     ),
  //   );
  // }
