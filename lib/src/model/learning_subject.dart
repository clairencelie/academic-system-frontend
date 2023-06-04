class LearningSubject {
  final String id;
  final String lecturerId;
  final String name;
  final String credit;
  final String grade;

  const LearningSubject({
    required this.id,
    required this.lecturerId,
    required this.name,
    required this.credit,
    required this.grade,
  });

  factory LearningSubject.createFromJson(Map<String, dynamic> json) {
    return LearningSubject(
      id: json['id'].toString(),
      lecturerId: json['lecturer_id'].toString(),
      name: json['name'],
      credit: json['credit'].toString(),
      grade: json['grade'],
    );
  }
}
