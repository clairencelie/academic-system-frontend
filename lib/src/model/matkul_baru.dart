class MatkulBaru {
  final String idMataKuliahMaster;
  final String idDosen;
  final String namaMataKuliah;
  final String jumlahSks;
  final String kelas;
  final String jenis;
  final String tahunAkademik;
  final String semester;

  const MatkulBaru({
    required this.idMataKuliahMaster,
    required this.idDosen,
    required this.namaMataKuliah,
    required this.jumlahSks,
    required this.kelas,
    required this.jenis,
    required this.tahunAkademik,
    required this.semester,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_mata_kuliah_master': idMataKuliahMaster,
      'id_dosen': idDosen,
      'nama_mata_kuliah': namaMataKuliah,
      'jumlah_sks': jumlahSks,
      'kelas': kelas,
      'jenis': jenis,
      'tahun_akademik': tahunAkademik,
      'semester': semester
    };
  }
}
