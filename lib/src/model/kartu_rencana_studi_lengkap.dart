import 'package:academic_system/src/model/learning_subject.dart';

class KartuRencanaStudiLengkap {
  final String id;
  final String nim;
  final String semester;
  final String jurusan;
  final String ips;
  final String ipk;
  final String kreditDiambil;
  final String bebanSksMaks;
  final String waktuPengisian;
  final String tahunAkademik;
  final String commit;
  final List<LearningSubject> pilihanMataKuliah;

  KartuRencanaStudiLengkap({
    required this.id,
    required this.nim,
    required this.semester,
    required this.jurusan,
    required this.ips,
    required this.ipk,
    required this.kreditDiambil,
    required this.bebanSksMaks,
    required this.waktuPengisian,
    required this.tahunAkademik,
    required this.commit,
    required this.pilihanMataKuliah,
  });

  factory KartuRencanaStudiLengkap.createFromJson(Map<String, dynamic> json) {
    return KartuRencanaStudiLengkap(
      id: json['id'],
      nim: json['nim'],
      semester: json['semester'],
      jurusan: json['jurusan'],
      ips: json['ips'],
      ipk: json['ipk'],
      kreditDiambil: json['kredit_diambil'],
      bebanSksMaks: json['beban_sks_maks'],
      waktuPengisian: json['waktu_pengisian'],
      tahunAkademik: json['tahun_akademik'],
      commit: json['commit'],
      pilihanMataKuliah: (json['pilihan_mata_kuliah'] as List)
          .map((pilihanMatkul) => LearningSubject.createFromJson(pilihanMatkul))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'semester': semester,
      'program_studi': jurusan,
      'ips': ips,
      'ipk': ipk,
      'kredit_diambil': kreditDiambil,
      'beban_sks_maks': bebanSksMaks,
      'waktu_pengisian': waktuPengisian,
      'tahun_akademik': tahunAkademik
    };
  }
}
