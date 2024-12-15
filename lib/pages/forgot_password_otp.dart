import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:tutornest/pages/password_reset_page.dart';

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

  void _onVerifyPressed() async {
    bool isValid = await EmailOTP.verifyOTP(
      otp: _otpController.text,
    );

    if (isValid) {
      try {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChangePasswordPage(email:_emailController.text)));
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to verify email')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  void _onResendPressed() async {
    EmailOTP.config(
      appName: 'TutorNest',
      otpType: OTPType.numeric,
      expiry: 60000,
      emailTheme: EmailTheme.v1,
      appEmail: 'tutornest.customercare@gmail.com',
      otpLength: 6,
    );
    bool result = await EmailOTP.sendOTP(email: _emailController.text);
    if (result) {
      setState(() {
        _otpSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP has been sent')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP')),
      );
    }
  }

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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !_otpSent,
            ),
            const SizedBox(height: 20),
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_otpSent) {
                        _onResendPressed();
                      } else {
                        _onVerifyPressed();
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
