class KartuHasilStudi {
  final String id;
  final String idTranskrip;
  final String semester;
  final String ips;
  final String kreditDiambil;
  final String kreditDiperoleh;
  final String maskSks;
  final String tahunAkademik;

  KartuHasilStudi({
    required this.id,
    required this.idTranskrip,
    required this.semester,
    required this.ips,
    required this.kreditDiambil,
    required this.kreditDiperoleh,
    required this.maskSks,
    required this.tahunAkademik,
  });

  factory KartuHasilStudi.createFromJson(Map<String, dynamic> json) {
    return KartuHasilStudi(
      id: json['id_khs'],
      idTranskrip: json['id_transkrip_nilai'],
      semester: json['semester'],
      ips: json['ips'],
      kreditDiambil: json['kredit_diambil'],
      kreditDiperoleh: json['kredit_diperoleh'],
      maskSks: json['maks_sks_smt_slnjt'],
      tahunAkademik: json['tahun_akademik'],
    );
  }
}
