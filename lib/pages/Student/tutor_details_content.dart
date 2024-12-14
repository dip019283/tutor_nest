import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/models/bookingModel.dart';
import 'package:tutornest/models/ratingModel.dart';
import 'package:tutornest/models/reportModel.dart';
import 'package:tutornest/models/reviewModel.dart';
import 'package:tutornest/pages/Student/payment_page_content.dart';
import 'package:tutornest/pages/Student/student_live_stream_page.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutornest/models/tutorModel.dart';

class TutorDetailsContent extends StatelessWidget {
  final String tutorId;
  const TutorDetailsContent({Key? key, required this.tutorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TutorDetailsPage(tutorId: tutorId);
  }
}

class TutorDetailsPage extends StatefulWidget {
  final String tutorId;
  const TutorDetailsPage({Key? key, required this.tutorId}) : super(key: key);
  @override
  _TutorDetailsPageState createState() => _TutorDetailsPageState();
}


class _TutorDetailsPageState extends State<TutorDetailsPage> {
  final secureStorage = FlutterSecureStorage();
  Tutor? tutor;

  String tutorImage =
      "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80";

  bool hasBookedTutor = true;
  final List<String> videoUrls = [
    'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
  ];

  bool isTutorAvailable = true;
  bool isUserSubscribed = false;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<String?> getDocumentIdFromSecureStorage() async {
    return await secureStorage.read(key: 'userId');
  }

  Future<Tutor?> getTutorData(String documentId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('tutors')
          .doc(documentId)
          .get();

      if (doc.exists) {
        return Tutor.fromFirestore(doc);
      }
    } catch (e) {
      print('Error fetching tutor data: $e');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    loadTutorData();
  }

