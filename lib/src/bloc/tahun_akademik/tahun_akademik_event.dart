part of 'tahun_akademik_bloc.dart';

abstract class TahunAkademikEvent extends Equatable {
  const TahunAkademikEvent();

  @override
  List<Object> get props => [];
}

class GetListTA extends TahunAkademikEvent {}

class SetTahunAkademik extends TahunAkademikEvent {
  final String tahunAkademik;
  final String semester;

  const SetTahunAkademik({
    required this.tahunAkademik,
    required this.semester,
  });

  @override
  List<Object> get props => [tahunAkademik, semester];
}
