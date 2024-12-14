// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AdminProfileEditPage extends StatefulWidget {
//   @override
//   _AdminProfileEditPageState createState() => _AdminProfileEditPageState();
// }
//
// class _AdminProfileEditPageState extends State<AdminProfileEditPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers for form fields
//   TextEditingController _nameController =
//   TextEditingController(text: "John Doe");
//   TextEditingController _addressController =
//   TextEditingController(text: "123 Main Street, Cityville");
//   TextEditingController _contactController =
//   TextEditingController(text: "1234567890");
//   TextEditingController _introductionController =
//   TextEditingController(text: "Experienced Admin with 5 years in management.");
//   TextEditingController _experienceController =
//   TextEditingController(text: "5 years in IT administration.");
//
//   // Variables for dropdown and radio buttons
//   String _selectedCountry = "United States"; // Ensure this matches one of the countries
//   String _selectedGender = "Male";
//
//   // Image picker
//   File? _imageFile;
//
//   final ImagePicker _picker = ImagePicker();
//
//   // List of countries (add more as needed)
//   List<String> _countries = [
//     "United States",
//     "Canada",
//     "United Kingdom",
//     "Australia",
//     "India",
//     // Add more countries here
//   ];
//
//   // List of genders
//   List<String> _genders = ["Male", "Female", "Other"];
//
//   // Function to pick image from gallery or camera
//   Future<void> _pickImage() async {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading: Icon(Icons.photo_library),
//                     title: Text('Photo Library'),
//                     onTap: () async {
//                       Navigator.of(context).pop();
//                       final pickedFile = await _picker.pickImage(
//                           source: ImageSource.gallery, imageQuality: 50);
//                       if (pickedFile != null) {
//                         setState(() {
//                           _imageFile = File(pickedFile.path);
//                         });
//                       }
//                     }),
//                 ListTile(
//                   leading: Icon(Icons.photo_camera),
//                   title: Text('Camera'),
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     final pickedFile = await _picker.pickImage(
//                         source: ImageSource.camera, imageQuality: 50);
//                     if (pickedFile != null) {
//                       setState(() {
//                         _imageFile = File(pickedFile.path);
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   // Function to handle Save
//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       // Here you can handle the saving logic, e.g., send data to backend
//       // For now, we'll just show a snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile Saved Successfully')),
//       );
//     }
//   }
//
//   // Function to handle Cancel
//   void _cancelEdit() {
//     // Reset the form to initial dummy data
//     setState(() {
//       _nameController.text = "John Doe";
//       _addressController.text = "123 Main Street, Cityville";
//       _contactController.text = "1234567890";
//       _introductionController.text =
//       "Experienced Admin with 5 years in management.";
//       _experienceController.text = "5 years in IT administration.";
//       _selectedCountry = "United States"; // Reset to "United States"
//       _selectedGender = "Male";
//       _imageFile = null;
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Edit Cancelled')),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers when the widget is disposed
//     _nameController.dispose();
//     _addressController.dispose();
//     _contactController.dispose();
//     _introductionController.dispose();
//     _experienceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Edit Admin Profile'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Admin Photo
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.grey[300],
//                     backgroundImage: _imageFile != null
//                         ? FileImage(_imageFile!)
//                         : AssetImage('assets/default_avatar.png')
//                     as ImageProvider,
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 20,
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 20,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Admin Name
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Address
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.home),
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Address is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Contact Number
//                 TextFormField(
//                   controller: _contactController,
//                   decoration: InputDecoration(
//                     labelText: 'Contact Number',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Contact number is required';
//                     }
//                     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Introduction
//                 TextFormField(
//                   controller: _introductionController,
//                   decoration: InputDecoration(
//                     labelText: 'Introduction',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.info),
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Introduction is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Experience
//                 TextFormField(
//                   controller: _experienceController,
//                   decoration: InputDecoration(
//                     labelText: 'Experience',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.work),
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Experience is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Country Dropdown
//                 DropdownButtonFormField<String>(
//                   value: _selectedCountry, // Must match one of the _countries
//                   decoration: InputDecoration(
//                     labelText: 'Country',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.flag),
//                   ),
//                   items: _countries
//                       .map((country) => DropdownMenuItem<String>(
//                     value: country,
//                     child: Text(country),
//                   ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedCountry = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Country is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Gender Radio Buttons
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Gender',
//                     style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey[700],
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 Column(
//                   children: _genders
//                       .map((gender) => RadioListTile<String>(
//                     title: Text(gender),
//                     value: gender,
//                     groupValue: _selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedGender = value!;
//                       });
//                     },
//                   ))
//                       .toList(),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Save and Cancel Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _saveProfile,
//                       child: Text('Save'),
//                       style: ElevatedButton.styleFrom(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                     ),
//                     OutlinedButton(
//                       onPressed: _cancelEdit,
//                       child: Text('Cancel'),
//                       style: OutlinedButton.styleFrom(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AdminProfileEditPage extends StatefulWidget {
//   @override
//   _AdminProfileEditPageState createState() => _AdminProfileEditPageState();
// }
//
// class _AdminProfileEditPageState extends State<AdminProfileEditPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers for form fields
//   TextEditingController _nameController =
//   TextEditingController(text: "John Doe");
//   TextEditingController _emailController =
//   TextEditingController(text: "admin@example.com"); // Added email controller
//   TextEditingController _addressController =
//   TextEditingController(text: "123 Main Street, Cityville");
//   TextEditingController _contactController =
//   TextEditingController(text: "1234567890");
//   TextEditingController _introductionController =
//   TextEditingController(text: "Experienced Admin with 5 years in management.");
//   TextEditingController _experienceController =
//   TextEditingController(text: "5 years in IT administration.");
//
//   // Variables for dropdown and radio buttons
//   String _selectedCountry = "United States"; // Ensure this matches one of the countries
//   String _selectedGender = "Male";
//
//   // Image picker
//   File? _imageFile;
//
//   final ImagePicker _picker = ImagePicker();
//
//   // List of countries (add more as needed)
//   List<String> _countries = [
//     "United States",
//     "Canada",
//     "United Kingdom",
//     "Australia",
//     "India",
//     // Add more countries here
//   ];
//
//   // List of genders
//   List<String> _genders = ["Male", "Female", "Other"];
//
//   // Function to pick image from gallery or camera
//   Future<void> _pickImage() async {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading: Icon(Icons.photo_library),
//                     title: Text('Photo Library'),
//                     onTap: () async {
//                       Navigator.of(context).pop();
//                       final pickedFile = await _picker.pickImage(
//                           source: ImageSource.gallery, imageQuality: 50);
//                       if (pickedFile != null) {
//                         setState(() {
//                           _imageFile = File(pickedFile.path);
//                         });
//                       }
//                     }),
//                 ListTile(
//                   leading: Icon(Icons.photo_camera),
//                   title: Text('Camera'),
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     final pickedFile = await _picker.pickImage(
//                         source: ImageSource.camera, imageQuality: 50);
//                     if (pickedFile != null) {
//                       setState(() {
//                         _imageFile = File(pickedFile.path);
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   // Function to handle Save
//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       // Here you can handle the saving logic, e.g., send data to backend
//       // For now, we'll just show a snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Profile Saved Successfully')),
//       );
//     }
//   }
//
//   // Function to handle Cancel
//   void _cancelEdit() {
//     // Reset the form to initial dummy data
//     setState(() {
//       _nameController.text = "John Doe";
//       _emailController.text = "admin@example.com"; // Reset email
//       _addressController.text = "123 Main Street, Cityville";
//       _contactController.text = "1234567890";
//       _introductionController.text =
//       "Experienced Admin with 5 years in management.";
//       _experienceController.text = "5 years in IT administration.";
//       _selectedCountry = "United States"; // Reset to "United States"
//       _selectedGender = "Male";
//       _imageFile = null;
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Edit Cancelled')),
//     );
//   }
//
//   // Function to handle Change Password
//   void _showChangePasswordDialog() {
//     final _changePasswordFormKey = GlobalKey<FormState>();
//     TextEditingController _oldPasswordController = TextEditingController();
//     TextEditingController _newPasswordController = TextEditingController();
//     TextEditingController _confirmPasswordController = TextEditingController();
//
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Change Password'),
//             content: SingleChildScrollView(
//               child: Form(
//                 key: _changePasswordFormKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Old Password
//                     TextFormField(
//                       controller: _oldPasswordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Old Password',
//                         prefixIcon: Icon(Icons.lock),
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Old password is required';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 15),
//
//                     // New Password
//                     TextFormField(
//                       controller: _newPasswordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'New Password',
//                         prefixIcon: Icon(Icons.lock_outline),
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'New password is required';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 15),
//
//                     // Confirm New Password
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Confirm New Password',
//                         prefixIcon: Icon(Icons.lock_outline),
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please confirm your new password';
//                         }
//                         if (value != _newPasswordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 child: Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ElevatedButton(
//                 child: Text('Change'),
//                 onPressed: () {
//                   if (_changePasswordFormKey.currentState!.validate()) {
//                     // Handle password change logic here
//                     // For now, just show a snackbar
//                     Navigator.of(context).pop();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Password Changed Successfully')),
//                     );
//                   }
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers when the widget is disposed
//     _nameController.dispose();
//     _emailController.dispose(); // Dispose email controller
//     _addressController.dispose();
//     _contactController.dispose();
//     _introductionController.dispose();
//     _experienceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Edit Admin Profile'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Admin Photo
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.grey[300],
//                     backgroundImage: _imageFile != null
//                         ? FileImage(_imageFile!)
//                         : AssetImage('assets/default_avatar.png')
//                     as ImageProvider,
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 20,
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 20,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Admin Name
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Email (Read-Only)
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   readOnly: true,
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Address
//                 TextFormField(
//                   controller: _addressController,
//                   decoration: InputDecoration(
//                     labelText: 'Address',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.home),
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Address is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Contact Number
//                 TextFormField(
//                   controller: _contactController,
//                   decoration: InputDecoration(
//                     labelText: 'Contact Number',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Contact number is required';
//                     }
//                     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Introduction
//                 TextFormField(
//                   controller: _introductionController,
//                   decoration: InputDecoration(
//                     labelText: 'Introduction',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.info),
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Introduction is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Admin Experience
//                 TextFormField(
//                   controller: _experienceController,
//                   decoration: InputDecoration(
//                     labelText: 'Experience',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.work),
//                   ),
//                   maxLines: 3,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Experience is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Country Dropdown
//                 DropdownButtonFormField<String>(
//                   value: _selectedCountry, // Must match one of the _countries
//                   decoration: InputDecoration(
//                     labelText: 'Country',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.flag),
//                   ),
//                   items: _countries
//                       .map((country) => DropdownMenuItem<String>(
//                     value: country,
//                     child: Text(country),
//                   ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedCountry = value!;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Country is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 15),
//
//                 // Gender Radio Buttons
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Gender',
//                     style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey[700],
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 Column(
//                   children: _genders
//                       .map((gender) => RadioListTile<String>(
//                     title: Text(gender),
//                     value: gender,
//                     groupValue: _selectedGender,
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedGender = value!;
//                       });
//                     },
//                   ))
//                       .toList(),
//                 ),
//                 SizedBox(height: 15),
//
//                 // Change Password Button
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton.icon(
//                     onPressed: _showChangePasswordDialog,
//                     icon: Icon(Icons.lock),
//                     label: Text('Change Password'),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//
//                 // Save and Cancel Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _saveProfile,
//                       child: Text('Save'),
//                       style: ElevatedButton.styleFrom(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                     ),
//                     OutlinedButton(
//                       onPressed: _cancelEdit,
//                       child: Text('Cancel'),
//                       style: OutlinedButton.styleFrom(
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfileEditPage extends StatefulWidget {
  @override
  _AdminProfileEditPageState createState() => _AdminProfileEditPageState();
}

class _AdminProfileEditPageState extends State<AdminProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  TextEditingController _nameController = TextEditingController(text: "John Doe");
  TextEditingController _emailController =
  TextEditingController(text: "admin@example.com"); // Added email controller
  TextEditingController _addressController =
  TextEditingController(text: "123 Main Street, Cityville");
  TextEditingController _contactController =
  TextEditingController(text: "1234567890");
  TextEditingController _introductionController =
  TextEditingController(text: "Experienced Admin with 5 years in management.");
  TextEditingController _experienceController =
  TextEditingController(text: "5 years in IT administration.");

  // Variables for dropdown and radio buttons
  String _selectedCountry = "United States"; // Ensure this matches one of the countries
  String _selectedGender = "Male";

  // Image picker
  File? _imageFile;
  bool _isPickingImage = false; // To show loading indicator when picking image

  final ImagePicker _picker = ImagePicker();

  // List of countries (add more as needed)
  List<String> _countries = [
    "United States",
    "Canada",
    "United Kingdom",
    "Australia",
    "India",
    // Add more countries here
  ];

  // List of genders
  List<String> _genders = ["Male", "Female", "Other"];

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    setState(() {
      _isPickingImage = true;
    });

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      final pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50);
                      if (pickedFile != null) {
                        setState(() {
                          _imageFile = File(pickedFile.path);
                        });
                      }
                      setState(() {
                        _isPickingImage = false;
                      });
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedFile = await _picker.pickImage(
                        source: ImageSource.camera, imageQuality: 50);
                    if (pickedFile != null) {
                      setState(() {
                        _imageFile = File(pickedFile.path);
                      });
                    }
                    setState(() {
                      _isPickingImage = false;
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Cancel'),
                  onTap: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isPickingImage = false;
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  // Function to handle Save
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Here you can handle the saving logic, e.g., send data to backend
      // For now, we'll just show a snackbar and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Saved Successfully')),
      );
      Navigator.of(context).pop(); // Navigate back after saving
    }
  }

  // Function to handle Cancel
  void _cancelEdit() {
    // Reset the form to initial dummy data
    setState(() {
      _nameController.text = "John Doe";
      _emailController.text = "admin@example.com"; // Reset email
      _addressController.text = "123 Main Street, Cityville";
      _contactController.text = "1234567890";
      _introductionController.text =
      "Experienced Admin with 5 years in management.";
      _experienceController.text = "5 years in IT administration.";
      _selectedCountry = "United States"; // Reset to "United States"
      _selectedGender = "Male";
      _imageFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit Cancelled')),
    );
    Navigator.of(context).pop(); // Navigate back after cancelling
  }

  // Function to handle Change Password
  void _showChangePasswordDialog() {
    final _changePasswordFormKey = GlobalKey<FormState>();
    TextEditingController _oldPasswordController = TextEditingController();
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password'),
            content: SingleChildScrollView(
              child: Form(
                key: _changePasswordFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Old Password
                    TextFormField(
                      controller: _oldPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Old password is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    // New Password
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'New password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    // Confirm New Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Change'),
                onPressed: () {
                  if (_changePasswordFormKey.currentState!.validate()) {
                    // Handle password change logic here
                    // For now, just show a snackbar and close the dialog
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password Changed Successfully')),
                    );
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose(); // Dispose email controller
    _addressController.dispose();
    _contactController.dispose();
    _introductionController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Admin Profile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Back button functionality
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Admin Photo
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage('assets/default_avatar.png') as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: _isPickingImage
                              ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Change Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _showChangePasswordDialog,
                    icon: Icon(Icons.lock),
                    label: Text('Change Password'),
                  ),
                ),
                SizedBox(height: 20),

                // Admin Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Admin Email (Read-Only)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 15),

                // Admin Address
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Admin Contact Number
                TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Contact number is required';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Admin Introduction
                TextFormField(
                  controller: _introductionController,
                  decoration: InputDecoration(
                    labelText: 'Introduction',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.info),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Introduction is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Admin Experience
                TextFormField(
                  controller: _experienceController,
                  decoration: InputDecoration(
                    labelText: 'Experience',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.work),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Experience is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Country Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCountry, // Must match one of the _countries
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.flag),
                  ),
                  items: _countries
                      .map((country) => DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Country is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // Gender Radio Buttons
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Column(
                  children: _genders
                      .map((gender) => RadioListTile<String>(
                    title: Text(gender),
                    value: gender,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ))
                      .toList(),
                ),
                SizedBox(height: 20),

                // Save and Cancel Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: _cancelEdit,
                      child: Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
