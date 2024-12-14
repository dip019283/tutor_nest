import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String studentId;
  final String? username;
  final String? address;
  final String? phone;
  final String email;
  final String? country;
  final String? gender;
  final String? photo;

  Student({
    required this.studentId,
    this.username,
    this.address,
    this.phone,
    required this.email,
    this.country,
    this.gender,
    this.photo,
  });

  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Student(
      studentId: doc.id,
      username: data['username'],
      address: data['address'],
      phone: data['phone'],
      email: data['email'] ?? '',
      country: data['country'],
      gender: data['gender'],
      photo: data['photo'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'address': address,
      'phone': phone,
      'email': email,
      'country': country,
      'gender': gender,
      'photo': photo,
    };
  }

  Student copyWith({
    String? username,
    String? address,
    String? phone,
    String? email,
    String? country,
    String? gender,
    String? photo,
  }) {
    return Student(
      studentId: this.studentId,
      username: username ?? this.username,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      photo: photo ?? this.photo,
    );
  }
}
