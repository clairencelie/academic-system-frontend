class TagihanPerkuliahan {
  final String idTagihanPerkuliahan;
  final String nim;
  final int totalTagihan;
  final int sisaPembayaran;
  final String statusPembayaran;
  final String metodePembayaran;
  final String kategori;
  final String tahunAkademik;
  final String semester;

  TagihanPerkuliahan({
    required this.idTagihanPerkuliahan,
    required this.nim,
    required this.totalTagihan,
    required this.sisaPembayaran,
    required this.statusPembayaran,
    required this.metodePembayaran,
    required this.kategori,
    required this.tahunAkademik,
    required this.semester,
  });

  factory TagihanPerkuliahan.createFromJson(Map<String, dynamic> json) {
    return TagihanPerkuliahan(
      idTagihanPerkuliahan: json['idTagihanPerkuliahan'],
      nim: json['nim'],
      totalTagihan: int.tryParse(json['totalTagihan'])!,
      sisaPembayaran: int.tryParse(json['sisaPembayaran'])!,
      statusPembayaran: json['statusPembayaran'],
      metodePembayaran: json['metodePembayaran'],
      kategori: json['kategori'],
      tahunAkademik: json['tahunAkademik'],
      semester: json['semester'],
    );
  }
}
