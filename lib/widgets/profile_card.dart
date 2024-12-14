import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutornest/models/studentModel.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();
  Student? _student;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _fetchStudentProfile();
  }

  // Function to fetch student profile from Firestore based on studentId stored in secure storage
  Future<void> _fetchStudentProfile() async {
    try {
      String? studentId = await _storage.read(key: 'userId');
      if (studentId != null) {
        // Fetch student data from Firestore using the student ID
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .get();

        if (doc.exists) {
          setState(() {
            // Create a Student object from the fetched document data
            _student = Student(
              studentId: doc.id,
              username: doc['username'],
              address: doc['address'],
              phone: doc['phone'],
              email: doc['email'] ?? '',
              country: doc['country'],
              gender: doc['gender'],
              photo: doc['photo'],
            );
          });
        } else {
          print('Student not found');
        }
      } else {
        print('No student ID found in secure storage');
      }
    } catch (e) {
      print('Error fetching student profile: $e');
    }
  }

  // Function to upload profile picture
  Future<void> _uploadProfilePicture() async {
    try {
      // Pick an image from gallery or camera
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });

        // Get the current user ID from secure storage
        String? studentId = await _storage.read(key: 'userId');

        if (studentId != null) {
          // Read the image file as bytes
          List<int> imageBytes = await _imageFile!.readAsBytes();

          // Convert image to base64
          String base64Image = base64Encode(imageBytes);

          // Update Firestore document with base64 encoded image
          await FirebaseFirestore.instance
              .collection('students')
              .doc(studentId)
              .update({
            'photo': base64Image,
          });

          // Refresh the profile to show the new image
          await _fetchStudentProfile();

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile picture updated successfully')),
          );
        }
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload profile picture')),
      );
    }
  }

  // Function to extract initials from the username
  String getInitials(String username) {
    List<String> nameParts = username.trim().split(' ');
    String initials = '';
    if (nameParts.isNotEmpty) {
      initials += nameParts[0][0].toUpperCase(); // First letter of first name
      if (nameParts.length > 1) {
        initials += nameParts[nameParts.length - 1][0].toUpperCase(); // First letter of last name
      }
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    if (_student == null) {
      return const Center(child: CircularProgressIndicator());
    }

    String initials = getInitials(_student!.username ?? 'Unknown');

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Profile Picture with Upload Option
              GestureDetector(
                onTap: _uploadProfilePicture,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue,
                      // Display base64 image if available
                      backgroundImage: _student!.photo != null && _student!.photo!.isNotEmpty
                          ? MemoryImage(base64Decode(_student!.photo!))
                          : null,
                      child: _student!.photo == null || _student!.photo!.isEmpty
                          ? Text(
                        initials,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : null,
                    ),
                    // Upload icon
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // User Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _student!.username ?? 'Unknown Name',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _student!.email,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}