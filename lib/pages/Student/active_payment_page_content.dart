import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/pages/Student/settings_page_content.dart';

class ActiveSubscriptionPage extends StatefulWidget {
  const ActiveSubscriptionPage({Key? key}) : super(key: key);

  @override
  _ActiveSubscriptionPageState createState() => _ActiveSubscriptionPageState();
}

class _ActiveSubscriptionPageState extends State<ActiveSubscriptionPage> {
  DateTime? expiryDate;
  Duration remainingTime = Duration.zero;
  Timer? timer;
  String? plan;

  void getPaymentDetail() async {
    try {
      final studentid = await FlutterSecureStorage().read(key: 'userId');
      final response = await FirebaseFirestore.instance
          .collection('payments')
          .where('studentId', isEqualTo: studentid)
          .limit(1)
          .get();

      // Check if documents exist
      if (response.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No payment details found.')),
        );
        return;
      }

      final responseData = response.docs.first.data();
      plan = responseData['plan'];
      final Timestamp dueDateTimestamp = responseData['dueDate'] as Timestamp;
      expiryDate = dueDateTimestamp.toDate();

      if (mounted) {
        setState(() {
          if (expiryDate != null) {
            remainingTime = expiryDate!.difference(DateTime.now());
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch payment details: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getPaymentDetail();

    // Initialize the timer to update the remaining time
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateRemainingTime());
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void updateRemainingTime() {
    if (expiryDate != null) {
      setState(() {
        remainingTime = expiryDate!.difference(DateTime.now());
        if (remainingTime.isNegative) {
          remainingTime = Duration.zero;
          timer?.cancel();
        }
      });
    }
  }

  String formatDuration(Duration duration) {
    final int days = duration.inDays;
    final int hours = duration.inHours % 24;
    final int minutes = duration.inMinutes % 60;
    final int seconds = duration.inSeconds % 60;

    if (plan == "Monthly Plan") {
      return '$days days $hours hours $minutes minutes $seconds seconds';
    } else {
      final int months = days ~/ 30;
      final int remainingDays = days % 30; // Remaining days after full months
      return '$months months $remainingDays days $hours hours $minutes minutes $seconds seconds';
    }
  }

  // Getter to determine if cancellation is allowed
  bool get canCancelSubscription {
    if (expiryDate == null) return false;
    final Duration sincePurchase = DateTime.now().difference(expiryDate!);
    return sincePurchase.inDays < 7;
  }

  // Method to show the cancellation confirmation dialog
  void _showCancellationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Subscription'),
          content: const Text('Are you sure you want to cancel your subscription?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _cancelSubscription();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to handle the cancellation logic
  void _cancelSubscription() async {
    final studentid = await FlutterSecureStorage().read(key: 'userId');
    final response = await FirebaseFirestore.instance
        .collection('payments')
        .where('studentId', isEqualTo: studentid)
        .limit(1)
        .get();

    if (response.docs.isEmpty) return;

    final docId = response.docs.first.id;
    await FirebaseFirestore.instance.collection('payments').doc(docId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Subscription canceled successfully.')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/studentmain'); // Navigate back
          },
        ),
        title: const Text(
          'Active Subscription',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.blue), // Change back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Subscription Details Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your Subscription',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      plan == "Monthly Plan" ? "1-Month Plan" : "1-Year Plan",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Time Remaining Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Time Remaining',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formatDuration(remainingTime),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Conditionally display the Cancel Subscription button
              if (canCancelSubscription) ...[
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Red color to indicate a destructive action
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    _showCancellationDialog();
                  },
                  child: const Text('Cancel Subscription'),
                ),
              ],
              // Add Back button at the end
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous page
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
