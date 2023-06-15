class TranskripNilai {
  final String id;
  final String nim;
  final String jurusan;
  final String ipk;
  final int totalKreditDiambil;
  final int totalKreditDiperoleh;

  TranskripNilai({
    required this.id,
    required this.nim,
    required this.jurusan,
    required this.ipk,
    required this.totalKreditDiambil,
    required this.totalKreditDiperoleh,
  });

  factory TranskripNilai.createFromJson(Map<String, dynamic> json) {
    return TranskripNilai(
      id: json['id_transkrip_nilai'],
      nim: json['nim'],
      jurusan: json['program_studi'],
      ipk: json['ipk'],
      totalKreditDiambil: int.tryParse(json['total_kredit_diambil'])!,
      totalKreditDiperoleh: int.tryParse(json['total_kredit_diperoleh'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transkrip_nilai': id,
      'nim': nim,
      'program_studi': jurusan,
      'ipk': ipk,
      'total_kredit_diambil': totalKreditDiambil,
      'total_kredit_dperoleh': totalKreditDiperoleh,
    };
  }
}
