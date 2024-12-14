// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class OtpVerificationPage extends StatefulWidget {
//   @override
//   _OtpVerificationPageState createState() => _OtpVerificationPageState();
// }
//
// class _OtpVerificationPageState extends State<OtpVerificationPage> {
//   final TextEditingController _otpController = TextEditingController();
//   String? userId;
//   String? email;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     userId = args['userId'];
//     email = args['email'];
//   }
//
//   Future<void> verifyOtp() async {
//     if (userId == null) return;
//
//     DocumentSnapshot otpDoc = await _firestore.collection('otpVerifications').doc(userId).get();
//     if (!otpDoc.exists) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No OTP found. Please register again.")),
//       );
//       return;
//     }
//
//     String storedOtp = otpDoc.get('otp');
//
//     if (_otpController.text.trim() == storedOtp) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("OTP verified successfully!")),
//       );
//
//       // You can delete the OTP doc if you want, since it's verified
//       await _firestore.collection('otpVerifications').doc(userId).delete();
//
//       // Navigate to the login page or home page
//       Navigator.pushNamed(context, '/login');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Incorrect OTP. Please try again.")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Stack(
//         children: [
//           Positioned.fill(child: Container(color: Colors.blueAccent)),
//           SafeArea(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Verify OTP",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       "An OTP has been sent to $email.\nPlease check your email and enter it below:",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(height: 40),
//                     TextField(
//                       controller: _otpController,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         hintText: "Enter OTP",
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: verifyOtp,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                       ),
//                       child: Text(
//                         "Verify",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart'; // Backend for Firebase
// // import 'package:firebase_core/firebase_core.dart'; // Initialize Firebase
//
// class OtpPage extends StatefulWidget {
//   const OtpPage({Key? key}) : super(key: key);
//
//   @override
//   State<OtpPage> createState() => _OtpPageState();
// }
//
// class _OtpPageState extends State<OtpPage> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//
//   // Variables that would be used with Firebase Auth
//   // String _verificationId = '';
//   // bool _otpSent = false;
//
//   @override
//   void dispose() {
//     _phoneNumberController.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }
//
//   // Method to send OTP using Firebase
//   // Future<void> _sendOtp() async {
//   //   await FirebaseAuth.instance.verifyPhoneNumber(
//   //     phoneNumber: _phoneNumberController.text.trim(),
//   //     verificationCompleted: (PhoneAuthCredential credential) async {
//   //       // Auto verification completed
//   //       // await FirebaseAuth.instance.signInWithCredential(credential);
//   //     },
//   //     verificationFailed: (FirebaseAuthException e) {
//   //       ScaffoldMessenger.of(context)
//   //           .showSnackBar(SnackBar(content: Text('Verification failed: ${e.message}')));
//   //     },
//   //     codeSent: (String verificationId, int? resendToken) {
//   //       setState(() {
//   //         _verificationId = verificationId;
//   //         _otpSent = true;
//   //       });
//   //       ScaffoldMessenger.of(context)
//   //           .showSnackBar(const SnackBar(content: Text('OTP sent successfully')));
//   //     },
//   //     codeAutoRetrievalTimeout: (String verificationId) {
//   //       // Auto retrieval time out
//   //     },
//   //   );
//   // }
//
//   // Method to verify the OTP using Firebase
//   // Future<void> _verifyOtp() async {
//   //   final credential = PhoneAuthProvider.credential(
//   //     verificationId: _verificationId,
//   //     smsCode: _otpController.text.trim(),
//   //   );
//   //
//   //   try {
//   //     await FirebaseAuth.instance.signInWithCredential(credential);
//   //     ScaffoldMessenger.of(context)
//   //         .showSnackBar(const SnackBar(content: Text('Phone number verified successfully')));
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context)
//   //         .showSnackBar(SnackBar(content: Text('Verification failed: ${e.toString()}')));
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OTP Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Phone Number',
//                 hintText: '+1 123 456 7890',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             // If OTP is sent, show the OTP field, else hide it
//             // _otpSent ? TextField(
//             TextField(
//               controller: _otpController,
//               decoration: const InputDecoration(
//                 labelText: 'OTP',
//                 hintText: '123456',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             // : const SizedBox(),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   // Button to send OTP
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // _sendOtp();
//                       // Commented out backend action, here you would integrate with Firebase
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(const SnackBar(content: Text('OTP Send button clicked')));
//                     },
//                     child: const Text('Send OTP'),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   // Button to verify OTP
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // _verifyOtp();
//                       // Commented out backend action, here you would integrate with Firebase
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(const SnackBar(content: Text('Verify OTP button clicked')));
//                     },
//                     child: const Text('Verify OTP'),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // For OTP verification via Firestore if desired
// import 'package:firebase_auth/firebase_auth.dart';    // For Firebase Auth if needed

class OtpPage extends StatefulWidget {
  final String userEmail;

  const OtpPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  // Backend verification logic
  // Future<void> _verifyOtp() async {
  //   final enteredOtp = _otpController.text.trim();
  //   // Check against stored OTP in Firestore or another backend
  //   // If valid, mark user as verified
  // }

  // Backend re-send logic
  // Future<void> _resendOtp() async {
  //   // Trigger a backend function to resend OTP to widget.userEmail
  // }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerifyPressed() {
    // _verifyOtp();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verify OTP button pressed (Backend commented out)')),
    );
  }

  void _onResendPressed() {
    // _resendOtp();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resend OTP button pressed (Backend commented out)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'An OTP has been sent to your email: ${widget.userEmail}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: 'OTP',
                hintText: 'Enter the 6-digit code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onVerifyPressed,
              child: const Text('Verify OTP'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _onResendPressed,
              child: const Text('Resend OTP'),
            )
          ],
        ),
      ),
    );
  }
}
