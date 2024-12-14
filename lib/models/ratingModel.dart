import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  final String ratingId;
  final String studentId;
  final String tutorId;
  final int rating;

  RatingModel({
    required this.ratingId,
    required this.studentId,
    required this.tutorId,
    required this.rating,
  });

  factory RatingModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return RatingModel(
      ratingId: doc.id,
      studentId: data['studentId'] ?? '',
      tutorId: data['tutorId'] ?? '',
      rating: data['rating'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'tutorId': tutorId,
      'rating': rating,
    };
  }
}
