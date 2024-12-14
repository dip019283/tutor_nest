import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Uncomment when integrating Firebase
// import 'package:cloud_firestore/cloud_firestore.dart'; // If you store OTP in Firestore

class ForgotPasswordOtpPage extends StatefulWidget {
  const ForgotPasswordOtpPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _otpSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // Example methods for backend integration (commented out):

  // Future<void> _sendOtp() async {
  //   final email = _emailController.text.trim();
  //   if (email.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Please enter your email')));
  //     return;
  //   }
  //
  //   try {
  //     // 1. Verify that user with this email exists in Firebase Auth
  //     // 2. Generate an OTP code
  //     // 3. Store OTP in Firestore linked to this user's email or UID
  //     // 4. Send OTP via Cloud Functions / SendGrid / Email API
  //
  //     setState(() {
  //       _otpSent = true;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('OTP sent to $email'))
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error sending OTP: ${e.toString()}')));
  //   }
  // }

  // Future<void> _verifyOtp() async {
  //   final enteredOtp = _otpController.text.trim();
  //   if (enteredOtp.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Please enter the OTP')));
  //     return;
  //   }
  //
  //   try {
  //     // Check the OTP against the stored value in Firestore
  //     // If matches and not expired, allow user to reset password
  //     // Possibly navigate to a "Reset Password" screen
  //
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('OTP verified. Proceed to reset password.')));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error verifying OTP: ${e.toString()}')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password - OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !_otpSent, // disable editing email after OTP is sent
            ),
            const SizedBox(height: 20),

            // Conditionally show OTP field only after it has been sent
            if (_otpSent)
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  hintText: 'Enter the 6-digit code',
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 20),

            // Send OTP or Verify OTP buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_otpSent) {
                        // _sendOtp();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Send OTP button pressed (Backend commented out)')),
                        );
                        setState(() {
                          _otpSent = true; // simulate OTP sent state
                        });
                      } else {
                        // _verifyOtp();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Verify OTP button pressed (Backend commented out)')),
                        );
                      }
                    },
                    child: Text(!_otpSent ? 'Send OTP' : 'Verify OTP'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
