class LearningSubject {
  final String id;
  final String idMatkul;
  final String lecturerId;
  final String name;
  final String credit;
  final String grade;
  final String type;
  final String tahunAkademik;
  final String semester;

  const LearningSubject({
    required this.id,
    required this.idMatkul,
    required this.lecturerId,
    required this.name,
    required this.credit,
    required this.grade,
    required this.type,
    required this.tahunAkademik,
    required this.semester,
  });

  factory LearningSubject.createFromJson(Map<String, dynamic> json) {
    return LearningSubject(
      id: json['id'].toString(),
      idMatkul: json['id_mata_kuliah'],
      lecturerId: json['lecturer_id'].toString(),
      name: json['name'],
      credit: json['credit'].toString(),
      grade: json['grade'],
      type: json['type'],
      tahunAkademik: json['tahun_akademik'],
      semester: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_mata_kuliah': id,
      'id_mata_kuliah_master': idMatkul,
      'id_dosen': lecturerId,
      'nama_mata_kuliah': name,
      'jumlah_sks': credit,
      'kelas': grade,
      'jenis': type,
      'tahun_akademik': tahunAkademik,
      'semester': semester
    };
  }
}
