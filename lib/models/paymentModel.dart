import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String paymentId;
  final String studentId;
  final double amount;
  final bool isPaid;
  final String plan;
  final Timestamp dueDate;

  PaymentModel({
    required this.paymentId,
    required this.studentId,
    required this.amount,
    required this.isPaid,
    required this.plan,
    required this.dueDate,
  });

  factory PaymentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PaymentModel(
      paymentId: doc.id,
      studentId: data['studentId'] ?? '',
      amount: data['amount'] ?? 0.0,
      isPaid: data['isPaid'] ?? false,
      plan: data['plan'] ?? '',
      dueDate: data['dueDate'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'amount': amount,
      'isPaid': isPaid,
      'plan': plan,
      'dueDate': dueDate,
    };
  }
}
