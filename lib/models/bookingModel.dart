import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingModel {
  final String bookingId;
  final String tutorId;
  final String studentId;
  final Timestamp startTime;
  final Timestamp endTime;
  final Timestamp date;
  final String status;

  BookingModel({
    required this.bookingId,
    required this.tutorId,
    required this.studentId,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.status,
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return BookingModel(
      bookingId: doc.id,
      tutorId: data['tutor_id'] ?? '',
      studentId: data['student_id'] ?? '',
      startTime: data['start_time'], // now directly using Timestamp
      endTime: data['end_time'], // now directly using Timestamp
      date: data['date'],
      status: data['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'tutor_id': tutorId,
      'student_id': studentId,
      'start_time': startTime, // directly using Timestamp
      'end_time': endTime, // directly using Timestamp
      'date': date,
      'status': status,
    };
  }
}
