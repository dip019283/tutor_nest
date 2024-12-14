// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class AddCoursePage extends StatefulWidget {
//   @override
//   _AddCoursePageState createState() => _AddCoursePageState();
// }
//
// class _AddCoursePageState extends State<AddCoursePage> {
//   final TextEditingController _courseIdController = TextEditingController();
//   final TextEditingController _courseNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _imageController = TextEditingController();
//   final TextEditingController _introController = TextEditingController();
//   final TextEditingController _videoUrlController = TextEditingController();
//   final TextEditingController _whyTakeThisCourseController =
//   TextEditingController();
//
//   final List<TextEditingController> _whatYouWillLearnControllers = [];
//
//   @override
//   void dispose() {
//     _courseIdController.dispose();
//     _courseNameController.dispose();
//     _descriptionController.dispose();
//     _imageController.dispose();
//     _introController.dispose();
//     _videoUrlController.dispose();
//     _whyTakeThisCourseController.dispose();
//     _whatYouWillLearnControllers.forEach((controller) => controller.dispose());
//     super.dispose();
//   }
//
//   void addWhatYouWillLearnField() {
//     setState(() {
//       _whatYouWillLearnControllers.add(TextEditingController());
//     });
//   }
//
//   Future<void> submitCourse() async {
//     try {
//       final courseDetails = {
//         'courseId': _courseIdController.text,
//         'courseName': _courseNameController.text,
//         'description': _descriptionController.text,
//         'image': _imageController.text,
//         'intro': _introController.text,
//         'videoUrl': _videoUrlController.text,
//         'whatYouWillLearn': _whatYouWillLearnControllers
//             .map((controller) => controller.text)
//             .toList(),
//         'whyTakeThisCourse': _whyTakeThisCourseController.text,
//       };
//
//       await FirebaseFirestore.instance.collection('courses').add(courseDetails);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Course added successfully!'),
//       ));
//       clearForm();
//       Navigator.pop(context);
//     } catch (e) {
//       print("Error adding course: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to add course.'),
//       ));
//     }
//   }
//
//   void clearForm() {
//     _courseIdController.clear();
//     _courseNameController.clear();
//     _descriptionController.clear();
//     _imageController.clear();
//     _introController.clear();
//     _videoUrlController.clear();
//     _whyTakeThisCourseController.clear();
//     _whatYouWillLearnControllers.forEach((controller) => controller.clear());
//     setState(() {
//       _whatYouWillLearnControllers.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add New Course')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _courseIdController,
//                 decoration: InputDecoration(labelText: 'Course ID'),
//               ),
//               TextField(
//                 controller: _courseNameController,
//                 decoration: InputDecoration(labelText: 'Course Name'),
//               ),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//               ),
//               TextField(
//                 controller: _imageController,
//                 decoration: InputDecoration(labelText: 'Image URL'),
//               ),
//               TextField(
//                 controller: _introController,
//                 decoration: InputDecoration(labelText: 'Intro'),
//               ),
//               TextField(
//                 controller: _videoUrlController,
//                 decoration: InputDecoration(labelText: 'Video URL'),
//               ),
//               SizedBox(height: 16),
//               Text('What You Will Learn'),
//               for (int i = 0; i < _whatYouWillLearnControllers.length; i++)
//                 TextField(
//                   controller: _whatYouWillLearnControllers[i],
//                   decoration: InputDecoration(labelText: 'Skill ${i + 1}'),
//                 ),
//               ElevatedButton(
//                 onPressed: addWhatYouWillLearnField,
//                 child: Text('Add Skill'),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: _whyTakeThisCourseController,
//                 decoration: InputDecoration(labelText: 'Why Take This Course'),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: submitCourse,
//                 child: Text('Add Course'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _introController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();
  final TextEditingController _whyTakeThisCourseController = TextEditingController();

  final List<TextEditingController> _whatYouWillLearnControllers = [];

  @override
  void dispose() {
    _courseIdController.dispose();
    _courseNameController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _introController.dispose();
    _videoUrlController.dispose();
    _whyTakeThisCourseController.dispose();
    for (final controller in _whatYouWillLearnControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addWhatYouWillLearnField() {
    setState(() {
      _whatYouWillLearnControllers.add(TextEditingController());
    });
  }

  Future<void> submitCourse() async {
    try {
      final courseDetails = {
        'courseId': _courseIdController.text,
        'courseName': _courseNameController.text,
        'description': _descriptionController.text,
        'image': _imageController.text,
        'intro': _introController.text,
        'videoUrl': _videoUrlController.text,
        'whatYouWillLearn':
        _whatYouWillLearnControllers.map((controller) => controller.text).toList(),
        'whyTakeThisCourse': _whyTakeThisCourseController.text,
      };

      await FirebaseFirestore.instance.collection('courses').add(courseDetails);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Course added successfully!'),
      ));
      clearForm();
      Navigator.pop(context);
    } catch (e) {
      print("Error adding course: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add course.'),
      ));
    }
  }

  void clearForm() {
    _courseIdController.clear();
    _courseNameController.clear();
    _descriptionController.clear();
    _imageController.clear();
    _introController.clear();
    _videoUrlController.clear();
    _whyTakeThisCourseController.clear();
    for (final controller in _whatYouWillLearnControllers) {
      controller.clear();
    }
    setState(() {
      _whatYouWillLearnControllers.clear();
    });
  }

  Future<void> pasteClipboardContentToField(TextEditingController controller) async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null) {
      setState(() {
        controller.text = data.text ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Course')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _courseIdController,
                decoration: InputDecoration(labelText: 'Course ID'),
              ),
              TextField(
                controller: _courseNameController,
                decoration: InputDecoration(labelText: 'Course Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _imageController,
                      decoration: InputDecoration(labelText: 'Image URL'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.paste),
                    onPressed: () => pasteClipboardContentToField(_imageController),
                  ),
                ],
              ),
              TextField(
                controller: _introController,
                decoration: InputDecoration(labelText: 'Intro'),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _videoUrlController,
                      decoration: InputDecoration(labelText: 'Video URL'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.paste),
                    onPressed: () => pasteClipboardContentToField(_videoUrlController),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('What You Will Learn'),
              for (int i = 0; i < _whatYouWillLearnControllers.length; i++)
                TextField(
                  controller: _whatYouWillLearnControllers[i],
                  decoration: InputDecoration(labelText: 'Skill ${i + 1}'),
                ),
              ElevatedButton(
                onPressed: addWhatYouWillLearnField,
                child: Text('Add Skill'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _whyTakeThisCourseController,
                decoration: InputDecoration(labelText: 'Why Take This Course'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitCourse,
                child: Text('Add Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
