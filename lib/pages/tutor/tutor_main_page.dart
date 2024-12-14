// // lib/pages/Tutor/tutor_main_page.dart
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'dashboard_page_content.dart';
// import 'tutor_setting_page_content.dart';
// import '../login_page.dart'; // Adjust the import path based on your project structure
// import 'package:image_picker/image_picker.dart'; // For profile image upload
//
// class TutorMainPage extends StatefulWidget {
//   @override
//   _TutorMainPageState createState() => _TutorMainPageState();
// }
//
// class _TutorMainPageState extends State<TutorMainPage> {
//   // Track the selected language
//   Map<String, String> selectedLanguage = {
//     "name": "English",
//     "image": "assets/us_flag.png",
//   };
//
//   int _currentIndex = 0;
//
//   final List<Map<String, String>> languages = [
//     {"name": "English", "image": "assets/us_flag.png"},
//     {"name": "Nepali", "image": "assets/np_flag.png"},
//     {"name": "Spanish", "image": "assets/sp_flag.png"},
//   ];
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Create a list of pages
//   late List<Widget> _pages;
//
//   // Profile image
//   File? profileImage;
//
//   // ImagePicker instance
//   final ImagePicker _imagePicker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       DashboardPageContent(),
//       TutorSettingsPageContent(),
//     ];
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//     });
//   }
//
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
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop, // Handle back button press
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Row(
//               children: [
//                 Image.asset(
//                   'assets/education_logo.png',
//                   height: 50,
//                 ),
//               ],
//             ),
//             actions: [
//               PopupMenuButton<Map<String, String>>(
//                 icon: Image.asset(
//                   selectedLanguage['image']!,
//                   height: 24,
//                   width: 24,
//                 ),
//                 onSelected: (Map<String, String> language) {
//                   selectLanguage(language);
//                 },
//                 itemBuilder: (BuildContext context) {
//                   return languages.map((language) {
//                     return PopupMenuItem<Map<String, String>>(
//                       value: language,
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             language['image']!,
//                             width: 24,
//                             height: 24,
//                           ),
//                           SizedBox(width: 8),
//                           Text(language['name']!),
//                         ],
//                       ),
//                     );
//                   }).toList();
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.menu, color: Colors.black, size: 28),
//                 onPressed: () {
//                   _scaffoldKey.currentState?.openEndDrawer(); // Open endDrawer
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: _buildEndDrawer(), // Right-to-left Sidebar Drawer
//         body: IndexedStack(
//           index: _currentIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard),
//               label: "Dashboard",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ],
//           currentIndex: _currentIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle:
//           TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           unselectedLabelStyle: TextStyle(fontSize: 12),
//           iconSize: 24,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
//
//   // EndDrawer (Right-to-Left Sidebar) Implementation
//   Widget _buildEndDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           // Custom DrawerHeader
//           DrawerHeader(
//             decoration: BoxDecoration(color: Colors.blue),
//             child: Center(
//               child: Text(
//                 'Menu',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//           ),
//           // Dashboard
//           ListTile(
//             leading: Icon(Icons.dashboard),
//             title: Text("Dashboard"),
//             selected: _currentIndex == 0,
//             selectedTileColor: Colors.blue[100],
//             onTap: () {
//               setState(() {
//                 _currentIndex = 0;
//               });
//               Navigator.pop(context);
//             },
//           ),
//           // Settings
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("Settings"),
//             selected: _currentIndex == 1,
//             selectedTileColor: Colors.blue[100],
//             onTap: () {
//               setState(() {
//                 _currentIndex = 1;
//               });
//               Navigator.pop(context);
//             },
//           ),
//           Divider(),
//           // Logout
//           ListTile(
//             leading: Icon(Icons.logout, color: Colors.red),
//             title: Text("Logout", style: TextStyle(color: Colors.red)),
//             onTap: () {
//               Navigator.pop(context);
//               // Implement logout functionality
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<bool> _onWillPop() async {
//     // Handle back button press with confirmation dialog
//     return (await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Exit App'),
//         content: Text('Do you want to exit the app?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('No'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     )) ??
//         false;
//   }
// }

// lib/pages/Tutor/tutor_main_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemNavigator
import 'dashboard_page_content.dart';
import 'tutor_setting_page_content.dart';
import '../login_page.dart'; // Adjust the import path based on your project structure
import 'package:image_picker/image_picker.dart'; // For profile image upload

class TutorMainPage extends StatefulWidget {
  @override
  _TutorMainPageState createState() => _TutorMainPageState();
}

class _TutorMainPageState extends State<TutorMainPage> {
  // Track the selected language
  Map<String, String> selectedLanguage = {
    "name": "English",
    "image": "assets/us_flag.png",
  };

  int _currentIndex = 0;

  final List<Map<String, String>> languages = [
    {"name": "English", "image": "assets/us_flag.png"},
    {"name": "Nepali", "image": "assets/np_flag.png"},
    {"name": "Spanish", "image": "assets/sp_flag.png"},
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Create a list of pages
  late List<Widget> _pages;

  // Profile image
  File? profileImage;

  // ImagePicker instance
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _pages = [
      DashboardPageContent(),
      TutorSettingsPageContent(),
    ];
  }

  void selectLanguage(Map<String, String> language) {
    setState(() {
      selectedLanguage = language; // Update the selected language
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Handle back button press
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child:
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                Image.asset(
                  'assets/education_logo.png',
                  height: 50,
                ),
              ],
            ),
            actions: [
              PopupMenuButton<Map<String, String>>(
                icon: Image.asset(
                  selectedLanguage['image']!,
                  height: 24,
                  width: 24,
                ),
                onSelected: (Map<String, String> language) {
                  selectLanguage(language);
                },
                itemBuilder: (BuildContext context) {
                  return languages.map((language) {
                    return PopupMenuItem<Map<String, String>>(
                      value: language,
                      child: Row(
                        children: [
                          Image.asset(
                            language['image']!,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          Text(language['name']!),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
              IconButton(
                icon: Icon(Icons.menu, color: Colors.black, size: 28),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer(); // Open endDrawer
                },
              ),
            ],
          ),
        ),
        endDrawer: _buildEndDrawer(), // Right-to-left Sidebar Drawer
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // EndDrawer (Right-to-Left Sidebar) Implementation
  Widget _buildEndDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Custom DrawerHeader
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          // Dashboard
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            selected: _currentIndex == 0,
            selectedTileColor: Colors.blue[100],
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
              Navigator.pop(context);
            },
          ),
          // Settings
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            selected: _currentIndex == 1,
            selectedTileColor: Colors.blue[100],
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
              Navigator.pop(context);
            },
          ),
          Divider(),
          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              // Implement logout functionality
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // Handle back button press with confirmation dialog
    bool? shouldExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // Exit the app
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0); // Note: Not recommended on iOS
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );

    // Return false to prevent the default back button behavior
    return Future.value(false);
  }
}
