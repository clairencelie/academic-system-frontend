class TahunAkademik {
  final String tahunAkademik;

  TahunAkademik({
    required this.tahunAkademik,
  });

  factory TahunAkademik.createFromJson(Map<String, dynamic> json) {
    return TahunAkademik(
        tahunAkademik: '${json['tahun_akademik']} ${json['semester']}');
  }
}
