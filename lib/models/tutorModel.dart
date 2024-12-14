import 'package:cloud_firestore/cloud_firestore.dart';

class Tutor {
  final String tutorId;
  final String? username;
  final String? address;
  final String? phone;
  final String email;
  final String? country;
  final String? gender;
  final String? photo;
  final String? about;
  final String? education;
  final List<String> languages;
  final List<String> specialties;
  final String? interests;
  final String? teachingExperience;
  final String? introductionVideoUrl;
  final bool isVerified; // Added field
  final String? cv; // Optional CV field (base64 string)

  Tutor({
    required this.tutorId,
    this.username,
    this.address,
    this.phone,
    required this.email,
    this.country,
    this.gender,
    this.photo,
    this.about,
    this.education,
    required this.languages,
    required this.specialties,
    this.interests,
    this.teachingExperience,
    this.introductionVideoUrl,
    this.isVerified = false, // Default value for new tutors
    this.cv, // Optional CV
  });

  factory Tutor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Tutor(
      tutorId: doc.id,
      username: data['username'],
      address: data['address'],
      phone: data['phone'],
      email: data['email'] ?? '',
      country: data['country'],
      gender: data['gender'],
      photo: data['photo'],
      about: data['about'],
      education: data['education'],
      languages: List<String>.from(data['languages'] ?? []),
      specialties: List<String>.from(data['specialties'] ?? []),
      interests: data['interests'],
      teachingExperience: data['teachingExperience'],
      introductionVideoUrl: data['introductionVideoUrl'],
      isVerified: data['isVerified'] ?? false, // Default to false if not present
      cv: data['cv'], // Retrieve CV field from Firestore
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
      'about': about,
      'education': education,
      'languages': languages,
      'specialties': specialties,
      'interests': interests,
      'teachingExperience': teachingExperience,
      'introductionVideoUrl': introductionVideoUrl,
      'isVerified': isVerified, // Include in Firestore data
      'cv': cv, // Include CV in Firestore data (optional)
    };
  }
}
