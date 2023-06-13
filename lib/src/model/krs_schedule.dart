class KrsSchedule {
  final String tanggalMulai;
  final String tanggalSelesai;
  final String semester;
  final String tahunAkademik;

  const KrsSchedule({
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.semester,
    required this.tahunAkademik,
  });

  factory KrsSchedule.createFromJson(Map<String, dynamic> json) {
    return KrsSchedule(
      tanggalMulai: json['tanggal_mulai'],
      tanggalSelesai: json['tanggal_selesai'],
      semester: json['semester'],
      tahunAkademik: json['tahun_akademik'],
    );
  }
}