  Future<void> loadTutorData() async {
    String? documentId = widget.tutorId;
    if (documentId != null) {
      Tutor? fetchedTutor = await getTutorData(documentId);
      if (fetchedTutor != null) {
        setState(() {
          tutor = fetchedTutor;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set AppBar background to white
        title: Text(
          'Tutor Details',
          style: TextStyle(color: Colors.blue), // Set title color to blue
        ),
        centerTitle: true,
        elevation: 1, // Optional: Add slight shadow for better visibility
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Photo with NetworkImage
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(tutorImage),
                backgroundColor: Colors.transparent,
                onBackgroundImageError: (exception, stackTrace) {
                  // Handle image loading error
                  // Optionally, set a default image or display an error message
                },
              ),
              SizedBox(height: 10),
              // Name and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tutor?.username ?? 'No name',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '5.0',
                        style:
                        TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              // Address
              Text(
                tutor?.address ?? 'Loading',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              SizedBox(height: 20),
              // "Book Now" Button Positioned Above Other Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final studentid = await FlutterSecureStorage().read(key: 'userId');

                    if (studentid != null) {
                      QuerySnapshot paymentSnapshot = await FirebaseFirestore.instance
                          .collection('payments')
                          .where('studentId', isEqualTo: studentid)
                          .get();

                      bool hasValidPayment = false;
                      for (var paymentDoc in paymentSnapshot.docs) {
                        // Assuming the date is stored as a Timestamp field in Firestore
                        Timestamp endDate = paymentDoc['dueDate'];
                        DateTime paymentDateTime = endDate.toDate();

                        // Check if the payment date is in the future
                        if (paymentDateTime.isAfter(DateTime.now())) {
                          hasValidPayment = true;
                          // Navigate to StudentLiveStreamPage if valid payment is found
                          _showBookingDialog(context);
                          break; // Exit the loop once the valid payment is found
                        }
                      }

                      if (!hasValidPayment) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentPage()),
                        );
                      }
                    } else {
                      // Handle the case where studentId is not found in secure storage
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("User ID not found")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Blue button
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                  ),
                  child: Text('Book Now', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 20),
              // Action Buttons: Report, Rate, Comment with Labels and Consistent Spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Report Button with Label (conditionally shown)
                  if (hasBookedTutor)
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.report, color: Colors.deepOrange),
                          onPressed: () {
                            _showReportDialog(context);
                          },
                        ),
                        Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  // Rate Button with Label (conditionally shown)
                  if (hasBookedTutor)
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.rate_review, color: Colors.blue),
                          onPressed: () {
                            _showRateDialog(context);
                          },
                        ),
                        Text(
                          'Rate',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  // Comment Button with Label (always shown)
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.comment, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPage(idT:widget.tutorId)),
                          );
                        },
                      ),
                      Text(
                        'Comment',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Description
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5),
              Text(
                tutor?.about ?? 'Loading',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 25),
              // Video Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Introduction Video',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 10),
              // Constrain video width to screen width and allow dynamic height
              Container(
                width: double.infinity,
                child: VideoCard(videoUrl: videoUrls[0]),
              ),
              SizedBox(height: 25),
              // Education Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Education',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5),
              Text(
                tutor?.education ?? 'Loading',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 25),
              // Languages Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Languages',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children:
                tutor?.languages?.map(
                      (language) => Chip(
                    label: Text(language),
                    backgroundColor: Colors.blue[50],
                    avatar: Icon(
                      Icons.language,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                )
                    .toList()??
                    [],
              ),
              SizedBox(height: 25),
              // Specialties Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Specialties',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children: tutor?.specialties?.map(
                      (specialty) => Chip(
                    label: Text(specialty),
                    backgroundColor: Colors.blue[50],
                    avatar: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                )
                    .toList() ?? [],
              ),
              SizedBox(height: 25),
              // Interests Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Interests',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5),
              Text(
                tutor?.interests ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 25),
              // Teaching Experience Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Teaching Experience',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 5),
              Text(
                tutor?.teachingExperience ?? '',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the booking dialog with date and time selection
  void _showBookingDialog(BuildContext context) {
    DateTime? tempSelectedDate = selectedDate;
    TimeOfDay? tempSelectedTime = selectedTime;
    bool tempIsTutorAvailable = isTutorAvailable;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          // Function to select date
          Future<void> _selectDate(BuildContext context) async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: tempSelectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (picked != null) {
              setState(() {
                tempSelectedDate = picked;
              });
            }
          }

          // Function to select time
          Future<void> _selectTime(BuildContext context) async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: tempSelectedTime ?? TimeOfDay.now(),
            );
            if (picked != null) {
              setState(() {
                tempSelectedTime = picked;
              });
            }
          }

          // Function to check tutor availability based on selected date and time
          void _checkTutorAvailability() {
            // TODO: Implement actual availability check logic
            // For now, we assume the tutor is available
            tempIsTutorAvailable = true;
          }

          // Function to create a booking
          void _createBooking() async{
            final studentid = await FlutterSecureStorage().read(key: 'userId');
            if (tempSelectedDate != null && tempSelectedTime != null) {
              // Convert selected time to DateTime for the start time
              final startDateTime = DateTime(
                tempSelectedDate!.year,
                tempSelectedDate!.month,
                tempSelectedDate!.day,
                tempSelectedTime!.hour,
                tempSelectedTime!.minute,
              );

              // Calculate end time by adding 1 hour to start time
              final endDateTime = startDateTime.add(Duration(hours: 1));

              final booking = BookingModel(
                bookingId: '', // Assuming Firebase will generate an ID
                tutorId: widget.tutorId,
                studentId: studentid!, // Replace with actual student ID
                startTime: Timestamp.fromDate(startDateTime), // Convert to Firestore Timestamp
                endTime: Timestamp.fromDate(endDateTime), // Convert to Firestore Timestamp
                date: Timestamp.fromDate(tempSelectedDate!), // Date part
                status: 'pending',
              );

              // Save the booking to Firestore
              await FirebaseFirestore.instance
                  .collection('bookings')
                  .add(booking.toFirestore())
                  .then((value) {
                Navigator.pushReplacementNamed(context,'/studentmain'); // Close the dialog after booking
              });
            }
          }



          return AlertDialog(
            title: Text('Book Tutor'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Date Picker
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tempSelectedDate == null
                            ? 'Select Date'
                            : DateFormat('yyyy-MM-dd')
                            .format(tempSelectedDate!),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Time Picker
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tempSelectedTime == null
                            ? 'Select Time'
                            : tempSelectedTime!.format(context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        _selectTime(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Availability Status
                if (tempSelectedDate != null && tempSelectedTime != null)
                  FutureBuilder(
                    future: Future.delayed(Duration(milliseconds: 500), () {
                      _checkTutorAvailability();
                      return tempIsTutorAvailable;
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        if (snapshot.hasData && snapshot.data == true) {
                          return Text(
                            'Tutor is available',
                            style: TextStyle(color: Colors.green),
                          );
                        } else {
                          return Text(
                            'Tutor is not available',
                            style: TextStyle(color: Colors.red),
                          );
                        }
                      }
                    },
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
              ),
              ElevatedButton(
                onPressed: _createBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change button color based on availability
                  foregroundColor: Colors.white,
                ),
                child: Text('Confirm'),
              ),
            ],
          );
        });
      },
    );
  }


  // Function to show the confirmation dialog after selecting date and time
  void _showConfirmBookingDialog(BuildContext context) {
    // Check if user is subscribed
    if (isUserSubscribed) {
      // If subscribed, show success message and enable rating/report
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking Confirmed!')),
      );
      setState(() {
        hasBookedTutor = true;
      });
    } else {
      // If not subscribed, navigate to subscription page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentPage()),
      );
    }
  }

  // Function to show the report dialog
  void _showReportDialog(BuildContext context) {
    TextEditingController reportController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Report Tutor'),
          content: TextField(
            controller: reportController,
            decoration: InputDecoration(
              hintText: 'Enter your report here...',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
              Text('Cancel', style: TextStyle(color: Colors.grey[700])),
            ),
            ElevatedButton(
              onPressed: () async {
                final studentid = await FlutterSecureStorage().read(key: 'userId');

                if (studentid != null && reportController.text.isNotEmpty) {
                  // Create the report
                  final report = ReportModel(
                    reportId: '',
                    studentId: studentid,
                    tutorId: widget.tutorId,
                    reportText: reportController.text,
                    reportDate: Timestamp.now(),
                  );

                  // Add the report to Firestore
                  await FirebaseFirestore.instance.collection('reports').add(report.toFirestore())
                      .then((docRef) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Report Submitted')),
                    );
                    // Optionally clear the text field after submission
                    reportController.clear();
                  })
                      .catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to submit report: $error')),
                    );
                  });
                } else {
                  // Show error if studentId or report text is missing
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill out all fields')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the rate dialog
  void _showRateDialog(BuildContext context) {
    double _currentRating = 5.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate this Tutor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please provide your rating below:'),
              SizedBox(height: 20),
              StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    value: _currentRating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _currentRating.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentRating = value;
                      });
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.blue[100],
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey[700])),
            ),
            ElevatedButton(
              onPressed: () async {
                // Retrieve the student ID from Flutter Secure Storage
                final studentId = await FlutterSecureStorage().read(key: 'userId');

                if (studentId != null) {
                  // Create a RatingModel instance
                  final rating = RatingModel(
                    ratingId: '',  // Firestore will generate the ratingId automatically
                    studentId: studentId,
                    tutorId: widget.tutorId,  // Assuming tutorId is available as widget.tutorId
                    rating: _currentRating.toInt(),  // Convert double to int
                  );

                  // Save to Firestore under the 'ratings' collection
                  await FirebaseFirestore.instance.collection('ratings').add(rating.toFirestore())
                      .then((docRef) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Thank you for your rating!'))
                    );
                  })
                      .catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to submit rating: $error'))
                    );
                  });

                  Navigator.pop(context);  // Close the dialog after submitting
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to retrieve student ID'))
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

}

