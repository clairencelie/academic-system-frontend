part of 'matkul_management_bloc.dart';

abstract class MatkulManagementState extends Equatable {
  const MatkulManagementState();

  @override
  List<Object> get props => [];
}

class MatkulManagementInitial extends MatkulManagementState {}

class MatkulManagementLoading extends MatkulManagementState {}

class CreateMatkulSuccess extends MatkulManagementState {}

class CreateMatkulFailed extends MatkulManagementState {}

class MatkulUpdateSuccess extends MatkulManagementState {}

class MatkulUpdateFailed extends MatkulManagementState {}

class MatkulDeleteSuccess extends MatkulManagementState {}

class MatkulDeleteFailed extends MatkulManagementState {}
