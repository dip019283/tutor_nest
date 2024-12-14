import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String email;
  final String? password;
  final String userRole;

  UserModel({
    required this.userId,
    required this.email,
    this.password,
    required this.userRole,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      userId: doc.id,
      email: data['email'] ?? '',
      password: data['password'],
      userRole: data['user_role'] ?? 'student',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      'password': password,
      'user_role': userRole,
    };
  }
}
