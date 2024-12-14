// // lib/pages/tutor/edit_profile_page.dart
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // Controllers for form fields initialized with dummy data
//   final TextEditingController nameController =
//   TextEditingController(text: "John Doe");
//   final TextEditingController fromController =
//   TextEditingController(text: "New York, USA");
//   final TextEditingController dobController =
//   TextEditingController(text: "1990-01-01");
//   final TextEditingController interestsController =
//   TextEditingController(text: "Mathematics, Physics");
//   final TextEditingController educationController =
//   TextEditingController(text: "M.Sc. in Mathematics");
//   final TextEditingController experienceController =
//   TextEditingController(text: "5 years teaching experience");
//   final TextEditingController professionController =
//   TextEditingController(text: "Senior Tutor");
//   final TextEditingController instructionController =
//   TextEditingController(text: "I specialize in Algebra and Calculus");
//   final TextEditingController languagesController =
//   TextEditingController(text: "English, Spanish");
//
//   // Email address controller (not editable)
//   final TextEditingController emailController =
//   TextEditingController(text: "johndoe@example.com");
//
//   // Profile image
//   File? profileImage;
//
//   final ImagePicker _imagePicker = ImagePicker();
//
//   // Function to pick profile image
//   Future<void> _pickProfileImage() async {
//     try {
//       final pickedFile =
//       await _imagePicker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           profileImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       // Handle any errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error picking image: $e")),
//       );
//     }
//   }
//
//   // Function to show Change Password dialog
//   void _showChangePasswordDialog() {
//     final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
//     final TextEditingController oldPasswordController =
//     TextEditingController();
//     final TextEditingController newPasswordController =
//     TextEditingController();
//     final TextEditingController confirmPasswordController =
//     TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Change Password"),
//           content: Form(
//             key: _passwordFormKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Old Password
//                   TextFormField(
//                     controller: oldPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Old Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your old password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   // New Password
//                   TextFormField(
//                     controller: newPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "New Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a new password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password should be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   // Confirm New Password
//                   TextFormField(
//                     controller: confirmPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Confirm New Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm your new password';
//                       }
//                       if (value != newPasswordController.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_passwordFormKey.currentState!.validate()) {
//                   // Implement password change logic here
//                   // For now, just show a success message
//                   Navigator.of(context).pop(); // Close dialog
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Password changed successfully.")),
//                   );
//                 }
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Function to handle Save action
//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       // Implement profile update logic here
//       // For now, just show a success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Profile updated successfully.")),
//       );
//       Navigator.of(context).pop(); // Navigate back to settings page
//     }
//   }
//
//   // Function to handle Cancel action
//   void _cancelEdit() {
//     // Optionally, confirm cancellation
//     showDialog(
//       context: context,
//       builder: (context) =>
//           AlertDialog(
//             title: Text("Discard Changes?"),
//             content: Text("Are you sure you want to discard your changes?"),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(), // Close dialog
//                 child: Text("No"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                   Navigator.of(context).pop(); // Navigate back to settings page
//                 },
//                 child: Text("Yes"),
//               ),
//             ],
//           ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers
//     nameController.dispose();
//     fromController.dispose();
//     dobController.dispose();
//     interestsController.dispose();
//     educationController.dispose();
//     experienceController.dispose();
//     professionController.dispose();
//     instructionController.dispose();
//     languagesController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Image Section
//               GestureDetector(
//                 onTap: _pickProfileImage,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage: profileImage != null
//                       ? FileImage(profileImage!)
//                       : AssetImage('assets/profile_placeholder.png')
//                   as ImageProvider,
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 20,
//                       child: Icon(
//                         Icons.edit,
//                         color: Colors.blue,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Name Field
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: "Name *",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // From Field
//               TextFormField(
//                 controller: fromController,
//                 decoration: InputDecoration(
//                   labelText: "From *",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your location';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Date of Birth Field
//               GestureDetector(
//                 onTap: () => _selectDate(context, dobController),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     controller: dobController,
//                     decoration: InputDecoration(
//                       labelText: "Date of Birth *",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Interests Field
//               TextFormField(
//                 controller: interestsController,
//                 decoration: InputDecoration(
//                   labelText: "Interests *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your interests';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Education Field
//               TextFormField(
//                 controller: educationController,
//                 decoration: InputDecoration(
//                   labelText: "Education *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your education details';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Experience Field
//               TextFormField(
//                 controller: experienceController,
//                 decoration: InputDecoration(
//                   labelText: "Experience *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your experience';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Profession Field
//               TextFormField(
//                 controller: professionController,
//                 decoration: InputDecoration(
//                   labelText: "Current or Previous Profession *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your profession';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Instruction Field
//               TextFormField(
//                 controller: instructionController,
//                 decoration: InputDecoration(
//                   labelText: "Instruction *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your teaching instructions';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Languages Field
//               TextFormField(
//                 controller: languagesController,
//                 decoration: InputDecoration(
//                   labelText: "Languages *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the languages you speak';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               // Email Address Field (Non-editable)
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email Address *",
//                   border: OutlineInputBorder(),
//                 ),
//                 enabled: false, // Make the field non-editable
//               ),
//               SizedBox(height: 20),
//               // Change Password Button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: _showChangePasswordDialog,
//                   child: Text(
//                     "Change Password",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               // Save and Cancel Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Cancel Button
//                   ElevatedButton(
//                     onPressed: _cancelEdit,
//                     child: Text("Cancel"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey, // Grey background color
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     ),
//                   ),
//                   // Save Button
//                   ElevatedButton(
//                     onPressed: _saveProfile,
//                     child: Text("Save"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Blue background color
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     // Function to select date using DatePicker
//     Future<void> _selectDate(BuildContext context,
//         TextEditingController controller) async {
//       DateTime initialDate = DateTime(1990);
//       DateTime firstDate = DateTime(1900);
//       DateTime lastDate = DateTime.now();
//
//       final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: firstDate,
//         lastDate: lastDate,
//       );
//
//       if (picked != null) {
//         setState(() {
//           controller.text = "${picked.toLocal()}".split(' ')[0];
//         });
//       }
//     }
//   }
// }

