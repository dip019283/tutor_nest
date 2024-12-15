import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final String userEmail;

  const OtpPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();



  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }


  void _onVerifyPressed() async{
      bool isValid = await EmailOTP.verifyOTP(
        otp: _otpController.text,
      );

      if (isValid) {
        try {
          await FirebaseFirestore.instance
              .collection('students')
              .where('email', isEqualTo: widget.userEmail)
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              FirebaseFirestore.instance
                  .collection('students')
                  .doc(doc.id)
                  .update({'isEmailVerified': true});
            }
          });

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamed(context, '/login');
          });
        } catch (e) {ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP failed'),
          ),
        );

        }
      } else {ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP failed'),
        ),
      );

      }
  }

  void _onResendPressed() async{
    EmailOTP.config(
      appName: 'TutorNest',
      otpType: OTPType.numeric,
      expiry : 60000,
      emailTheme: EmailTheme.v1,
      appEmail: 'tutornest.customercare@gmail.com',
      otpLength: 6,
    );
    bool result = await EmailOTP.sendOTP(email: widget.userEmail);
    if(result){ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP has been sent'),
      ),
    );

    }else{ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP failed to sent'),
      ),
    );

    }
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
