class KartuRencanaStudi {
  final String nim;
  final String semester;
  final String jurusan;
  final String konsentrasi;
  final String ips;
  final String ipk;
  final String kreditDiambil;
  final String bebanSksMaks;
  final String waktuPengisian;
  final String tahunAkademik;

  KartuRencanaStudi({
    required this.nim,
    required this.semester,
    required this.jurusan,
    required this.konsentrasi,
    required this.ips,
    required this.ipk,
    required this.kreditDiambil,
    required this.bebanSksMaks,
    required this.waktuPengisian,
    required this.tahunAkademik,
  });

  factory KartuRencanaStudi.createFromJson(Map<String, dynamic> json) {
    return KartuRencanaStudi(
      nim: json['nim'],
      semester: json['semester'],
      jurusan: json['program_studi'],
      konsentrasi: json['konsentrasi'],
      ips: json['ips'],
      ipk: json['ipk'],
      kreditDiambil: json['kredit_diambil'],
      bebanSksMaks: json['beban_maks_sks'],
      waktuPengisian: json['waktu_pengisian'],
      tahunAkademik: json['tahun_akademik'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'program_studi': jurusan,
      'ips': ips,
      'ipk': ipk,
      'kredit_diambil': kreditDiambil,
      'beban_sks_maks': bebanSksMaks,
      'semester': semester,
      'waktu_pengisian': waktuPengisian,
      'tahun_akademik': tahunAkademik
    };
  }
}