// // lib/pages/tutor/edit_profile_page.dart
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:video_player/video_player.dart';
// // import '../../models/user_profile.dart'; // Import UserProfile model
// // import '../../services/settings_service.dart'; // Import SettingsService
//
// // Certificate Model
// class Certificate {
//   String type;
//   File file;
//
//   Certificate({required this.type, required this.file});
// }
//
// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   // final SettingsService _settingsService = SettingsService(); // Instantiate the service
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // Controllers for form fields initialized with dummy data
//   final TextEditingController nameController =
//   TextEditingController(text: "John Doe");
//   final TextEditingController fromController =
//   TextEditingController(text: "New York, USA");
//   final TextEditingController dobController =
//   TextEditingController(text: "1990-01-01");
//   final TextEditingController interestsController =
//   TextEditingController(text: "Mathematics, Physics");
//   final TextEditingController educationController =
//   TextEditingController(text: "M.Sc. in Mathematics");
//   final TextEditingController experienceController =
//   TextEditingController(text: "5 years teaching experience");
//   final TextEditingController professionController =
//   TextEditingController(text: "Senior Tutor");
//   final TextEditingController instructionController =
//   TextEditingController(text: "I specialize in Algebra and Calculus");
//   final TextEditingController languagesController =
//   TextEditingController(text: "English, Spanish");
//
//   // Email address controller (not editable)
//   final TextEditingController emailController =
//   TextEditingController(text: "johndoe@example.com");
//
//   // Profile image
//   File? profileImage;
//
//   // Video Introduction
//   File? videoFile;
//   VideoPlayerController? _videoController;
//
//   // Certificates
//   List<Certificate> certificates = [];
//
//   final ImagePicker _imagePicker = ImagePicker();
//
//   // Function to pick profile image
//   Future<void> _pickProfileImage() async {
//     try {
//       final pickedFile =
//       await _imagePicker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           profileImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       // Handle any errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error picking image: $e")),
//       );
//     }
//   }
//
//   // Function to pick video introduction
//   Future<void> _pickVideoIntroduction() async {
//     try {
//       final pickedFile =
//       await _imagePicker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         _videoController?.dispose();
//         _videoController = VideoPlayerController.file(File(pickedFile.path))
//           ..initialize().then((_) {
//             setState(() {
//               videoFile = File(pickedFile.path);
//               _videoController!.setLooping(true);
//               _videoController!.play();
//             });
//           });
//       }
//     } catch (e) {
//       // Handle any errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error picking video: $e")),
//       );
//     }
//   }
//
//   // Function to add a new certificate
//   void _addCertificate() async {
//     String? selectedType; // Initialize as null
//     File? uploadedFile;
//     final _dialogFormKey = GlobalKey<FormState>(); // Form key for the dialog
//     final TextEditingController customTypeController =
//     TextEditingController(); // Declare the controller
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text("Add New Certificate"),
//             content: Form(
//               key: _dialogFormKey, // Assign the form key
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedType,
//                       items: ["IELTS", "TOEFL", "Other"].map((cert) {
//                         return DropdownMenuItem(
//                           value: cert,
//                           child: Text(cert),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedType = value;
//                           if (value != "Other") {
//                             customTypeController.text = "";
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Certificate Type",
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a certification type';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     if (selectedType == "Other")
//                       TextFormField(
//                         controller: customTypeController,
//                         decoration: InputDecoration(
//                           labelText: "Enter Certification Type",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (selectedType == "Other") {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter the certification type';
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           FilePickerResult? result = await FilePicker.platform
//                               .pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
//                           );
//                           if (result != null &&
//                               result.files.single.path != null) {
//                             File selectedFile = File(result.files.single.path!);
//                             final fileSize = await selectedFile.length();
//                             if (fileSize > 64 * 1024 * 1024) {
//                               setStateDialog(() {
//                                 uploadedFile = null;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text("File size exceeds 64 MB.")),
//                               );
//                               return;
//                             }
//                             setStateDialog(() {
//                               uploadedFile = selectedFile;
//                             });
//                           }
//                         } catch (e) {
//                           // Handle any errors
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Error picking file: $e")),
//                           );
//                         }
//                       },
//                       child: Text("Upload Certificate"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                         Colors.blue, // Button background color
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     if (uploadedFile != null)
//                       Text(
//                         uploadedFile!.path.split('/').last,
//                         style: TextStyle(color: Colors.green),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_dialogFormKey.currentState!.validate()) {
//                     if (uploadedFile != null) {
//                       String finalType = selectedType!;
//                       if (selectedType == "Other") {
//                         finalType = customTypeController.text.trim();
//                       }
//                       setState(() {
//                         certificates.add(Certificate(
//                             type: finalType, file: uploadedFile!));
//                       });
//                       Navigator.of(context).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content: Text(
//                                 "Certificate added successfully.")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Please upload a certificate file")),
//                       );
//                     }
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                   Colors.blue, // Button background color
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
//
//     // Dispose the controller after the dialog is closed
//     customTypeController.dispose();
//   }
//
//   // Function to edit an existing certificate
//   void _editCertificate(int index) async {
//     String? selectedType = certificates[index].type;
//     File? uploadedFile = certificates[index].file;
//     final _dialogFormKey = GlobalKey<FormState>();
//     final TextEditingController customTypeController =
//     TextEditingController(text: selectedType == "Other" ? selectedType : "");
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text("Edit Certificate"),
//             content: Form(
//               key: _dialogFormKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedType == "Other" ? null : selectedType,
//                       items: ["IELTS", "TOEFL", "Other"].map((cert) {
//                         return DropdownMenuItem(
//                           value: cert,
//                           child: Text(cert),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedType = value;
//                           if (value != "Other") {
//                             customTypeController.text = "";
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Certificate Type",
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a certification type';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     if (selectedType == "Other")
//                       TextFormField(
//                         controller: customTypeController,
//                         decoration: InputDecoration(
//                           labelText: "Enter Certification Type",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (selectedType == "Other") {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter the certification type';
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           FilePickerResult? result = await FilePicker.platform
//                               .pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
//                           );
//                           if (result != null &&
//                               result.files.single.path != null) {
//                             File selectedFile = File(result.files.single.path!);
//                             final fileSize = await selectedFile.length();
//                             if (fileSize > 64 * 1024 * 1024) {
//                               setStateDialog(() {
//                                 uploadedFile = null;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text("File size exceeds 64 MB.")),
//                               );
//                               return;
//                             }
//                             setStateDialog(() {
//                               uploadedFile = selectedFile;
//                             });
//                           }
//                         } catch (e) {
//                           // Handle any errors
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Error picking file: $e")),
//                           );
//                         }
//                       },
//                       child: Text("Upload Certificate"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                         Colors.blue, // Button background color
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     if (uploadedFile != null)
//                       Text(
//                         uploadedFile!.path.split('/').last,
//                         style: TextStyle(color: Colors.green),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_dialogFormKey.currentState!.validate()) {
//                     if (uploadedFile != null) {
//                       String finalType = selectedType!;
//                       if (selectedType == "Other") {
//                         finalType = customTypeController.text.trim();
//                       }
//                       setState(() {
//                         certificates[index] =
//                             Certificate(type: finalType, file: uploadedFile!);
//                       });
//                       Navigator.of(context).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content: Text(
//                                 "Certificate updated successfully.")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Please upload a certificate file")),
//                       );
//                     }
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                   Colors.blue, // Button background color
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
//
//     // Dispose the controller after the dialog is closed
//     customTypeController.dispose();
//   }
//
//   // Function to delete a certificate with confirmation
//   void _deleteCertificate(int index) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Delete Certificate"),
//           content: Text("Are you sure you want to delete this certificate?"),
//           actions: [
//             TextButton(
//               child: Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.blue),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             ElevatedButton(
//               child: Text("Delete"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                 Colors.red, // Red color for delete action
//               ),
//               onPressed: () {
//                 setState(() {
//                   certificates.removeAt(index);
//                 });
//                 Navigator.of(context).pop(); // Close the dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Certificate deleted successfully.")),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Function to show Change Password dialog
//   void _showChangePasswordDialog() {
//     final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
//     final TextEditingController oldPasswordController =
//     TextEditingController();
//     final TextEditingController newPasswordController =
//     TextEditingController();
//     final TextEditingController confirmPasswordController =
//     TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Change Password"),
//           content: Form(
//             key: _passwordFormKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Old Password
//                   TextFormField(
//                     controller: oldPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Old Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your old password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   // New Password
//                   TextFormField(
//                     controller: newPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "New Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a new password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password should be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   // Confirm New Password
//                   TextFormField(
//                     controller: confirmPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Confirm New Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm your new password';
//                       }
//                       if (value != newPasswordController.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_passwordFormKey.currentState!.validate()) {
//                   // Implement password change logic here
//                   // For now, just show a success message
//                   Navigator.of(context).pop(); // Close dialog
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Password changed successfully.")),
//                   );
//                 }
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Function to handle Save action
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       // Optionally, you can show a loading indicator while saving
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(child: CircularProgressIndicator()),
//       );
//
//       // Create an updated UserProfile instance
//       UserProfile updatedProfile = UserProfile(
//         name: nameController.text.trim(),
//         email: emailController.text.trim(),
//         role: "Tutor", // Assuming role remains the same
//         profileImagePath:
//         profileImage != null ? profileImage!.path : null, // Update path
//       );
//
//       // Simulate updating the profile via the service
//       // bool success = await _settingsService.updateUserProfile(updatedProfile);
//
//       // Remove the loading indicator
//   //     Navigator.of(context).pop();
//   //
//   //     if (success) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text("Profile updated successfully.")),
//   //       );
//   //       Navigator.of(context).pop(); // Navigate back to settings page
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text("Failed to update profile.")),
//   //       );
//   //     }
//   //   }
//   // }
//
//   // Function to handle Cancel action
//   void _cancelEdit() {
//     // Optionally, confirm cancellation
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Discard Changes?"),
//         content: Text("Are you sure you want to discard your changes?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(), // Close dialog
//             child: Text("No"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//               Navigator.of(context).pop(); // Navigate back to settings page
//             },
//             child: Text("Yes"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Function to select date using DatePicker
//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     DateTime initialDate = DateTime(1990);
//     DateTime firstDate = DateTime(1900);
//     DateTime lastDate = DateTime.now();
//
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: firstDate,
//       lastDate: lastDate,
//     );
//
//     if (picked != null) {
//       setState(() {
//         controller.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers
//     nameController.dispose();
//     fromController.dispose();
//     dobController.dispose();
//     interestsController.dispose();
//     educationController.dispose();
//     experienceController.dispose();
//     professionController.dispose();
//     instructionController.dispose();
//     languagesController.dispose();
//     emailController.dispose();
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   // Function to edit an existing certificate
//   void _editCertificate(int index) async {
//     String? selectedType = certificates[index].type;
//     File? uploadedFile = certificates[index].file;
//     final _dialogFormKey = GlobalKey<FormState>();
//     final TextEditingController customTypeController =
//     TextEditingController(text: selectedType == "Other" ? selectedType : "");
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text("Edit Certificate"),
//             content: Form(
//               key: _dialogFormKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedType == "Other" ? null : selectedType,
//                       items: ["IELTS", "TOEFL", "Other"].map((cert) {
//                         return DropdownMenuItem(
//                           value: cert,
//                           child: Text(cert),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedType = value;
//                           if (value != "Other") {
//                             customTypeController.text = "";
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Certificate Type",
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a certification type';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     if (selectedType == "Other")
//                       TextFormField(
//                         controller: customTypeController,
//                         decoration: InputDecoration(
//                           labelText: "Enter Certification Type",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (selectedType == "Other") {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter the certification type';
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           FilePickerResult? result = await FilePicker.platform
//                               .pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
//                           );
//                           if (result != null &&
//                               result.files.single.path != null) {
//                             File selectedFile = File(result.files.single.path!);
//                             final fileSize = await selectedFile.length();
//                             if (fileSize > 64 * 1024 * 1024) {
//                               setStateDialog(() {
//                                 uploadedFile = null;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text("File size exceeds 64 MB.")),
//                               );
//                               return;
//                             }
//                             setStateDialog(() {
//                               uploadedFile = selectedFile;
//                             });
//                           }
//                         } catch (e) {
//                           // Handle any errors
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Error picking file: $e")),
//                           );
//                         }
//                       },
//                       child: Text("Upload Certificate"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                         Colors.blue, // Button background color
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     if (uploadedFile != null)
//                       Text(
//                         uploadedFile!.path.split('/').last,
//                         style: TextStyle(color: Colors.green),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_dialogFormKey.currentState!.validate()) {
//                     if (uploadedFile != null) {
//                       String finalType = selectedType!;
//                       if (selectedType == "Other") {
//                         finalType = customTypeController.text.trim();
//                       }
//                       setState(() {
//                         certificates[index] =
//                             Certificate(type: finalType, file: uploadedFile!);
//                       });
//                       Navigator.of(context).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content: Text(
//                                 "Certificate updated successfully.")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Please upload a certificate file")),
//                       );
//                     }
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                   Colors.blue, // Button background color
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
//
//     // Dispose the controller after the dialog is closed
//     customTypeController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Image Section
//               GestureDetector(
//                 onTap: _pickProfileImage,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage: profileImage != null
//                       ? FileImage(profileImage!)
//                       : AssetImage('assets/profile_placeholder.png')
//                   as ImageProvider,
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 20,
//                       child: Icon(
//                         Icons.edit,
//                         color: Colors.blue,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Name Field
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: "Name *",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // From Field
//               TextFormField(
//                 controller: fromController,
//                 decoration: InputDecoration(
//                   labelText: "From *",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your location';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Date of Birth Field
//               GestureDetector(
//                 onTap: () => _selectDate(context, dobController),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     controller: dobController,
//                     decoration: InputDecoration(
//                       labelText: "Date of Birth *",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Interests Field
//               TextFormField(
//                 controller: interestsController,
//                 decoration: InputDecoration(
//                   labelText: "Interests *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your interests';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Education Field
//               TextFormField(
//                 controller: educationController,
//                 decoration: InputDecoration(
//                   labelText: "Education *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your education details';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Experience Field
//               TextFormField(
//                 controller: experienceController,
//                 decoration: InputDecoration(
//                   labelText: "Experience *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your experience';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Profession Field
//               TextFormField(
//                 controller: professionController,
//                 decoration: InputDecoration(
//                   labelText: "Current or Previous Profession *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your profession';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Instruction Field
//               TextFormField(
//                 controller: instructionController,
//                 decoration: InputDecoration(
//                   labelText: "Instruction *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your teaching instructions';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Languages Field
//               TextFormField(
//                 controller: languagesController,
//                 decoration: InputDecoration(
//                   labelText: "Languages *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the languages you speak';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               // Email Address Field (Non-editable)
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email Address *",
//                   border: OutlineInputBorder(),
//                 ),
//                 enabled: false, // Make the field non-editable
//               ),
//               SizedBox(height: 20),
//               // Change Password Button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: _showChangePasswordDialog,
//                   child: Text(
//                     "Change Password",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               // Video Introduction Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Video Introduction",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: _pickVideoIntroduction,
//                     icon: Icon(Icons.edit, color: Colors.white),
//                     label: Text(
//                       "Edit Video",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Colors.blue, // Button background color
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               if (videoFile != null &&
//                   _videoController != null &&
//                   _videoController!.value.isInitialized)
//                 Column(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: _videoController!.value.aspectRatio,
//                       child: VideoPlayer(_videoController!),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.replay_10, color: Colors.blue),
//                           onPressed: () {
//                             final currentPosition =
//                                 _videoController!.value.position;
//                             final newPosition =
//                                 currentPosition - Duration(seconds: 10);
//                             _videoController!.seekTo(newPosition >= Duration.zero
//                                 ? newPosition
//                                 : Duration.zero);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             _videoController!.value.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             color: Colors.blue,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (_videoController!.value.isPlaying) {
//                                 _videoController!.pause();
//                               } else {
//                                 _videoController!.play();
//                               }
//                             });
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.forward_10, color: Colors.blue),
//                           onPressed: () {
//                             final currentPosition =
//                                 _videoController!.value.position;
//                             final maxPosition =
//                                 _videoController!.value.duration;
//                             final newPosition =
//                                 currentPosition + Duration(seconds: 10);
//                             _videoController!.seekTo(newPosition <= maxPosition
//                                 ? newPosition
//                                 : maxPosition);
//                           },
//                         ),
//                       ],
//                     ),
//                     VideoProgressIndicator(
//                       _videoController!,
//                       allowScrubbing: true,
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       colors: VideoProgressColors(
//                         playedColor: Colors.blue,
//                         bufferedColor: Colors.grey,
//                         backgroundColor: Colors.grey.shade300,
//                       ),
//                     ),
//                   ],
//                 )
//               else
//                 Text(
//                   "No video uploaded.",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               // Certificates Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Certificates",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: _addCertificate,
//                     icon: Icon(Icons.add, color: Colors.white),
//                     label: Text(
//                       "Add Certificate",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Colors.blue, // Button background color
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               certificates.isNotEmpty
//                   ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: certificates.length,
//                 itemBuilder: (context, index) {
//                   final cert = certificates[index];
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       leading: Icon(Icons.verified, color: Colors.green),
//                       title: Text(cert.type),
//                       subtitle: Text(cert.file.path.split('/').last),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () => _editCertificate(index),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete, color: Colors.red),
//                             onPressed: () => _deleteCertificate(index),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//                   : Text(
//                 "No certificates added.",
//                 style: TextStyle(color: Colors.grey),
//               ),
//               SizedBox(height: 30),
//               // Save and Cancel Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Cancel Button
//                   ElevatedButton(
//                     onPressed: _cancelEdit,
//                     child: Text("Cancel"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey, // Grey background color
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     ),
//                   ),
//                   // Save Button
//                   ElevatedButton(
//                     onPressed: _saveProfile,
//                     child: Text("Save"),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.blue, // Blue background color
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/pages/tutor/edit_profile_page.dart

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:video_player/video_player.dart';
//
// /// Certificate Model
// class Certificate {
//   String type;
//   File file;
//
//   Certificate({required this.type, required this.file});
// }
//
// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // Controllers for form fields initialized with dummy data
//   final TextEditingController nameController =
//   TextEditingController(text: "John Doe");
//   final TextEditingController fromController =
//   TextEditingController(text: "New York, USA");
//   final TextEditingController dobController =
//   TextEditingController(text: "1990-01-01");
//   final TextEditingController interestsController =
//   TextEditingController(text: "Mathematics, Physics");
//   final TextEditingController educationController =
//   TextEditingController(text: "M.Sc. in Mathematics");
//   final TextEditingController experienceController =
//   TextEditingController(text: "5 years teaching experience");
//   final TextEditingController professionController =
//   TextEditingController(text: "Senior Tutor");
//   final TextEditingController instructionController =
//   TextEditingController(text: "I specialize in Algebra and Calculus");
//   final TextEditingController languagesController =
//   TextEditingController(text: "English, Spanish");
//
//   // Email address controller (non-editable)
//   final TextEditingController emailController =
//   TextEditingController(text: "johndoe@example.com");
//
//   // Profile image
//   File? profileImage;
//
//   // Video Introduction
//   File? videoFile;
//   VideoPlayerController? _videoController;
//
//   // Certificates
//   List<Certificate> certificates = [];
//
//   final ImagePicker _imagePicker = ImagePicker();
//
//   /// Function to pick profile image
//   Future<void> _pickProfileImage() async {
//     try {
//       final pickedFile =
//       await _imagePicker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           profileImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       // Handle any errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error picking image: $e")),
//       );
//     }
//   }
//
//   /// Function to pick video introduction
//   Future<void> _pickVideoIntroduction() async {
//     try {
//       final pickedFile =
//       await _imagePicker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         _videoController?.dispose();
//         _videoController = VideoPlayerController.file(File(pickedFile.path))
//           ..initialize().then((_) {
//             setState(() {
//               videoFile = File(pickedFile.path);
//               _videoController!.setLooping(true);
//               _videoController!.play();
//             });
//           });
//       }
//     } catch (e) {
//       // Handle any errors
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error picking video: $e")),
//       );
//     }
//   }
//
//   /// Function to add a new certificate
//   void _addCertificate() async {
//     String? selectedType; // Initialize as null
//     File? uploadedFile;
//     final _dialogFormKey = GlobalKey<FormState>(); // Form key for the dialog
//     final TextEditingController customTypeController =
//     TextEditingController(); // Controller for custom type
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text("Add New Certificate"),
//             content: Form(
//               key: _dialogFormKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value: selectedType,
//                       items: ["IELTS", "TOEFL", "Other"].map((cert) {
//                         return DropdownMenuItem(
//                           value: cert,
//                           child: Text(cert),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedType = value;
//                           if (value != "Other") {
//                             customTypeController.text = "";
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Certificate Type",
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a certification type';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     if (selectedType == "Other")
//                       TextFormField(
//                         controller: customTypeController,
//                         decoration: InputDecoration(
//                           labelText: "Enter Certification Type",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (selectedType == "Other") {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter the certification type';
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           FilePickerResult? result = await FilePicker.platform
//                               .pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: [
//                               'pdf',
//                               'doc',
//                               'docx',
//                               'jpg',
//                               'png'
//                             ],
//                           );
//                           if (result != null &&
//                               result.files.single.path != null) {
//                             File selectedFile =
//                             File(result.files.single.path!);
//                             final fileSize = await selectedFile.length();
//                             if (fileSize > 64 * 1024 * 1024) {
//                               setStateDialog(() {
//                                 uploadedFile = null;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                     Text("File size exceeds 64 MB.")),
//                               );
//                               return;
//                             }
//                             setStateDialog(() {
//                               uploadedFile = selectedFile;
//                             });
//                           }
//                         } catch (e) {
//                           // Handle any errors
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content: Text("Error picking file: $e")),
//                           );
//                         }
//                       },
//                       child: Text("Upload Certificate"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     if (uploadedFile != null)
//                       Text(
//                         uploadedFile!.path.split('/').last,
//                         style: TextStyle(color: Colors.green),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_dialogFormKey.currentState!.validate()) {
//                     if (uploadedFile != null) {
//                       String finalType = selectedType!;
//                       if (selectedType == "Other") {
//                         finalType = customTypeController.text.trim();
//                       }
//                       setState(() {
//                         certificates.add(Certificate(
//                             type: finalType, file: uploadedFile!));
//                       });
//                       Navigator.of(context).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Certificate added successfully.")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Please upload a certificate file")),
//                       );
//                     }
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
//
//     // Dispose the controller after the dialog is closed
//     customTypeController.dispose();
//   }
//
//   /// Function to edit an existing certificate
//   void _editCertificate(int index) async {
//     String? selectedType = certificates[index].type;
//     File? uploadedFile = certificates[index].file;
//     final _dialogFormKey = GlobalKey<FormState>();
//     final TextEditingController customTypeController =
//     TextEditingController(
//         text: selectedType != "Other" ? "" : selectedType);
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text("Edit Certificate"),
//             content: Form(
//               key: _dialogFormKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       value:
//                       selectedType != "Other" ? selectedType : null,
//                       items: ["IELTS", "TOEFL", "Other"].map((cert) {
//                         return DropdownMenuItem(
//                           value: cert,
//                           child: Text(cert),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setStateDialog(() {
//                           selectedType = value;
//                           if (value != "Other") {
//                             customTypeController.text = "";
//                           }
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Certificate Type",
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a certification type';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     if (selectedType == "Other")
//                       TextFormField(
//                         controller: customTypeController,
//                         decoration: InputDecoration(
//                           labelText: "Enter Certification Type",
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (selectedType == "Other") {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter the certification type';
//                             }
//                           }
//                           return null;
//                         },
//                       ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         try {
//                           FilePickerResult? result = await FilePicker.platform
//                               .pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: [
//                               'pdf',
//                               'doc',
//                               'docx',
//                               'jpg',
//                               'png'
//                             ],
//                           );
//                           if (result != null &&
//                               result.files.single.path != null) {
//                             File selectedFile =
//                             File(result.files.single.path!);
//                             final fileSize = await selectedFile.length();
//                             if (fileSize > 64 * 1024 * 1024) {
//                               setStateDialog(() {
//                                 uploadedFile = null;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                     Text("File size exceeds 64 MB.")),
//                               );
//                               return;
//                             }
//                             setStateDialog(() {
//                               uploadedFile = selectedFile;
//                             });
//                           }
//                         } catch (e) {
//                           // Handle any errors
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content: Text("Error picking file: $e")),
//                           );
//                         }
//                       },
//                       child: Text("Upload Certificate"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     if (uploadedFile != null)
//                       Text(
//                         uploadedFile!.path.split('/').last,
//                         style: TextStyle(color: Colors.green),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_dialogFormKey.currentState!.validate()) {
//                     if (uploadedFile != null) {
//                       String finalType = selectedType!;
//                       if (selectedType == "Other") {
//                         finalType = customTypeController.text.trim();
//                       }
//                       setState(() {
//                         certificates[index] =
//                             Certificate(type: finalType, file: uploadedFile!);
//                       });
//                       Navigator.of(context).pop();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Certificate updated successfully.")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                             Text("Please upload a certificate file")),
//                       );
//                     }
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
//
//     // Dispose the controller after the dialog is closed
//     customTypeController.dispose();
//   }
//
//   /// Function to delete a certificate with confirmation
//   void _deleteCertificate(int index) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Delete Certificate"),
//           content: Text("Are you sure you want to delete this certificate?"),
//           actions: [
//             TextButton(
//               child: Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.blue),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             ElevatedButton(
//               child: Text("Delete"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                 Colors.red, // Red color for delete action
//               ),
//               onPressed: () {
//                 setState(() {
//                   certificates.removeAt(index);
//                 });
//                 Navigator.of(context).pop(); // Close the dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("Certificate deleted successfully.")),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   /// Function to show Change Password dialog
//   void _showChangePasswordDialog() {
//     final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
//     final TextEditingController oldPasswordController =
//     TextEditingController();
//     final TextEditingController newPasswordController =
//     TextEditingController();
//     final TextEditingController confirmPasswordController =
//     TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Change Password"),
//           content: Form(
//             key: _passwordFormKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Old Password
//                   TextFormField(
//                     controller: oldPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Old Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your old password';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   // New Password
//                   TextFormField(
//                     controller: newPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "New Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a new password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password should be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 10),
//                   // Confirm New Password
//                   TextFormField(
//                     controller: confirmPasswordController,
//                     decoration: InputDecoration(
//                       labelText: "Confirm New Password",
//                       border: OutlineInputBorder(),
//                     ),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm your new password';
//                       }
//                       if (value != newPasswordController.text) {
//                         return 'Passwords do not match';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_passwordFormKey.currentState!.validate()) {
//                   // Implement password change logic here
//                   // For now, just show a success message
//                   Navigator.of(context).pop(); // Close dialog
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Password changed successfully.")),
//                   );
//                 }
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   /// Function to handle Save action
//   void _saveProfile() async {
//     if (_formKey.currentState!.validate()) {
//       // Optionally, you can show a loading indicator while saving
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(child: CircularProgressIndicator()),
//       );
//
//       // Simulate a delay for saving (replace with actual save logic)
//       await Future.delayed(Duration(seconds: 2));
//
//       // Remove the loading indicator
//       Navigator.of(context).pop();
//
//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Profile updated successfully.")),
//       );
//
//       // Optionally, navigate back or perform other actions
//     }
//   }
//
//   /// Function to handle Cancel action
//   void _cancelEdit() {
//     // Optionally, confirm cancellation
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Discard Changes?"),
//         content: Text("Are you sure you want to discard your changes?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(), // Close dialog
//             child: Text("No"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close dialog
//               Navigator.of(context).pop(); // Navigate back to previous page
//             },
//             child: Text("Yes"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Function to select date using DatePicker
//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     DateTime initialDate = DateTime(1990);
//     DateTime firstDate = DateTime(1900);
//     DateTime lastDate = DateTime.now();
//
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: initialDate,
//       firstDate: firstDate,
//       lastDate: lastDate,
//     );
//
//     if (picked != null) {
//       setState(() {
//         controller.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose controllers
//     nameController.dispose();
//     fromController.dispose();
//     dobController.dispose();
//     interestsController.dispose();
//     educationController.dispose();
//     experienceController.dispose();
//     professionController.dispose();
//     instructionController.dispose();
//     languagesController.dispose();
//     emailController.dispose();
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Profile"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Image Section
//               GestureDetector(
//                 onTap: _pickProfileImage,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage: profileImage != null
//                       ? FileImage(profileImage!)
//                       : AssetImage('assets/profile_placeholder.png')
//                   as ImageProvider,
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 20,
//                       child: Icon(
//                         Icons.edit,
//                         color: Colors.blue,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Name Field
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: "Name *",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // From Field
//               TextFormField(
//                 controller: fromController,
//                 decoration: InputDecoration(
//                   labelText: "From *",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your location';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Date of Birth Field
//               GestureDetector(
//                 onTap: () => _selectDate(context, dobController),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     controller: dobController,
//                     decoration: InputDecoration(
//                       labelText: "Date of Birth *",
//                       border: OutlineInputBorder(),
//                       suffixIcon: Icon(Icons.calendar_today),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               // Interests Field
//               TextFormField(
//                 controller: interestsController,
//                 decoration: InputDecoration(
//                   labelText: "Interests *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your interests';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Education Field
//               TextFormField(
//                 controller: educationController,
//                 decoration: InputDecoration(
//                   labelText: "Education *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your education details';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Experience Field
//               TextFormField(
//                 controller: experienceController,
//                 decoration: InputDecoration(
//                   labelText: "Experience *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your experience';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Profession Field
//               TextFormField(
//                 controller: professionController,
//                 decoration: InputDecoration(
//                   labelText: "Current or Previous Profession *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your profession';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Instruction Field
//               TextFormField(
//                 controller: instructionController,
//                 decoration: InputDecoration(
//                   labelText: "Instruction *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your teaching instructions';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               // Languages Field
//               TextFormField(
//                 controller: languagesController,
//                 decoration: InputDecoration(
//                   labelText: "Languages *",
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: null,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the languages you speak';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               // Email Address Field (Non-editable)
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email Address *",
//                   border: OutlineInputBorder(),
//                 ),
//                 enabled: false, // Make the field non-editable
//               ),
//               SizedBox(height: 20),
//               // Change Password Button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: _showChangePasswordDialog,
//                   child: Text(
//                     "Change Password",
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               // Video Introduction Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Video Introduction",
//                     style:
//                     TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: _pickVideoIntroduction,
//                     icon: Icon(Icons.edit, color: Colors.white),
//                     label: Text(
//                       "Edit Video",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               if (videoFile != null &&
//                   _videoController != null &&
//                   _videoController!.value.isInitialized)
//                 Column(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: _videoController!.value.aspectRatio,
//                       child: VideoPlayer(_videoController!),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.replay_10, color: Colors.blue),
//                           onPressed: () {
//                             final currentPosition =
//                                 _videoController!.value.position;
//                             final newPosition =
//                                 currentPosition - Duration(seconds: 10);
//                             _videoController!.seekTo(newPosition >= Duration.zero
//                                 ? newPosition
//                                 : Duration.zero);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             _videoController!.value.isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             color: Colors.blue,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (_videoController!.value.isPlaying) {
//                                 _videoController!.pause();
//                               } else {
//                                 _videoController!.play();
//                               }
//                             });
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.forward_10, color: Colors.blue),
//                           onPressed: () {
//                             final currentPosition =
//                                 _videoController!.value.position;
//                             final maxPosition =
//                                 _videoController!.value.duration;
//                             final newPosition =
//                                 currentPosition + Duration(seconds: 10);
//                             _videoController!.seekTo(newPosition <= maxPosition
//                                 ? newPosition
//                                 : maxPosition);
//                           },
//                         ),
//                       ],
//                     ),
//                     VideoProgressIndicator(
//                       _videoController!,
//                       allowScrubbing: true,
//                       padding: EdgeInsets.symmetric(horizontal: 20.0),
//                       colors: VideoProgressColors(
//                         playedColor: Colors.blue,
//                         bufferedColor: Colors.grey,
//                         backgroundColor: Colors.grey.shade300,
//                       ),
//                     ),
//                   ],
//                 )
//               else
//                 Text(
//                   "No video uploaded.",
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               SizedBox(height: 20),
//               Divider(),
//               SizedBox(height: 20),
//               // Certificates Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Certificates",
//                     style:
//                     TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: _addCertificate,
//                     icon: Icon(Icons.add, color: Colors.white),
//                     label: Text(
//                       "Add Certificate",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               certificates.isNotEmpty
//                   ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: certificates.length,
//                 itemBuilder: (context, index) {
//                   final cert = certificates[index];
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       leading:
//                       Icon(Icons.verified, color: Colors.green),
//                       title: Text(cert.type),
//                       subtitle: Text(cert.file.path.split('/').last),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon:
//                             Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () =>
//                                 _editCertificate(index),
//                           ),
//                           IconButton(
//                             icon:
//                             Icon(Icons.delete, color: Colors.red),
//                             onPressed: () =>
//                                 _deleteCertificate(index),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//                   : Text(
//                 "No certificates added.",
//                 style: TextStyle(color: Colors.grey),
//               ),
//               SizedBox(height: 30),
//               // Save and Cancel Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Cancel Button
//                   ElevatedButton(
//                     onPressed: _cancelEdit,
//                     child: Text("Cancel"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Colors.grey, // Grey background color
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 15),
//                     ),
//                   ),
//                   // Save Button
//                   ElevatedButton(
//                     onPressed: _saveProfile,
//                     child: Text("Save"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                       Colors.blue, // Blue background color
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 15),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/pages/tutor/edit_profile_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

