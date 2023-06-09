class KartuRencanaStudi {
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

  KartuRencanaStudi({
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
  });

  factory KartuRencanaStudi.createFromJson(Map<String, dynamic> json) {
    return KartuRencanaStudi(
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
