// import 'package:flutter/material.dart';
// // Import your page content widgets
// import 'home_page_content.dart';
// import 'schedule_page_content.dart';
// import 'history_page_content.dart';
// import 'courses_page_content.dart';
// // Import other necessary packages
// // import 'package:provider/provider.dart';
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
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
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       HomePageContent(),
//       SchedulePageContent(),
//       HistoryPageContent(),
//       CoursesPageContent(),
//       Center(child: Text("Settings Page Content Goes Here")), // Placeholder
//     ];
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//     });
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
//                   height: 70,
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
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 selected: _currentIndex == 0,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.schedule),
//                 title: Text("Schedule"),
//                 selected: _currentIndex == 1,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               // Add other drawer items
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                   final authService =
//                   Provider.of<AuthService>(context, listen: false);
//                   authService.signOut();
//                   Navigator.pushReplacementNamed(context, '/login');
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: IndexedStack(
//           index: _currentIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             // Add other navigation items
//           ],
//           currentIndex: _currentIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.grey,
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

// import 'package:flutter/material.dart';
// import 'package:tutor_nest/pages/Student/settings_page_content.dart';
// // Import your page content widgets
// import 'home_page_content.dart';
// import 'schedule_page_content.dart';
// import 'history_page_content.dart';
// import 'courses_page_content.dart';
// // No need to import Provider since we're not focusing on backend services
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
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
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       HomePageContent(),
//       SchedulePageContent(),
//       HistoryPageContent(),
//       CoursesPageContent(),
//       SettingsPageContent(), // Placeholder
//     ];
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//     });
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
//                   height: 70,
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
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 selected: _currentIndex == 0,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.schedule),
//                 title: Text("Schedule"),
//                 selected: _currentIndex == 1,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.history),
//                 title: Text("History"),
//                 selected: _currentIndex == 2,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 2;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.menu_book),
//                 title: Text("Courses"),
//                 selected: _currentIndex == 3,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 3;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 selected: _currentIndex == 4,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 4;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                   // Since backend is not implemented yet, simply navigate to login page
//                   Navigator.pushReplacementNamed(context, '/login');
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: IndexedStack(
//           index: _currentIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               label: "Courses",
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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Import this for SystemNavigator.pop()
// import 'package:tutor_nest/pages/Student/settings_page_content.dart';
// // Import your page content widgets
// import 'home_page_content.dart';
// import 'schedule_page_content.dart';
// import 'history_page_content.dart';
// import 'courses_page_content.dart';
// // No need to import Provider since we're not focusing on backend services
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
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
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       HomePageContent(),
//       SchedulePageContent(),
//       HistoryPageContent(),
//       CoursesPageContent(),
//       SettingsPageContent(), // Placeholder
//     ];
//   }
//
//   void selectLanguage(Map<String, String> language) {
//     setState(() {
//       selectedLanguage = language; // Update the selected language
//     });
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
//                   height: 70,
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
//                   _scaffoldKey.currentState?.openEndDrawer();
//                 },
//               ),
//             ],
//           ),
//         ),
//         endDrawer: Drawer(
//           child: ListView(
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.blue),
//                 child: Center(
//                   child: Text(
//                     'Menu',
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text("Home"),
//                 selected: _currentIndex == 0,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 0;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.schedule),
//                 title: Text("Schedule"),
//                 selected: _currentIndex == 1,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 1;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.history),
//                 title: Text("History"),
//                 selected: _currentIndex == 2,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 2;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.menu_book),
//                 title: Text("Courses"),
//                 selected: _currentIndex == 3,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 3;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text("Settings"),
//                 selected: _currentIndex == 4,
//                 selectedTileColor: Colors.blue[100],
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = 4;
//                   });
//                   Navigator.pop(context);
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {
//                   // Handle logout
//                   // Since backend is not implemented yet, simply navigate to login page
//                   Navigator.pushReplacementNamed(context, '/login');
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: IndexedStack(
//           index: _currentIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.schedule),
//               label: "Schedule",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               label: "Courses",
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
//   Future<bool> _onWillPop() async {
//     // Handle back button press with confirmation dialog
//     bool shouldExit = false;
//
//     await showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Exit App'),
//         content: Text('Do you want to exit the app?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('No'),
//           ),
//           TextButton(
//             onPressed: () {
//               shouldExit = true;
//               Navigator.of(context).pop();
//             },
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     );
//
//     if (shouldExit) {
//       SystemNavigator.pop(); // This exits the app
//     }
//
//     return Future.value(false); // Prevents the default pop behavior
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemNavigator.pop()
import 'package:tutornest/pages/Student/settings_page_content.dart';
// Import your page content widgets
import 'home_page_content.dart';
import 'schedule_page_content.dart';
import 'history_page_content.dart';
import 'courses_page_content.dart';
// No need to import Provider since we're not focusing on backend services

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePageContent(),
      SchedulePageContent(),
      HistoryPageContent(),
      CoursesPageContent(),
      SettingsPageContent(), // Placeholder
    ];
  }

  void selectLanguage(Map<String, String> language) {
    setState(() {
      selectedLanguage = language; // Update the selected language
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Handle back button press
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                Image.asset(
                  'assets/education_logo.png',
                  height: 70,
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
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                selected: _currentIndex == 0,
                selectedTileColor: Colors.blue[100],
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.schedule),
                title: Text("Schedule"),
                selected: _currentIndex == 1,
                selectedTileColor: Colors.blue[100],
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History"),
                selected: _currentIndex == 2,
                selectedTileColor: Colors.blue[100],
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.menu_book),
                title: Text("Courses"),
                selected: _currentIndex == 3,
                selectedTileColor: Colors.blue[100],
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                selected: _currentIndex == 4,
                selectedTileColor: Colors.blue[100],
                onTap: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: () {
                  // Handle logout
                  // Since backend is not implemented yet, simply navigate to login page
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: "Courses",
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

  Future<bool> _onWillPop() async {
    // Handle back button press with confirmation dialog
    return await showDialog(
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
              SystemNavigator.pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
}
