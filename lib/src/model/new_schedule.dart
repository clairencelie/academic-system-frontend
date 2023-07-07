class NewSchedule {
  final String? id;
  final String learningSubId;
  final String lecturerId;
  final String startsAt;
  final String endsAt;
  final String day;
  final String room;
  final String information;
  final String tahunAkademik;
  final String semester;

  const NewSchedule({
    this.id,
    required this.learningSubId,
    required this.lecturerId,
    required this.startsAt,
    required this.endsAt,
    required this.day,
    required this.room,
    required this.information,
    required this.tahunAkademik,
    required this.semester,
  });

  Map<String, dynamic> toJson() {
    return (id != null)
        ? {
            'id': id,
            'learning_sub_id': learningSubId,
            'lecturer_id': lecturerId,
            'starts_at': startsAt,
            'ends_at': endsAt,
            'day': day,
            'room': room,
            'information': information,
            'tahun_akademik': tahunAkademik,
            'semester': semester,
          }
        : {
            'learning_sub_id': learningSubId,
            'lecturer_id': lecturerId,
            'starts_at': startsAt,
            'ends_at': endsAt,
            'day': day,
            'room': room,
            'information': information,
            'tahun_akademik': tahunAkademik,
            'semester': semester,
          };
  }
}
