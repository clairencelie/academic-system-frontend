import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/transkrip_nilai.dart';

class TranksripLengkap {
  final TranskripNilai transkripNilai;
  final List<KartuHasilStudi> khs;

  TranksripLengkap({
    required this.transkripNilai,
    required this.khs,
  });

  factory TranksripLengkap.createFromMap(Map<String, dynamic> map) {
    return TranksripLengkap(transkripNilai: map['transkrip'], khs: map['khs']);
  }
}
