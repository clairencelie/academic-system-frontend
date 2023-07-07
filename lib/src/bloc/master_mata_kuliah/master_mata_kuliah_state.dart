part of 'master_mata_kuliah_bloc.dart';

abstract class MasterMataKuliahState extends Equatable {
  const MasterMataKuliahState();

  @override
  List<Object> get props => [];
}

class MasterMataKuliahInitial extends MasterMataKuliahState {}

class MasterMataKuliahLoading extends MasterMataKuliahState {}

class MasterMataKuliahFound extends MasterMataKuliahState {
  final List<MasterMatkul> listMasterMatkul;

  const MasterMataKuliahFound({
    required this.listMasterMatkul,
  });

  @override
  List<Object> get props => [listMasterMatkul];
}

class MasterMataKuliahNotFound extends MasterMataKuliahState {}
