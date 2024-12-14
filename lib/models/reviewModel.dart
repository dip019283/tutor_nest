import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String reviewId;
  final String studentId;
  final String tutorId;
  final String reviewText;
  final Timestamp reviewDate;

  ReviewModel({
    required this.reviewId,
    required this.studentId,
    required this.tutorId,
    required this.reviewText,
    required this.reviewDate,
  });

  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ReviewModel(
      reviewId: doc.id,
      studentId: data['student_id'] ?? '',
      tutorId: data['tutor_id'] ?? '',
      reviewText: data['review_text'] ?? '',
      reviewDate: data['review_date'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'student_id': studentId,
      'tutor_id': tutorId,
      'review_text': reviewText,
      'review_date': reviewDate,
    };
  }
}
