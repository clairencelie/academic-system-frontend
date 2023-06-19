class NilaiMahasiswa {
  final String nim;
  final String nama;
  final String jurusan;
  final String idMataKuliah;
  final String idNilai;
  final int kehadiran;
  final int tugas;
  final int uts;
  final int uas;
  final int nilai;
  final String angkaKualitas;
  final String status;
  final String tahunAkademik;
  final String semester;

  NilaiMahasiswa({
    required this.nim,
    required this.nama,
    required this.jurusan,
    required this.idMataKuliah,
    required this.idNilai,
    required this.kehadiran,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.nilai,
    required this.angkaKualitas,
    required this.status,
    required this.tahunAkademik,
    required this.semester,
  });

  factory NilaiMahasiswa.createFromJson(Map<String, dynamic> json) {
    return NilaiMahasiswa(
      nim: json['nim'].toString(),
      nama: json['nama'],
      jurusan: json['jurusan'],
      idMataKuliah: json['id_mata_kuliah'],
      idNilai: json['id_nilai'].toString(),
      kehadiran: json['kehadiran'],
      tugas: json['tugas'],
      uts: json['uts'],
      uas: json['uas'],
      nilai: json['nilai'],
      angkaKualitas: json['angka_kualitas'],
      status: json['status'],
      tahunAkademik: json['tahun_akademik'],
      semester: json['semester'],
    );
  }
}
