// lib/services/settings_service.dart

import '../models/user_profile.dart';

class SettingsService {
  // Simulate fetching user profile data
  Future<UserProfile> fetchUserProfile() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Return a dummy user profile
    return UserProfile(
      name: "John Doe",
      email: "johndoe@example.com",
 id: '', profilePicture: '', // Ensure this asset exists
    );
  }

  // Add other settings-related methods here, such as updating profile
  Future<bool> updateUserProfile(UserProfile updatedProfile) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate a successful update
    return true;
  }

  // Simulate password change
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate password change logic
    return true;
  }
}
