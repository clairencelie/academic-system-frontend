class NilaiMahasiswa {
  final String idKhs;
  final String nim;
  final String nama;
  final String jurusan;
  final String idMataKuliah;
  final String idMataKuliahMaster;
  final String namaMataKuliah;
  final String idNilai;
  final int kehadiran;
  final int tugas;
  final int uts;
  final int uas;
  final String nilai;
  final int angkaKualitas;
  final int jumlahSks;
  final String status;
  final String tahunAkademik;
  final String semester;

  NilaiMahasiswa({
    required this.idKhs,
    required this.nim,
    required this.nama,
    required this.jurusan,
    required this.idMataKuliah,
    required this.idMataKuliahMaster,
    required this.namaMataKuliah,
    required this.idNilai,
    required this.kehadiran,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.nilai,
    required this.angkaKualitas,
    required this.jumlahSks,
    required this.status,
    required this.tahunAkademik,
    required this.semester,
  });

  factory NilaiMahasiswa.createFromJson(Map<String, dynamic> json) {
    return NilaiMahasiswa(
      idKhs: json['id_khs']?.toString() ?? '',
      nim: json['nim']?.toString() ?? '',
      nama: json['nama'] ?? '',
      jurusan: json['jurusan'] ?? '',
      idMataKuliah: json['id_mata_kuliah'].toString(),
      idMataKuliahMaster: json['id_mata_kuliah_master'],
      namaMataKuliah: json['nama_mata_kuliah'] ?? '',
      idNilai: json['id_nilai'].toString(),
      kehadiran: json['kehadiran'],
      tugas: json['tugas'],
      uts: json['uts'],
      uas: json['uas'],
      nilai: json['nilai'],
      angkaKualitas: json['angka_kualitas'],
      jumlahSks: json['jumlah_sks'],
      status: json['status'],
      tahunAkademik: json['tahun_akademik'],
      semester: json['semester'],
    );
  }
}
