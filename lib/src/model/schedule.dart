class Schedule {
  String id;
  String idMatkul;
  String learningSubId;
  String learningSubName;
  String lecturerId;
  String lecturerName;
  String startsAt;
  String endsAt;
  String day;
  String room;
  String grade;
  String credit;
  String information;
  String tahunAkademik;
  String semester;

  Schedule({
    required this.id,
    required this.idMatkul,
    required this.learningSubId,
    required this.learningSubName,
    required this.lecturerId,
    required this.lecturerName,
    required this.startsAt,
    required this.endsAt,
    required this.day,
    required this.room,
    required this.grade,
    required this.credit,
    required this.information,
    required this.tahunAkademik,
    required this.semester,
  });

  factory Schedule.createFromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'].toString(),
      idMatkul: json['id_matkul'].toString(),
      learningSubId: json['learning_sub_id'].toString(),
      learningSubName: json['learning_sub_name'],
      lecturerId: json['lecturer_id'].toString(),
      lecturerName: json['lecturer_name'],
      startsAt: json['starts_at'].toString().substring(0, 5),
      endsAt: json['ends_at'].toString().substring(0, 5),
      day: json['day'],
      room: json['room'],
      grade: json['grade'],
      credit: json['credit'].toString(),
      information: json['information'],
      tahunAkademik: json['tahun_akademik'],
      semester: json['semester'],
    );
  }
}
