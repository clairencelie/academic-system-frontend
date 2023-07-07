class MasterMatkul {
  final String idMataKuliahMaster;
  final String nama;
  final int jumlahSKS;
  final String jenis;

  MasterMatkul({
    required this.idMataKuliahMaster,
    required this.nama,
    required this.jumlahSKS,
    required this.jenis,
  });

  factory MasterMatkul.createFromJson(Map<String, dynamic> json) {
    return MasterMatkul(
      idMataKuliahMaster: json['id_mata_kuliah_master'],
      nama: json['nama_mata_kuliah'],
      jumlahSKS: json['jumlah_sks'],
      jenis: json['jenis'],
    );
  }
}