class CommentPage extends StatefulWidget {
  final String idT;

  const CommentPage({Key? key, required this.idT}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  late Future<List<Map<String, dynamic>>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = fetchTutorReviews();
  }

  Future<List<Map<String, dynamic>>> fetchTutorReviews() async {
    try {
      final QuerySnapshot reviewsSnapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('tutor_id', isEqualTo: widget.idT)
          .get();

      List<Map<String, dynamic>> reviewsWithNames = [];

      for (var doc in reviewsSnapshot.docs) {
        final reviewData = doc.data() as Map<String, dynamic>;
        final studentId = reviewData['student_id'] as String;

        final studentDoc = await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .get();

        if (studentDoc.exists) {
          final studentData = studentDoc.data() as Map<String, dynamic>;
          reviewsWithNames.add({
            'reviewText': reviewData['review_text'],
            'studentName': studentData['username'] ?? 'Anonymous',
            'reviewDate': reviewData['review_date'],
          });
        } else {
          reviewsWithNames.add({
            'reviewText': reviewData['review_text'],
            'studentName': 'Unknown User',
            'reviewDate': reviewData['review_date'],
          });
        }
      }

      return reviewsWithNames;
    } catch (e) {
      print('Error fetching reviews: $e');
      return [];
    }
  }

  void refreshComments() {
    setState(() {
      _commentsFuture = fetchTutorReviews();
    });
  }

