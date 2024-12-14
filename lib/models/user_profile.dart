// lib/models/user_profile.dart

class UserProfile {
  final String id; // Primary key
  final String name;
  final String email;
  final String profilePicture;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
  });

  // Factory method to create a UserProfile from JSON or Firestore document
  factory UserProfile.fromJson(Map<String, dynamic> json, String docId) {
    return UserProfile(
      id: docId,
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }

  // Method to convert a UserProfile to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}
