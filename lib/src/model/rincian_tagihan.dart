class RincianTagihan {
  final String idRincianTagihan;
  final String idTagihanPerkuliahan;
  final String item;
  final int jumlahItem;
  final int hargaItem;
  final int totalHargaItem;

  RincianTagihan({
    required this.idRincianTagihan,
    required this.idTagihanPerkuliahan,
    required this.item,
    required this.jumlahItem,
    required this.hargaItem,
    required this.totalHargaItem,
  });

  factory RincianTagihan.createFromJson(Map<String, dynamic> json) {
    return RincianTagihan(
      idRincianTagihan: json['idRincianTagihan'],
      idTagihanPerkuliahan: json['idTagihanPerkuliahan'],
      item: json['item'],
      jumlahItem: int.tryParse(json['jumlahItem'])!,
      hargaItem: int.tryParse(json['hargaItem'])!,
      totalHargaItem: int.tryParse(json['totalHargaItem'])!,
    );
  }
}
