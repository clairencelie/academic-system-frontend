part of 'dosen_bloc.dart';

abstract class DosenState extends Equatable {
  const DosenState();

  @override
  List<Object> get props => [];
}

class DosenInitial extends DosenState {}

class DosenLoading extends DosenState {}

class MatkulDosenFound extends DosenState {
  final List<MatkulDosen> matkulDosen;

  const MatkulDosenFound({
    required this.matkulDosen,
  });

  @override
  List<Object> get props => [matkulDosen];
}

class MatkulDosenNotFound extends DosenState {}

class NilaiMhsFound extends DosenState {
  final List<NilaiMahasiswa> nilaiMhsList;

  const NilaiMhsFound({
    required this.nilaiMhsList,
  });

  @override
  List<Object> get props => [nilaiMhsList];
}

class NilaiMhsNotFound extends DosenState {}
