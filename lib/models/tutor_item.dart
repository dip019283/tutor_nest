// lib/models/tutor_item.dart

class TutorItem {
  final String id; // Primary key
  final String name;
  final List<String> subjects;  // Changed from String to List<String>
  final double rating;
  final String profilePicture;

  TutorItem({
    required this.id,
    required this.name,
    required this.subjects,  // Updated parameter name
    required this.rating,
    required this.profilePicture,
  });

  // Factory method to create a TutorItem from JSON or Firestore document
  factory TutorItem.fromJson(Map<String, dynamic> json, String docId) {
    // Handle the case where subjects might come as a List or a single String
    List<String> subjectList = [];
    if (json['subjects'] != null) {
      if (json['subjects'] is List) {
        subjectList = List<String>.from(json['subjects']);
      } else if (json['subjects'] is String) {
        subjectList = [json['subjects']];
      }
    }

    return TutorItem(
      id: docId,
      name: json['name'] ?? 'Unknown Tutor',
      subjects: subjectList.isEmpty ? ['Subject not provided'] : subjectList,
      rating: (json['rating'] ?? 0).toDouble(),
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  // Method to convert a TutorItem to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subjects': subjects,  // Now saves the entire list
      'rating': rating,
      'profilePicture': profilePicture,
    };
  }
}