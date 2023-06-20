import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/transkrip_nilai.dart';

class TranksripLengkap {
  final TranskripNilai transkripNilai;
  final List<KartuHasilStudi> khs;
  final List<String> matkulLulus;

  TranksripLengkap({
    required this.transkripNilai,
    required this.khs,
    required this.matkulLulus,
  });

  factory TranksripLengkap.createFromMap(Map<String, dynamic> map) {
    return TranksripLengkap(
        transkripNilai: map['transkrip'],
        khs: map['khs'],
        matkulLulus: map['matkul_lulus']);
  }
}
