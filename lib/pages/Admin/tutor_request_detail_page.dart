import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerifyTutorPage extends StatefulWidget {
  @override
  _VerifyTutorPageState createState() => _VerifyTutorPageState();
}

class _VerifyTutorPageState extends State<VerifyTutorPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> approveTutor(String tutorId) async {
    try {
      await _firestore.collection('tutors').doc(tutorId).update({
        'isVerified': true,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tutor approved successfully!')),
      );
    } catch (e) {
      print("Error approving tutor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve tutor.')),
      );
    }
  }

  Future<void> rejectTutor(String tutorId) async {
    try {
      await _firestore.collection('tutors').doc(tutorId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tutor rejected and removed.')),
      );
    } catch (e) {
      print("Error rejecting tutor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject tutor.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutors Waiting for Verification'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('tutors')
            .where('isVerified', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tutors found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var tutor = snapshot.data!.docs[index];
              var tutorId = tutor.id;
              var tutorName = tutor['username'];

              return ExpansionTile(
                title: Text(tutorName),
                children: [
                  ListTile(
                    title: Text('About: ${tutor['about']}'),
                  ),
                  ListTile(
                    title: Text('Email: ${tutor['email']}'),
                  ),
                  ListTile(
                    title: Text('Phone: ${tutor['phone']}'),
                  ),
                  ListTile(
                    title: Text('Teaching Experience: ${tutor['teachingExperience']}'),
                  ),
                  ListTile(
                    title: Text('Specialties: ${tutor['specialties'].join(', ')}'),
                  ),
                  ListTile(
                    title: Text('Languages: ${tutor['languages'].join(', ')}'),
                  ),
                  ListTile(
                    title: Text('Education: ${tutor['education']}'),
                  ),
                  ListTile(
                    title: Text('Gender: ${tutor['gender']}'),
                  ),
                  ListTile(
                    title: Text('Interests: ${tutor['interests']}'),
                  ),
                  ListTile(
                    title: Text('CV:'),
                    subtitle: Image.memory(
                      base64Decode(tutor['cv']),
                      width: 200, // Adjust width as needed
                      height: 200, // Adjust height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: Text('Profile Photo:'),
                    subtitle: Image.memory(
                      base64Decode(tutor['photo'] ?? ''),
                      width: 100, // Adjust width as needed
                      height: 100, // Adjust height as needed
                    fit: BoxFit.cover,
                  ),),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        onPressed: () => approveTutor(tutorId),
                        child: Text('Approve'),
                      ),
                      ElevatedButton(
                        onPressed: () => rejectTutor(tutorId),
                        child: Text('Reject'),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