/// Certificate Model
class Certificate {
  String type;
  File file;

  Certificate({required this.type, required this.file});
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for form fields initialized with dummy data
  final TextEditingController nameController =
  TextEditingController(text: "John Doe");
  final TextEditingController fromController =
  TextEditingController(text: "New York, USA");
  final TextEditingController dobController =
  TextEditingController(text: "1990-01-01");
  final TextEditingController interestsController =
  TextEditingController(text: "Mathematics, Physics");
  final TextEditingController educationController =
  TextEditingController(text: "M.Sc. in Mathematics");
  final TextEditingController experienceController =
  TextEditingController(text: "5 years teaching experience");
  final TextEditingController professionController =
  TextEditingController(text: "Senior Tutor");
  final TextEditingController instructionController =
  TextEditingController(text: "I specialize in Algebra and Calculus");
  final TextEditingController languagesController =
  TextEditingController(text: "English, Spanish");

  // Email address controller (non-editable)
  final TextEditingController emailController =
  TextEditingController(text: "johndoe@example.com");

  // Profile image
  File? profileImage;

  // Video Introduction
  File? videoFile;
  VideoPlayerController? _videoController;

  // Certificates
  List<Certificate> certificates = [];

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    // Dispose controllers
    nameController.dispose();
    fromController.dispose();
    dobController.dispose();
    interestsController.dispose();
    educationController.dispose();
    experienceController.dispose();
    professionController.dispose();
    instructionController.dispose();
    languagesController.dispose();
    emailController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  /// Function to pick profile image
  Future<void> _pickProfileImage() async {
    try {
      final pickedFile =
      await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  /// Function to pick video introduction
  Future<void> _pickVideoIntroduction() async {
    try {
      final pickedFile =
      await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        _videoController?.dispose();
        _videoController = VideoPlayerController.file(File(pickedFile.path))
          ..initialize().then((_) {
            setState(() {
              videoFile = File(pickedFile.path);
              _videoController!.setLooping(true);
              _videoController!.play();
            });
          });
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking video: $e")),
      );
    }
  }

  /// Function to add a new certificate
  void _addCertificate() async {
    String? selectedType; // Initialize as null
    File? uploadedFile;
    final _dialogFormKey = GlobalKey<FormState>(); // Form key for the dialog
    final TextEditingController customTypeController =
    TextEditingController(); // Controller for custom type

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text("Add New Certificate"),
            content: Form(
              key: _dialogFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      items: ["IELTS", "TOEFL", "Other"].map((cert) {
                        return DropdownMenuItem(
                          value: cert,
                          child: Text(cert),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedType = value;
                          if (value != "Other") {
                            customTypeController.text = "";
                          }
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Certificate Type",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a certification type';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    if (selectedType == "Other")
                      TextFormField(
                        controller: customTypeController,
                        decoration: InputDecoration(
                          labelText: "Enter Certification Type",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (selectedType == "Other") {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter the certification type';
                            }
                          }
                          return null;
                        },
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'pdf',
                              'doc',
                              'docx',
                              'jpg',
                              'png'
                            ],
                          );
                          if (result != null &&
                              result.files.single.path != null) {
                            File selectedFile = File(result.files.single.path!);
                            final fileSize = await selectedFile.length();
                            if (fileSize > 64 * 1024 * 1024) {
                              setStateDialog(() {
                                uploadedFile = null;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                    Text("File size exceeds 64 MB.")),
                              );
                              return;
                            }
                            setStateDialog(() {
                              uploadedFile = selectedFile;
                            });
                          }
                        } catch (e) {
                          // Handle any errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Error picking file: $e")),
                          );
                        }
                      },
                      child: Text("Upload Certificate"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    if (uploadedFile != null)
                      Text(
                        uploadedFile!.path.split('/').last,
                        style: TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_dialogFormKey.currentState!.validate()) {
                    if (uploadedFile != null) {
                      String finalType = selectedType!;
                      if (selectedType == "Other") {
                        finalType = customTypeController.text.trim();
                      }
                      setState(() {
                        certificates.add(
                            Certificate(type: finalType, file: uploadedFile!));
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Certificate added successfully.")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text("Please upload a certificate file")),
                      );
                    }
                  }
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          );
        });
      },
    );

    // Dispose the controller after the dialog is closed
    customTypeController.dispose();
  }

  /// Function to edit an existing certificate
  void _editCertificate(int index) async {
    String? selectedType = certificates[index].type;
    File? uploadedFile = certificates[index].file;
    final _dialogFormKey = GlobalKey<FormState>();
    final TextEditingController customTypeController =
    TextEditingController(
        text: selectedType != "Other" ? "" : selectedType);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text("Edit Certificate"),
            content: Form(
              key: _dialogFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value:
                      selectedType != "Other" ? selectedType : null,
                      items: ["IELTS", "TOEFL", "Other"].map((cert) {
                        return DropdownMenuItem(
                          value: cert,
                          child: Text(cert),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedType = value;
                          if (value != "Other") {
                            customTypeController.text = "";
                          }
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Certificate Type",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a certification type';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    if (selectedType == "Other")
                      TextFormField(
                        controller: customTypeController,
                        decoration: InputDecoration(
                          labelText: "Enter Certification Type",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (selectedType == "Other") {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter the certification type';
                            }
                          }
                          return null;
                        },
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'pdf',
                              'doc',
                              'docx',
                              'jpg',
                              'png'
                            ],
                          );
                          if (result != null &&
                              result.files.single.path != null) {
                            File selectedFile = File(result.files.single.path!);
                            final fileSize = await selectedFile.length();
                            if (fileSize > 64 * 1024 * 1024) {
                              setStateDialog(() {
                                uploadedFile = null;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                    Text("File size exceeds 64 MB.")),
                              );
                              return;
                            }
                            setStateDialog(() {
                              uploadedFile = selectedFile;
                            });
                          }
                        } catch (e) {
                          // Handle any errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("Error picking file: $e")),
                          );
                        }
                      },
                      child: Text("Upload Certificate"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    if (uploadedFile != null)
                      Text(
                        uploadedFile!.path.split('/').last,
                        style: TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_dialogFormKey.currentState!.validate()) {
                    if (uploadedFile != null) {
                      String finalType = selectedType!;
                      if (selectedType == "Other") {
                        finalType = customTypeController.text.trim();
                      }
                      setState(() {
                        certificates[index] =
                            Certificate(type: finalType, file: uploadedFile!);
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Certificate updated successfully.")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text("Please upload a certificate file")),
                      );
                    }
                  }
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          );
        });
      },
    );

    // Dispose the controller after the dialog is closed
    customTypeController.dispose();
  }

  /// Function to delete a certificate with confirmation
  void _deleteCertificate(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Certificate"),
          content: Text("Are you sure you want to delete this certificate?"),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text("Delete"),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                Colors.red, // Red color for delete action
              ),
              onPressed: () {
                setState(() {
                  certificates.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Certificate deleted successfully.")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  /// Function to show Change Password dialog
  void _showChangePasswordDialog() {
    final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
    final TextEditingController oldPasswordController =
    TextEditingController();
    final TextEditingController newPasswordController =
    TextEditingController();
    final TextEditingController confirmPasswordController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Password"),
          content: Form(
            key: _passwordFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Old Password
                  TextFormField(
                    controller: oldPasswordController,
                    decoration: InputDecoration(
                      labelText: "Old Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // New Password
                  TextFormField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // Confirm New Password
                  TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: "Confirm New Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != newPasswordController.text) {
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
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_passwordFormKey.currentState!.validate()) {
                  // Implement password change logic here
                  // For now, just show a success message
                  Navigator.of(context).pop(); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password changed successfully.")),
                  );
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// Function to handle Save action
  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Optionally, you can show a loading indicator while saving
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Simulate a delay for saving (replace with actual save logic)
      await Future.delayed(Duration(seconds: 2));

      // Remove the loading indicator
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully.")),
      );

      // Optionally, navigate back or perform other actions
    }
  }

  /// Function to handle Cancel action
  void _cancelEdit() {
    // Optionally, confirm cancellation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Discard Changes?"),
        content: Text("Are you sure you want to discard your changes?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog
            child: Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Navigate back to previous page
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  /// Function to select date using DatePicker
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime(1990);
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Image Section
              GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage!)
                      : AssetImage('assets/profile_placeholder.png')
                  as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // From Field
              TextFormField(
                controller: fromController,
                decoration: InputDecoration(
                  labelText: "From *",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Date of Birth Field
              GestureDetector(
                onTap: () => _selectDate(context, dobController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: "Date of Birth *",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Interests Field
              TextFormField(
                controller: interestsController,
                decoration: InputDecoration(
                  labelText: "Interests *",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your interests';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Education Field
              TextFormField(
                controller: educationController,
                decoration: InputDecoration(
                  labelText: "Education *",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your education details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Experience Field
              TextFormField(
                controller: experienceController,
                decoration: InputDecoration(
                  labelText: "Experience *",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your experience';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Profession Field
              TextFormField(
                controller: professionController,
                decoration: InputDecoration(
                  labelText: "Current or Previous Profession *",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your profession';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Instruction Field
              TextFormField(
                controller: instructionController,
                decoration: InputDecoration(
                  labelText: "Instruction *",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your teaching instructions';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Languages Field
              TextFormField(
                controller: languagesController,
                decoration: InputDecoration(
                  labelText: "Languages *",
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the languages you speak';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Email Address Field (Non-editable)
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email Address *",
                  border: OutlineInputBorder(),
                ),
                enabled: false, // Make the field non-editable
              ),
              SizedBox(height: 20),
              // Change Password Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _showChangePasswordDialog,
                  child: Text(
                    "Change Password",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              // Video Introduction Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Video Introduction",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickVideoIntroduction,
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      "Edit Video",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (videoFile != null &&
                  _videoController != null &&
                  _videoController!.value.isInitialized)
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10, color: Colors.blue),
                          onPressed: () {
                            final currentPosition =
                                _videoController!.value.position;
                            final newPosition =
                                currentPosition - Duration(seconds: 10);
                            _videoController!.seekTo(newPosition >= Duration.zero
                                ? newPosition
                                : Duration.zero);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _videoController!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_videoController!.value.isPlaying) {
                                _videoController!.pause();
                              } else {
                                _videoController!.play();
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10, color: Colors.blue),
                          onPressed: () {
                            final currentPosition =
                                _videoController!.value.position;
                            final maxPosition =
                                _videoController!.value.duration;
                            final newPosition =
                                currentPosition + Duration(seconds: 10);
                            _videoController!.seekTo(newPosition <= maxPosition
                                ? newPosition
                                : maxPosition);
                          },
                        ),
                      ],
                    ),
                    VideoProgressIndicator(
                      _videoController!,
                      allowScrubbing: true,
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      colors: VideoProgressColors(
                        playedColor: Colors.blue,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                  ],
                )
              else
                Text(
                  "No video uploaded.",
                  style: TextStyle(color: Colors.grey),
                ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              // Certificates Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Certificates",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: _addCertificate,
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      "Add Certificate",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              certificates.isNotEmpty
                  ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                          'Certificate Type',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    DataColumn(
                        label: Text(
                          'Certificate Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    DataColumn(
                        label: Text(
                          'Actions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                  rows: List.generate(certificates.length, (index) {
                    final cert = certificates[index];
                    return DataRow(cells: [
                      DataCell(Text(cert.type)),
                      DataCell(Text(cert.file.path.split('/').last)),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editCertificate(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteCertificate(index),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }),
                ),
              )
                  : Text(
                "No certificates added.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 30),
              // Save and Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  ElevatedButton(
                    onPressed: _cancelEdit,
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.grey, // Grey background color
                      padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                  // Save Button
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.blue, // Blue background color
                      padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
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

