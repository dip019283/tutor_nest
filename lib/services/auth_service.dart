// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Sign in with email and password
//   Future<User?> signIn(String email, String password) async {
//     UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     return result.user;
//   }
//
//   // Register with email and password
//   Future<User?> register(String email, String password) async {
//     UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return result.user;
//   }
//
//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
//
// // Additional methods as needed
// }
