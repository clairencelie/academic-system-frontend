part of 'nilai_bloc.dart';

abstract class NilaiEvent extends Equatable {
  const NilaiEvent();

  @override
  List<Object> get props => [];
}

class UpdateNilaiMhs extends NilaiEvent {
  final String nim;
  final String idKhs;
  final String idNilai;
  final String jumlahSks;
  final int kehadiran;
  final int tugas;
  final int uts;
  final int uas;

  const UpdateNilaiMhs({
    required this.nim,
    required this.idKhs,
    required this.idNilai,
    required this.jumlahSks,
    required this.kehadiran,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  @override
  List<Object> get props => [
        nim,
        idKhs,
        idNilai,
        jumlahSks,
        kehadiran,
        tugas,
        uts,
        uas,
      ];
}
