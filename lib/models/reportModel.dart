import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String reportId;
  final String studentId;
  final String tutorId;
  final String reportText;
  final Timestamp reportDate;

  ReportModel({
    required this.reportId,
    required this.studentId,
    required this.tutorId,
    required this.reportText,
    required this.reportDate,
  });

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ReportModel(
      reportId: doc.id,
      studentId: data['studentId'] ?? '', // Added studentId field
      tutorId: data['tutorId'] ?? '', // Added tutorId field
      reportText: data['report_text'] ?? '', // Corrected to report_text
      reportDate: data['report_date'] ?? Timestamp.now(), // Default to current time if missing
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'tutorId': tutorId,
      'report_text': reportText, // Corrected to report_text
      'report_date': reportDate,
    };
  }
}
