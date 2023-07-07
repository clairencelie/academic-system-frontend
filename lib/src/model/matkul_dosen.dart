class MatkulDosen {
  final String idMataKuliah;
  final String idMataKuliahMaster;
  final String idDosen;
  final String nama;
  final String jumlahSks;
  final String kelas;
  final String jenis;
  final String tahunAkademik;
  final String semester;

  MatkulDosen({
    required this.idMataKuliah,
    required this.idMataKuliahMaster,
    required this.idDosen,
    required this.nama,
    required this.jumlahSks,
    required this.kelas,
    required this.jenis,
    required this.tahunAkademik,
    required this.semester,
  });

  factory MatkulDosen.createFromJson(Map<String, dynamic> json) {
    return MatkulDosen(
      idMataKuliah: json['id_mata_kuliah'].toString(),
      idMataKuliahMaster: json['id_mata_kuliah_master'],
      idDosen: json['id_dosen'].toString(),
      nama: json['nama_mata_kuliah'],
      jumlahSks: json['jumlah_sks'].toString(),
      kelas: json['kelas'],
      jenis: json['jenis'],
      tahunAkademik: json['tahun_akademik'],
      semester: json['semester'],
    );
  }
}
