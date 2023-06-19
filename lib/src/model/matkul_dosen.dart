class MatkulDosen {
  final String idMataKuliah;
  final String idDosen;
  final String nama;
  final String jumlahSks;
  final String kelas;
  final String jenis;

  MatkulDosen({
    required this.idMataKuliah,
    required this.idDosen,
    required this.nama,
    required this.jumlahSks,
    required this.kelas,
    required this.jenis,
  });

  factory MatkulDosen.createFromJson(Map<String, dynamic> json) {
    return MatkulDosen(
      idMataKuliah: json['id_mata_kuliah'],
      idDosen: json['id_dosen'].toString(),
      nama: json['nama_mata_kuliah'],
      jumlahSks: json['jumlah_sks'].toString(),
      kelas: json['kelas'],
      jenis: json['jenis'],
    );
  }
}
