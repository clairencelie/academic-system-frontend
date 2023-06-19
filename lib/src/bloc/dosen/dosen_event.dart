part of 'dosen_bloc.dart';

abstract class DosenEvent extends Equatable {
  const DosenEvent();

  @override
  List<Object> get props => [];
}

class GetMatkulDosen extends DosenEvent {
  final String idDosen;

  const GetMatkulDosen({
    required this.idDosen,
  });

  @override
  List<Object> get props => [idDosen];
}

class GetNilaiMhs extends DosenEvent {
  final String idMataKuliah;
  final String tahunAkademik;
  final String semester;

  const GetNilaiMhs({
    required this.idMataKuliah,
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [
        idMataKuliah,
        tahunAkademik,
        semester,
      ];
}
