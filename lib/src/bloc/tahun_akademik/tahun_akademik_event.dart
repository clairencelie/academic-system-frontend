part of 'tahun_akademik_bloc.dart';

abstract class TahunAkademikEvent extends Equatable {
  const TahunAkademikEvent();

  @override
  List<Object> get props => [];
}

class GetListTA extends TahunAkademikEvent {}
