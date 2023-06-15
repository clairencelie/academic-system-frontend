part of 'mata_kuliah_bloc.dart';

abstract class MataKuliahEvent extends Equatable {
  const MataKuliahEvent();

  @override
  List<Object> get props => [];
}

class GetMataKuliah extends MataKuliahEvent {}

class GetKRSMatkul extends MataKuliahEvent {
  final Student student;
  final KrsSchedule krsSchedule;

  const GetKRSMatkul({
    required this.student,
    required this.krsSchedule,
  });

  @override
  List<Object> get props => [student, krsSchedule];
}
