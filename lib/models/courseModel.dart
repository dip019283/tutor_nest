class Course {
  final String courseId;
  final String courseName;
  final String image;
  final String intro;
  final String whyTakeThisCourse;
  final List<String> whatYouWillLearn;
  final String description;
  final String videoUrl;

  Course({
    required this.courseId,
    required this.courseName,
    required this.image,
    required this.intro,
    required this.whyTakeThisCourse,
    required this.whatYouWillLearn,
    required this.description,
    required this.videoUrl,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['courseId'],
      courseName: map['courseName'],
      image: map['image'],
      intro: map['intro'],
      whyTakeThisCourse: map['whyTakeThisCourse'],
      whatYouWillLearn: List<String>.from(map['whatYouWillLearn']),
      description: map['description'],
      videoUrl: map['videoUrl'],
    );
  }
}
