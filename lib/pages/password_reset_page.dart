import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutornest/pages/login_page.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // uncomment when integrating Firebase

class ChangePasswordPage extends StatefulWidget {
  final String email;
  const ChangePasswordPage({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  void _onChangePasswordPressed() async{
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      showSnackBar('Fields cannot be empty');
      return;
    }

    if (newPassword.length < 8) {
      showSnackBar('Password must be at least 8 characters long');
      return;
    }

    if (newPassword != confirmPassword) {
      showSnackBar('Passwords do not match');
      return;
    }

    try {
      String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.email)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.update({'password': hashedPassword});
          showSnackBar('Password reset successfully');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
        } else {
          showSnackBar('User not found');
        }
      });
    } catch (e) {
      print(e.toString());
      showSnackBar('Error resetting password');
    }
  }
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                hintText: 'Enter your new password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your new password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onChangePasswordPressed,
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
