part of 'mata_kuliah_bloc.dart';

abstract class MataKuliahState extends Equatable {
  const MataKuliahState();

  @override
  List<Object> get props => [];
}

class MataKuliahInitial extends MataKuliahState {}

class MataKuliahLoading extends MataKuliahState {}

class MataKuliahFound extends MataKuliahState {
  final List<LearningSubject> learningSubjects;

  const MataKuliahFound({required this.learningSubjects});

  @override
  List<Object> get props => [learningSubjects];
}

class MataKuliahNotFound extends MataKuliahState {
  final String message;

  const MataKuliahNotFound({required this.message});

  @override
  List<Object> get props => [message];
}

class KRSMatkulFound extends MataKuliahState {
  final List<LearningSubject> learningSubjects;

  const KRSMatkulFound({required this.learningSubjects});

  @override
  List<Object> get props => [learningSubjects];
}

class KRSMatkulNotFound extends MataKuliahState {
  final String message;

  const KRSMatkulNotFound({required this.message});

  @override
  List<Object> get props => [message];
}
