part of 'tahun_akademik_bloc.dart';

abstract class TahunAkademikState extends Equatable {
  const TahunAkademikState();

  @override
  List<Object> get props => [];
}

class TahunAkademikInitial extends TahunAkademikState {}

class TahunAkademikLoading extends TahunAkademikState {}

class TahunAkademikLoaded extends TahunAkademikState {
  final List<TahunAkademik> listTA;

  const TahunAkademikLoaded({
    required this.listTA,
  });

  @override
  List<Object> get props => [listTA];
}

class TahunAkademikNotFound extends TahunAkademikState {}

class TahunAkademikUpdateSuccess extends TahunAkademikState {
  final String message;

  const TahunAkademikUpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class TahunAkademikUpdateFailed extends TahunAkademikState {
  final String message;

  const TahunAkademikUpdateFailed({required this.message});

  @override
  List<Object> get props => [message];
}
