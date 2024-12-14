import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // uncomment when integrating Firebase

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

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

  // Backend logic to change password
  // Future<void> _changePassword() async {
  //   final newPassword = _newPasswordController.text.trim();
  //   final confirmPassword = _confirmPasswordController.text.trim();
  //
  //   if (newPassword.isEmpty || confirmPassword.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill out both fields.')),
  //     );
  //     return;
  //   }
  //
  //   if (newPassword != confirmPassword) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Passwords do not match.')),
  //     );
  //     return;
  //   }
  //
  //   try {
  //     // Get current user:
  //     // User? user = FirebaseAuth.instance.currentUser;
  //     // await user?.updatePassword(newPassword);
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Password changed successfully.')),
  //     );
  //     // Navigate to home or login page as needed
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error changing password: ${e.toString()}')),
  //     );
  //   }
  // }

  void _onChangePasswordPressed() {
    // _changePassword();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Change Password button pressed (Backend commented out)')),
    );
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
