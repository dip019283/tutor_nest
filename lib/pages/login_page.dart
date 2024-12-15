import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutornest/models/studentModel.dart';
import 'package:tutornest/models/userModel.dart';
import 'package:tutornest/pages/Student/tutor_details_content.dart';
import 'package:tutornest/pages/forgot_password_otp.dart';
import 'package:tutornest/pages/forgot_password_page_content.dart';
import 'package:bcrypt/bcrypt.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool rememberMe = false;
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      String userId = userCredential.user!.uid;

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        UserModel user = UserModel(
          userId: userId,
          email: userCredential.user!.email!,
          password: null,
          userRole: 'student',
        );

        await _firestore.collection('users').doc(userId).set(user.toFirestore());

        Student student = Student(
          studentId: userId,
          username: null,
          address: null,
          phone: null,
          email: userCredential.user!.email!,
          country: null,
          gender: null,
          photo: userCredential.user!.photoURL,
        );

        await _firestore.collection('students').doc(userId).set(student.toFirestore());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In successful, registration complete")),
        );
        Navigator.pushReplacementNamed(context, '/studentmain');
      } else {
        DocumentSnapshot studentDoc = await _firestore.collection('students').doc(userId).get();
        if (studentDoc.exists) {
          Student existingStudent = Student.fromFirestore(studentDoc);
          existingStudent = existingStudent.copyWith(
            photo: userCredential.user!.photoURL,
            username: existingStudent.username ?? '',
            address: existingStudent.address ?? '',
            phone: existingStudent.phone ?? '',
            country: existingStudent.country ?? '',
            gender: existingStudent.gender ?? '',
          );

          await _firestore.collection('students').doc(userId).set(existingStudent.toFirestore(), SetOptions(merge: true));
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In successful, welcome back")),
        );
        Navigator.pushReplacementNamed(context, '/studentmain');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during Google Sign-In: ${e.toString()}")),
      );
    }
  }


  Future<void> loginUser() async {
    try {
      // Admin hardcoded check
      if (_emailController.text == 'admin' && _passwordController.text == 'admin') {
        await secureStorage.write(key: 'userId', value: 'admin');
        Navigator.pushReplacementNamed(context, '/adminmain');
        return;
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: _emailController.text)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("User not found.");
      }

      DocumentSnapshot userDoc = querySnapshot.docs.first;

      String storedHashedPassword = userDoc['password'];
      bool isPasswordValid = BCrypt.checkpw(_passwordController.text, storedHashedPassword);

      if (!isPasswordValid) {
        throw Exception("Incorrect password.");
      }

      String userId = userDoc.id;
      String userRole = userDoc['user_role'] ?? 'student';

      print("User data: ${userDoc.data()}");

      await secureStorage.write(key: 'userId', value: userId);

      if (userRole == 'student') {
        QuerySnapshot studentQuery = await _firestore
            .collection('students')
            .where('email', isEqualTo: _emailController.text)
            .get();

        if (studentQuery.docs.isEmpty) {
          throw Exception("User not found.");
        }

        DocumentSnapshot studentDoc = studentQuery.docs.first;
        bool isEmailVerified = studentDoc['isEmailVerified'] ?? false;

        if (!isEmailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email not verified')),
          );
        } else {
          Navigator.pushReplacementNamed(context, '/studentmain');
        }
      } else {
        // Check tutors collection for verification
        QuerySnapshot tutorQuery = await _firestore
            .collection('tutors')
            .where('email', isEqualTo: _emailController.text)
            .get();

        if (tutorQuery.docs.isNotEmpty) {
          DocumentSnapshot tutorDoc = tutorQuery.docs.first;

          bool isVerified = tutorDoc['isVerified'] ?? false;
          if (isVerified) {
            Navigator.pushReplacementNamed(context, '/main');
          } else {
            Navigator.pushReplacementNamed(context, '/processing');
          }
        } else {
          Navigator.pushReplacementNamed(context, '/studentmain');
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content (scrollable)
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    // Logo
                    Image.asset(
                      'assets/education_logo.png',
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    // Welcome Text
                    Text(
                      "Welcome back, User",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller:_emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person, color: Colors.white),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller:_passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.white),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    },
                                    checkColor: Colors.black,
                                    fillColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  Text("Remember me", style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ForgotPasswordOtpPage()),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text("or login with", style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 10),
                          Center(
                            child: IconButton(
                              icon: Image.asset('assets/google_icon.png'),
                              iconSize: 40,
                              onPressed:() => signInWithGoogle(context),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

