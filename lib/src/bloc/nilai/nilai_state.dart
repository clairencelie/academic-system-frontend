part of 'nilai_bloc.dart';

abstract class NilaiState extends Equatable {
  const NilaiState();

  @override
  List<Object> get props => [];
}

class NilaiInitial extends NilaiState {}

class NilaiLoading extends NilaiState {}

class UpdateNilaiSuccess extends NilaiState {
  final String message;

  const UpdateNilaiSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UpdateNilaiFailed extends NilaiState {
  final String message;

  const UpdateNilaiFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
