class NewKartuRencanaStudi {
  final String nim;
  final String semester;
  final String jurusan;
  final String ips;
  final String ipk;
  final String kreditDiambil;
  final String bebanSksMaks;
  final String waktuPengisian;
  final String tahunAkademik;

  NewKartuRencanaStudi({
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

  factory NewKartuRencanaStudi.createFromJson(Map<String, dynamic> json) {
    return NewKartuRencanaStudi(
      nim: json['nim'],
      semester: json['semester'],
      jurusan: json['program_studi'],
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
