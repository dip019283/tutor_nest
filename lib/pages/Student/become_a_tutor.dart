//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:video_player/video_player.dart';
//
// class BecomeATutorPage extends StatefulWidget {
//   @override
//   _BecomeATutorPageState createState() => _BecomeATutorPageState();
// }
//
// enum ProfileStep { Profile, VideoIntroduction, Approval }
//
// class Certificate {
//   String type;
//   File file;
//
//   Certificate({required this.type, required this.file});
// }
//
// class _BecomeATutorPageState extends State<BecomeATutorPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   // Current Step
//   ProfileStep currentStep = ProfileStep.Profile;
//
//   // Controllers for form fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController fromController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController interestsController = TextEditingController();
//   final TextEditingController educationController = TextEditingController();
//   final TextEditingController experienceController = TextEditingController();
//   final TextEditingController professionController = TextEditingController();
//   final TextEditingController instructionController = TextEditingController();
//   final TextEditingController languagesController = TextEditingController();
//
//   // New Controller for About Section
//   final TextEditingController aboutController = TextEditingController();
//
//   // Image and File Uploads
//   File? profileImage;
//
//   // Certificates
//   List<Certificate> certificates = [];
//
//   // Video Introduction
//   File? videoFile;
//   VideoPlayerController? _videoController;
//
//   // Removed Checkbox States
//   // bool beginnerChecked = false;
//   // bool intermediateChecked = false;
//   // bool advancedChecked = false;
//
//   // Video Playback State
//   bool isVideoPlaying = false;
//
//   // Additional Controller for Custom Certification Type
//   final TextEditingController customTypeController = TextEditingController();
//
//   final ImagePicker _imagePicker = ImagePicker();
//
//   // Function to pick profile image
//   Future<void> _pickProfileImage() async {
//     try {
//       final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
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
//   // Function to pick video file
//   Future<void> _pickVideoFile() async {
//     try {
//       final pickedFile = await _imagePicker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         _videoController?.dispose();
//         _videoController = VideoPlayerController.file(File(pickedFile.path))
//           ..initialize().then((_) {
//             setState(() {
//               videoFile = File(pickedFile.path);
//               _videoController!.play();
//               isVideoPlaying = true;
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
//
//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text("Add New Certificate"),
//             content: Form(
//               key: _dialogFormKey, // Assign the form key
//               child: SingleChildScrollView( // Ensures content is scrollable if overflow occurs
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
//                           FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
//                           );
//                           if (result != null && result.files.single.path != null) {
//                             File selectedFile = File(result.files.single.path!);
//                             final fileSize = await selectedFile.length();
//                             if (fileSize > 64 * 1024 * 1024) { // 64 MB
//                               setStateDialog(() {
//                                 uploadedFile = null;
//                               });
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text("File size exceeds 64 MB.")),
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
//                         backgroundColor: Colors.blue, // Button background color
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
//                         SnackBar(content: Text("Certificate added successfully.")),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Please upload a certificate file")),
//                       );
//                     }
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue, // Button background color
//                 ),
//               ),
//             ],
//           );
//         });
//       },
//     );
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
//                 backgroundColor: Colors.red, // Red color for delete action
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
//   // Function to pick Date of Birth
//   Future<void> _pickDateOfBirth() async {
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
//         dobController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }
//
//   // Function to proceed to next step
//   void _nextStep() {
//     if (currentStep == ProfileStep.Profile) {
//       // Validate profile form
//       if (_formKey.currentState!.validate()) {
//         // Check if profile image is uploaded
//         if (profileImage == null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Please upload a profile image.")),
//           );
//           return;
//         }
//
//         // Additional validations can be added here
//
//         setState(() {
//           currentStep = ProfileStep.VideoIntroduction;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Profile completed!")),
//         );
//       }
//     } else if (currentStep == ProfileStep.VideoIntroduction) {
//       if (videoFile != null) {
//         setState(() {
//           currentStep = ProfileStep.Approval;
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Please upload a video introduction.")),
//         );
//       }
//     }
//   }
//
//   // Function to go back to previous step
//   void _backStep() {
//     if (currentStep == ProfileStep.VideoIntroduction) {
//       setState(() {
//         currentStep = ProfileStep.Profile;
//       });
//     } else if (currentStep == ProfileStep.Approval) {
//       setState(() {
//         currentStep = ProfileStep.VideoIntroduction;
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
//     aboutController.dispose(); // Dispose the new About controller
//     customTypeController.dispose();
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: currentStep == ProfileStep.Profile
//             ? _buildProfileForm()
//             : currentStep == ProfileStep.VideoIntroduction
//             ? _buildVideoIntroduction()
//             : _buildApproval(),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       title: const Text(
//         "Become a Tutor",
//         style: TextStyle(color: Colors.blue),
//       ),
//       backgroundColor: Colors.white,
//       centerTitle: true,
//       iconTheme: IconThemeData(color: Colors.blue),
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: Colors.blue),
//         onPressed: () {
//           Navigator.of(context).pop(); // Navigate back to Settings Page
//         },
//       ),
//     );
//   }
//
//   Widget _buildProfileForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Progress Steps
//           _buildProgressSteps(),
//
//           const SizedBox(height: 20),
//
//           // Profile Image Upload
//           Center(
//             child: GestureDetector(
//               onTap: _pickProfileImage,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: profileImage != null
//                     ? FileImage(profileImage!)
//                     : AssetImage('assets/profile_placeholder.png') as ImageProvider,
//                 child: profileImage == null
//                     ? Icon(Icons.camera_alt, size: 50, color: Colors.white70)
//                     : null,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Center(
//             child: TextButton.icon(
//               onPressed: _pickProfileImage,
//               icon: Icon(Icons.upload, color: Colors.blue),
//               label: Text(
//                 "Upload Profile Image",
//                 style: TextStyle(color: Colors.blue),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Form Title
//           const Text(
//             "Set up your tutor profile",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "Students will check your profile to decide whether to book a lesson with you. Please provide as much information as possible.",
//             style: TextStyle(fontSize: 14, color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//
//           // Basic Info Section
//           const Text(
//             "Basic Info",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: nameController,
//             decoration: const InputDecoration(
//               labelText: "Name *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your name';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: fromController,
//             decoration: const InputDecoration(
//               labelText: "From *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your origin';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           GestureDetector(
//             onTap: _pickDateOfBirth,
//             child: AbsorbPointer(
//               child: TextFormField(
//                 controller: dobController,
//                 decoration: const InputDecoration(
//                   labelText: "Date of Birth *",
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.calendar_today),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select your date of birth';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//
//           // CV Section
//           const Text(
//             "CV",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: interestsController,
//             decoration: const InputDecoration(
//               labelText: "Interests *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your interests';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: educationController,
//             decoration: const InputDecoration(
//               labelText: "Education *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your education details';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: experienceController,
//             decoration: const InputDecoration(
//               labelText: "Experience *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your experience';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: professionController,
//             decoration: const InputDecoration(
//               labelText: "Current or Previous Profession *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your profession';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//
//           // Languages Section
//           const Text(
//             "Languages I Speak",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: languagesController,
//             decoration: const InputDecoration(
//               labelText: "Languages *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter the languages you speak';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//
//           // Instruction Section
//           const Text(
//             "Instruction",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: instructionController,
//             decoration: const InputDecoration(
//               labelText: "Instruction *",
//               border: OutlineInputBorder(),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your teaching instructions';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//
//           // New About Section
//           const Text(
//             "About",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           TextFormField(
//             controller: aboutController,
//             decoration: const InputDecoration(
//               labelText: "Tell us about yourself",
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 4,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please provide some information about yourself';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//
//           // Certificates Section
//           const Text(
//             "Certificates",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton.icon(
//             onPressed: _addCertificate,
//             icon: Icon(Icons.add, color: Colors.white),
//             label: Text(
//               "Add New Certificate",
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue, // Button background color
//             ),
//           ),
//           const SizedBox(height: 10),
//           certificates.isNotEmpty
//               ? ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: certificates.length,
//             itemBuilder: (context, index) {
//               final cert = certificates[index];
//               return Card(
//                 elevation: 3,
//                 margin: EdgeInsets.symmetric(vertical: 5),
//                 child: ListTile(
//                   leading: Icon(Icons.verified, color: Colors.green),
//                   title: Text(cert.type),
//                   subtitle: Text(cert.file.path.split('/').last),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _deleteCertificate(index),
//                   ),
//                 ),
//               );
//             },
//           )
//               : Text(
//             "No certificates added.",
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//
//           // Save and Next Buttons
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement Save functionality if separate from Next
//                   if (_formKey.currentState!.validate()) {
//                     // Check if profile image is uploaded
//                     if (profileImage == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Please upload a profile image.")),
//                       );
//                       return;
//                     }
//
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Profile saved!")),
//                     );
//                   }
//                 },
//                 child: Text("Save"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue, // Button background color
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: _nextStep,
//                 child: Text("Next"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue, // Button background color
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProgressSteps() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center, // Center the entire Row
//       crossAxisAlignment: CrossAxisAlignment.center, // Center align vertically
//       children: [
//         // Complete Profile Step
//         Column(
//           children: [
//             CircleAvatar(
//               radius: 20, // Uniform size for all avatars
//               backgroundColor: currentStep == ProfileStep.Profile ||
//                   currentStep == ProfileStep.VideoIntroduction ||
//                   currentStep == ProfileStep.Approval
//                   ? Colors.blue
//                   : Colors.grey,
//               child: Icon(Icons.person, color: Colors.white, size: 20),
//             ),
//             SizedBox(height: 5),
//             Container(
//               width: 80, // Fixed width to prevent overflow
//               child: Text(
//                 "Complete\nProfile",
//                 style: TextStyle(
//                   fontSize: 12, // Reduced font size
//                   color: currentStep == ProfileStep.Profile ||
//                       currentStep == ProfileStep.VideoIntroduction ||
//                       currentStep == ProfileStep.Approval
//                       ? Colors.black
//                       : Colors.grey,
//                 ),
//                 textAlign: TextAlign.center, // Center-align the text
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: 10), // Fixed spacing between Profile and line
//         // Connecting Line
//         Container(
//           width: 40, // Fixed width for connecting line
//           height: 2,
//           color: currentStep == ProfileStep.VideoIntroduction ||
//               currentStep == ProfileStep.Approval
//               ? Colors.blue
//               : Colors.grey,
//         ),
//         SizedBox(width: 10), // Fixed spacing between line and Video Introduction
//         // Video Introduction Step
//         Column(
//           children: [
//             CircleAvatar(
//               radius: 20, // Uniform size for all avatars
//               backgroundColor: currentStep == ProfileStep.VideoIntroduction ||
//                   currentStep == ProfileStep.Approval
//                   ? Colors.blue
//                   : Colors.grey,
//               child: Icon(Icons.videocam, color: Colors.white, size: 20),
//             ),
//             SizedBox(height: 5),
//             Container(
//               width: 80, // Fixed width to prevent overflow
//               child: Text(
//                 "Video\nIntroduction",
//                 style: TextStyle(
//                   fontSize: 12, // Reduced font size
//                   color: currentStep == ProfileStep.VideoIntroduction ||
//                       currentStep == ProfileStep.Approval
//                       ? Colors.black
//                       : Colors.grey,
//                 ),
//                 textAlign: TextAlign.center, // Center-align the text
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: 10), // Fixed spacing between Video Introduction and line
//         // Connecting Line
//         Container(
//           width: 40, // Fixed width for connecting line
//           height: 2,
//           color: currentStep == ProfileStep.Approval
//               ? Colors.blue
//               : Colors.grey,
//         ),
//         SizedBox(width: 10), // Fixed spacing between line and Approval
//         // Approval Step
//         Column(
//           children: [
//             CircleAvatar(
//               radius: 20, // Uniform size for all avatars
//               backgroundColor: currentStep == ProfileStep.Approval
//                   ? Colors.blue
//                   : Colors.grey,
//               child: Icon(Icons.check, color: Colors.white, size: 20),
//             ),
//             SizedBox(height: 5),
//             Container(
//               width: 80, // Fixed width to prevent overflow
//               child: Text(
//                 "Approval\n",
//                 style: TextStyle(
//                   fontSize: 12, // Reduced font size
//                   color: currentStep == ProfileStep.Approval
//                       ? Colors.black
//                       : Colors.grey,
//                 ),
//                 textAlign: TextAlign.center, // Center-align the text
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2, // Allow two lines even if the second is empty
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildVideoIntroduction() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Progress Steps
//         _buildProgressSteps(),
//
//         const SizedBox(height: 20),
//
//         const Text(
//           "Introduce Yourself",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           "Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise, and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.",
//           style: TextStyle(fontSize: 14, color: Colors.grey),
//         ),
//         const SizedBox(height: 20),
//
//         const Text(
//           "A few helpful tips:",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTipItem("Find a clean and quiet space"),
//             _buildTipItem("Smile and look at the camera"),
//             _buildTipItem("Dress smart"),
//             _buildTipItem("Speak for 1-3 minutes"),
//             _buildTipItem("Brand yourself and have fun!"),
//           ],
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           "Note: We only support uploading video files that are less than 64 MB in size.",
//           style: TextStyle(fontSize: 12, color: Colors.red),
//         ),
//         const SizedBox(height: 20),
//
//         // Choose Video Button
//         Center(
//           child: ElevatedButton.icon(
//             onPressed: _pickVideoFile,
//             icon: Icon(Icons.video_call, color: Colors.white),
//             label: Text(
//               "Choose Video",
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue, // Button background color
//             ),
//           ),
//         ),
//         if (videoFile != null && _videoController != null && _videoController!.value.isInitialized)
//           Column(
//             children: [
//               const SizedBox(height: 10),
//               // Video Player
//               AspectRatio(
//                 aspectRatio: _videoController!.value.aspectRatio,
//                 child: VideoPlayer(_videoController!),
//               ),
//               const SizedBox(height: 10),
//               // Video Controls
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.replay_10, color: Colors.blue),
//                     onPressed: () {
//                       final currentPosition = _videoController!.value.position;
//                       final newPosition = currentPosition - Duration(seconds: 10);
//                       _videoController!.seekTo(
//                         newPosition >= Duration.zero ? newPosition : Duration.zero,
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                       color: Colors.blue,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         if (_videoController!.value.isPlaying) {
//                           _videoController!.pause();
//                         } else {
//                           _videoController!.play();
//                         }
//                       });
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.forward_10, color: Colors.blue),
//                     onPressed: () {
//                       final currentPosition = _videoController!.value.position;
//                       final maxPosition = _videoController!.value.duration;
//                       final newPosition = currentPosition + Duration(seconds: 10);
//                       _videoController!.seekTo(
//                         newPosition <= maxPosition ? newPosition : maxPosition,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               VideoProgressIndicator(
//                 _videoController!,
//                 allowScrubbing: true,
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 colors: VideoProgressColors(
//                   playedColor: Colors.blue,
//                   bufferedColor: Colors.grey,
//                   backgroundColor: Colors.grey.shade300,
//                 ),
//               ),
//             ],
//           ),
//         const SizedBox(height: 20),
//
//         // Back and Next Buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ElevatedButton(
//               onPressed: _backStep,
//               child: Text("Back"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue, // Button background color
//               ),
//             ),
//             ElevatedButton(
//               onPressed: _nextStep,
//               child: Text("Next"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue, // Button background color
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTipItem(String tip) {
//     return Row(
//       children: [
//         Icon(Icons.check, size: 16, color: Colors.green),
//         SizedBox(width: 5),
//         Expanded(child: Text(tip)),
//       ],
//     );
//   }
//
//   Widget _buildApproval() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Progress Steps
//         _buildProgressSteps(),
//
//         const SizedBox(height: 50),
//
//         Icon(Icons.check_circle, color: Colors.green, size: 100),
//         const SizedBox(height: 20),
//         const Text(
//           "Congratulations!",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           "Your application is being processed.",
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           "You can now start receiving student bookings.",
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//           textAlign: TextAlign.center,
//         ),
//
//         const SizedBox(height: 50),
//
//         // Optionally, you can add a button to go back or navigate elsewhere
//       ],
//     );
//   }
// }

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
  File? videoFile;
  VideoPlayerController? _videoController;
  bool isVideoPlaying = false;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  final _imagePicker = ImagePicker();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _specialtyController = TextEditingController();

  Future<void> _pickVideo() async {
    try {
      final pickedFile = await _imagePicker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        _videoController?.dispose();

        _videoController = VideoPlayerController.file(File(pickedFile.path))
          ..initialize().then((_) {
            setState(() {
              videoFile = File(pickedFile.path);
              _videoController!.setLooping(true);
              _videoController!.play();
              isVideoPlaying = true;
            });
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error initializing video: $error")),
            );
          });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking video: $e")),
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

    String videoUrl = '';
    if (videoFile != null) {
      videoUrl = await _uploadVideoToCloudinary(videoFile!);
      if (videoUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Video upload failed. Please try again.")),
        );
        return;
      }
    }

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
      introductionVideoUrl: videoUrl,
    );

    await FirebaseFirestore.instance.collection('tutors').doc(userId).set(tutor.toFirestore());

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'user_role': 'tutor',
    });

    await FirebaseFirestore.instance.collection('students').doc(userId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Successfully became a tutor")),
    );
    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }

  Future<String> _uploadVideoToCloudinary(File videoFile) async {
    const cloudinaryUrl = "https://api.cloudinary.com/v1_1/dtejmhyys/video/upload";
    const uploadPreset = "introv";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', videoFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseBody);
        return jsonResponse['secure_url'] ?? '';
      } else {
        print("Cloudinary upload failed with status: ${response.statusCode}");
        return '';
      }
    } catch (e) {
      print("Error uploading to Cloudinary: $e");
      return '';
    }
  }


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
                onPressed: _pickVideo,
                child: Text("Pick Introduction Video"),
              ),
              if (videoFile != null) ...[
                AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
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

