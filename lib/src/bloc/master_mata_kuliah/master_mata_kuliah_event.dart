part of 'master_mata_kuliah_bloc.dart';

abstract class MasterMataKuliahEvent extends Equatable {
  const MasterMataKuliahEvent();

  @override
  List<Object> get props => [];
}

class GetMataKuliahMaster extends MasterMataKuliahEvent {}
