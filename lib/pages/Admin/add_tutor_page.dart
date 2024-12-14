import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';  // Import image_picker
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tutornest/models/tutorModel.dart';

class AddTutorPage extends StatefulWidget {
  @override
  _AddTutorPageState createState() => _AddTutorPageState();
}

class _AddTutorPageState extends State<AddTutorPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Controller for text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _interestsController = TextEditingController();
  final TextEditingController _teachingExpController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();

  // Dropdown values
  String? _selectedGender;
  File? _profilePhoto;
  File? _cvFile;

  // Multi-select fields
  List<String> _selectedLanguages = [];
  List<String> _selectedSpecialties = [];

  // Language and Specialty options
  final List<String> _languageOptions = [
    'English', 'Spanish', 'Nepali', 'German', 'Arabic', 'Hindi', 'Russian'
  ];

  final List<String> _specialtyOptions = [
    'Math', 'Science', 'Language', 'History',
    'Computer Science', 'Art', 'Music'
  ];

  // Image Picker instance
  final ImagePicker _picker = ImagePicker();

  // Function to pick profile photo using image_picker
  Future<void> _pickProfilePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // You can change to ImageSource.camera for camera
      imageQuality: 75, // Optional: Reduce quality for faster upload
    );

    if (image != null) {
      setState(() {
        _profilePhoto = File(image.path);
      });
    }
  }

  // Function to pick CV file
  Future<void> _pickCVFile() async {

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // You can change to ImageSource.camera for camera
      imageQuality: 75, // Optional: Reduce quality for faster upload
    );

    if (image != null) {
      setState(() {
        _cvFile = File(image.path);
      });
    }
  }

  String? _convertFileToBase64(File? file) {
    if (file == null) return null;
    try {
      List<int> fileBytes = file.readAsBytesSync();
      return base64Encode(fileBytes);
    } catch (e) {
      print('Error converting file to base64: $e');
      return null;
    }
  }

  void _addSpecialty() {
    final specialty = _specialtyController.text.trim();
    if (specialty.isNotEmpty) {
      setState(() {
        if (!_selectedSpecialties.contains(specialty)) {
          _selectedSpecialties.add(specialty);
          _specialtyController.clear(); // Clear the text field after adding
        }
      });
    }
  }

  void _removeSpecialty(String specialty) {
    setState(() {
      _selectedSpecialties.remove(specialty);
    });
  }

  // Function to upload file to Firebase Storage
  Future<String?> _uploadFile(File file, String folder) async {
    try {
      Reference reference = _storage.ref('$folder/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  // Function to submit the tutor's data
  Future<void> _submitTutor() async {
    if (_formKey.currentState!.validate()) {
      try {
        String? photoBase64 = _convertFileToBase64(_profilePhoto);
        String? cvBase64 = _convertFileToBase64(_cvFile);

        Tutor newTutor = Tutor(
          tutorId: '',
          username: _usernameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          country: _countryController.text,
          gender: _selectedGender,
          photo: photoBase64,
          about: _aboutController.text,
          education: _educationController.text,
          languages: _selectedLanguages,
          specialties: _selectedSpecialties,
          interests: _interestsController.text,
          teachingExperience: _teachingExpController.text,
          isVerified: true,
          cv: cvBase64,
        );

        await _firestore.collection('tutors').add(newTutor.toFirestore());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tutor added successfully!')));
        _resetForm();
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding tutor: $e')));
      }
    }
  }

  // Function to reset the form
  void _resetForm() {
    _formKey.currentState!.reset();
    _usernameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _countryController.clear();
    _aboutController.clear();
    _educationController.clear();
    _interestsController.clear();
    _teachingExpController.clear();

    setState(() {
      _selectedGender = null;
      _profilePhoto = null;
      _cvFile = null;
      _selectedLanguages.clear();
      _selectedSpecialties.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Tutor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickProfilePhoto,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  child: _profilePhoto != null
                      ? ClipOval(
                    child: Image.file(
                      _profilePhoto!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Icon(Icons.camera_alt, size: 40),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter username' : null,
              ),
              SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter email';
                  // Basic email validation
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
              ),
              SizedBox(height: 16),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                value: _selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) => value == null ? 'Please select gender' : null,
              ),
              SizedBox(height: 16),

              // Languages Multi-Select
              MultiSelectChip(
                title: 'Languages',
                items: _languageOptions,
                selectedItems: _selectedLanguages,
                onSelectionChanged: (selectedItems) {
                  setState(() {
                    _selectedLanguages = selectedItems;
                  });
                },
              ),
              SizedBox(height: 16),

              // Specialties Multi-Select
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _specialtyController,
                      decoration: InputDecoration(
                        labelText: 'Add Specialty',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addSpecialty,
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Displayed Specialties
              if (_selectedSpecialties.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _selectedSpecialties.map((specialty) {
                    return Chip(
                      label: Text(specialty),
                      onDeleted: () => _removeSpecialty(specialty),
                      deleteIcon: Icon(Icons.close),
                    );
                  }).toList(),
                ),
              SizedBox(height: 16),
              SizedBox(height: 16),

              // CV File Picker
              ElevatedButton.icon(
                onPressed: _pickCVFile,
                icon: Icon(Icons.upload_file),
                label: Text(_cvFile != null
                    ? 'CV Selected: ${_cvFile!.path.split('/').last}'
                    : 'Upload CV'),
              ),
              SizedBox(height: 16),

              // Additional Text Fields
              TextFormField(
                controller: _aboutController,
                decoration: InputDecoration(
                  labelText: 'About',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _educationController,
                decoration: InputDecoration(
                  labelText: 'Education',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _interestsController,
                decoration: InputDecoration(
                  labelText: 'Interests',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _teachingExpController,
                decoration: InputDecoration(
                  labelText: 'Teaching Experience',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitTutor,
                child: Text('Add Tutor'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Multi-Select Chip Widget
class MultiSelectChip extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectChip({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: widget.items.map((item) {
            bool isSelected = widget.selectedItems.contains(item);
            return ChoiceChip(
              label: Text(item),
              selected: isSelected,
              onSelected: (bool selected) {
                List<String> updatedSelection = List.from(widget.selectedItems);
                if (selected) {
                  updatedSelection.add(item);
                } else {
                  updatedSelection.remove(item);
                }
                widget.onSelectionChanged(updatedSelection);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}