  Future<void> submitComment() async {
    final studentId = await const FlutterSecureStorage().read(key: 'userId');

    if (studentId != null && commentController.text.isNotEmpty) {
      final review = ReviewModel(
        reviewId: '',
        studentId: studentId,
        tutorId: widget.idT,
        reviewText: commentController.text,
        reviewDate: Timestamp.now(),
      );

      try {
        await FirebaseFirestore.instance.collection('reviews').add(review.toFirestore());
        commentController.clear();
        refreshComments();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Comment Added'))
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add comment: $error'))
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide a valid comment.'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _commentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final comments = snapshot.data ?? [];

                  if (comments.isEmpty) {
                    return const Center(child: Text('No comments yet'));
                  }

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      final date = (comment['reviewDate'] as Timestamp).toDate();

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(comment['studentName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comment['reviewText']),
                              const SizedBox(height: 4),
                              Text(
                                '${date.day}/${date.month}/${date.year}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                prefixIcon: const Icon(Icons.comment, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: submitComment,
              icon: const Icon(Icons.send),
              label: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}



class VideoCard extends StatefulWidget {
  final String videoUrl;

  VideoCard({required this.videoUrl});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isControlsVisible = true;
  bool _isDragging = false;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl, // Use the dynamic video URL
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(false);

    // Listen to video position updates
    _controller.addListener(() {
      if (!_isDragging && _controller.value.isInitialized) {
        setState(() {
          _sliderValue = _controller.value.position.inSeconds.toDouble();
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
    });
  }

  String _formatDuration(Duration duration) {
    // Formats duration to mm:ss
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes =
    twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds =
    twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration =
    _controller.value.isInitialized ? _controller.value.duration : Duration.zero;
    final currentPosition =
    _controller.value.isInitialized ? _controller.value.position : Duration.zero;
    final remainingDuration = totalDuration - currentPosition;

    return GestureDetector(
      onTap: _toggleControls,
      child: Stack(
        children: [
          // Video Player with Dynamic Aspect Ratio
          _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(
            height: 200, // Placeholder height while loading
            child: Center(child: CircularProgressIndicator()),
          ),
          // Overlay Controls
          if (_isControlsVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Controls (optional, can be used for title or other controls)
                    SizedBox(height: 10),
                    // Middle Controls (Play/Pause)
                    Expanded(
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 60,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                      ),
                    ),
                    // Bottom Controls (Rewind, Progress Bar, Forward)
                    Container(
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        children: [
                          // Progress Bar
                          _controller.value.isInitialized
                              ? Column(
                            children: [
                              Slider(
                                value: _sliderValue,
                                min: 0.0,
                                max: totalDuration.inSeconds.toDouble(),
                                activeColor: Colors.blue,
                                inactiveColor: Colors.white54,
                                onChanged: (value) {
                                  setState(() {
                                    _isDragging = true;
                                    _sliderValue = value;
                                  });
                                },
                                onChangeEnd: (value) {
                                  setState(() {
                                    _controller.seekTo(
                                        Duration(seconds: value.toInt()));
                                    _isDragging = false;
                                  });
                                },
                              ),
                              // Time Display
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Current Time
                                  Text(
                                    _formatDuration(currentPosition),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  // Remaining Time
                                  Text(
                                    '-${_formatDuration(remainingDuration)}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          )
                              : Container(),
                          // Rewind, Play/Pause, Forward Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Rewind 10 Seconds
                              IconButton(
                                icon: Icon(Icons.replay_10,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  final newPosition = _controller
                                      .value.position -
                                      Duration(seconds: 10);
                                  _controller.seekTo(newPosition >= Duration.zero
                                      ? newPosition
                                      : Duration.zero);
                                },
                              ),
                              // Play/Pause Button
                              IconButton(
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                              ),
                              // Forward 10 Seconds
                              IconButton(
                                icon: Icon(Icons.forward_10,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  final newPosition = _controller
                                      .value.position +
                                      Duration(seconds: 10);
                                  _controller.seekTo(newPosition <=
                                      _controller.value.duration
                                      ? newPosition
                                      : _controller.value.duration);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
