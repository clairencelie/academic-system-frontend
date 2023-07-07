part of 'matkul_management_bloc.dart';

abstract class MatkulManagementEvent extends Equatable {
  const MatkulManagementEvent();

  @override
  List<Object> get props => [];
}

class TambahMataKuliah extends MatkulManagementEvent {
  final MatkulBaru matkulBaru;

  const TambahMataKuliah({
    required this.matkulBaru,
  });

  @override
  List<Object> get props => [matkulBaru];
}

class UpdateMataKuliah extends MatkulManagementEvent {
  final LearningSubject matkulBaru;

  const UpdateMataKuliah({
    required this.matkulBaru,
  });

  @override
  List<Object> get props => [matkulBaru];
}

class DeleteMataKuliah extends MatkulManagementEvent {
  final String id;

  const DeleteMataKuliah({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
