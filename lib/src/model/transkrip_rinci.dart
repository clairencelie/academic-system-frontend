import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/model/transkrip_nilai.dart';

class TranskripRinci {
  final TranskripNilai transkripNilai;
  final List<KartuHasilStudi> khs;
  final List<NilaiMahasiswa> listNilaiKhs;

  TranskripRinci({
    required this.transkripNilai,
    required this.khs,
    required this.listNilaiKhs,
  });

  factory TranskripRinci.createFromMap(Map<String, dynamic> map) {
    return TranskripRinci(
        transkripNilai: map['transkrip'],
        khs: map['khs'],
        listNilaiKhs: map['nilai']);
  }
}
