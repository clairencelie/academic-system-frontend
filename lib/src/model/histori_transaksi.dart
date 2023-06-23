class HistoriTransaksi {
  final String idTransaksi;
  final String idPembayaranKuliah;
  final String idOrder;
  final String jenisPembayaran;
  final String bank;
  final String noVA;
  final String totalPembayaran;
  final String waktuTransaksi;
  final String statusTransaksi;
  final String waktuKedaluwarsa;

  HistoriTransaksi({
    required this.idTransaksi,
    required this.idPembayaranKuliah,
    required this.idOrder,
    required this.jenisPembayaran,
    required this.bank,
    required this.noVA,
    required this.totalPembayaran,
    required this.waktuTransaksi,
    required this.statusTransaksi,
    required this.waktuKedaluwarsa,
  });

  factory HistoriTransaksi.createFromJson(Map<String, dynamic> json) {
    return HistoriTransaksi(
      idTransaksi: json['id_transaksi'],
      idPembayaranKuliah: json['id_pembayaran_kuliah'],
      idOrder: json['id_order'],
      jenisPembayaran: json['jenis_pembayaran'],
      bank: json['bank'],
      noVA: json['no_va'],
      totalPembayaran: json['total_pembayaran'].toString(),
      waktuTransaksi: json['waktu_transaksi'],
      statusTransaksi: json['status_transaksi'],
      waktuKedaluwarsa: json['waktu_kedaluwarsa'],
    );
  }
}
