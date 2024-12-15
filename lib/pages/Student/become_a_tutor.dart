import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tutornest/models/tutorModel.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class BecomeATutorPage extends StatefulWidget {
  @override
  _BecomeATutorPageState createState() => _BecomeATutorPageState();
}

class _BecomeATutorPageState extends State<BecomeATutorPage> {
  final _formKey = GlobalKey<FormState>();
  String about = '';
  String education = '';
  List<String> languages = [];
  List<String> specialties = [];
  String interests = '';
  String teachingExperience = '';

  File? cvPhotoFile;
  String? cvPhotoBase64;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  final _imagePicker = ImagePicker();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();

  Future<void> _pickCvPhoto() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          cvPhotoFile = File(pickedFile.path);
          cvPhotoBase64 = base64Encode(cvPhotoFile!.readAsBytesSync());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking photo: $e")),
      );
    }
  }

  Future<void> _submitTutorForm() async {
    String? userId = await _storage.read(key: 'userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not found")),
      );
      return;
    }

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    if (userData['user_role'] != 'student') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Only students can become tutors")),
      );
      return;
    }

    DocumentSnapshot studentDoc = await FirebaseFirestore.instance.collection('students').doc(userId).get();

    if (!studentDoc.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Student data not found")),
      );
      return;
    }

    Map<String, dynamic> studentData = studentDoc.data() as Map<String, dynamic>;


    Tutor tutor = Tutor(
      tutorId: userId,
      username: studentData['username'],
      address: studentData['address'],
      phone: studentData['phone'],
      email: studentData['email'],
      country: studentData['country'],
      gender: studentData['gender'],
      photo: studentData['photo'],
      about: about,
      education: education,
      languages: languages,
      specialties: specialties,
      interests: interests,
      teachingExperience: teachingExperience,
      cv: cvPhotoBase64,
    );

    await FirebaseFirestore.instance.collection('tutors').doc(userId).set(tutor.toFirestore());

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'user_role': 'tutor',
    });

    await FirebaseFirestore.instance.collection('students').doc(userId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tutor registered. wait untill your application is vverified")),
    );

    _storage.delete(key: 'userId');
    Navigator.pushNamedAndRemoveUntil(context, '/processing', (route) => false);}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Become a Tutor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'About'),
                onChanged: (value) => setState(() => about = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Education'),
                onChanged: (value) => setState(() => education = value),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Languages', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _languageController,
                          decoration: InputDecoration(
                            hintText: 'Add a language',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (_languageController.text.isNotEmpty) {
                            setState(() {
                              languages.add(_languageController.text);
                              _languageController.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Wrap(
                    children: languages
                        .map((language) => Chip(
                      label: Text(language),
                      onDeleted: () {
                        setState(() {
                          languages.remove(language);
                        });
                      },
                    ))
                        .toList(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Specialties', style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _specialtyController,
                          decoration: InputDecoration(
                            hintText: 'Add a specialty',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (_specialtyController.text.isNotEmpty) {
                            setState(() {
                              specialties.add(_specialtyController.text);
                              _specialtyController.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Wrap(
                    children: specialties
                        .map((specialty) => Chip(
                      label: Text(specialty),
                      onDeleted: () {
                        setState(() {
                          specialties.remove(specialty);
                        });
                      },
                    ))
                        .toList(),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Interests'),
                onChanged: (value) => setState(() => interests = value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teaching Experience'),
                onChanged: (value) => setState(() => teachingExperience = value),
              ),
              ElevatedButton(
                onPressed: _pickCvPhoto,
                child: Text("Add CV Photo"),
              ),
              if (cvPhotoFile != null) ...[
                Image.file(
                  cvPhotoFile!,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ],
              ElevatedButton(
                onPressed: _submitTutorForm,
                child: Text("Become Tutor"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

