part of 'krs_management_bloc.dart';

abstract class KrsManagementState extends Equatable {
  const KrsManagementState();

  @override
  List<Object> get props => [];
}

class KrsManagementInitial extends KrsManagementState {}

class KrsManagementLoading extends KrsManagementState {}

class CreateKrsSuccess extends KrsManagementState {
  final String message;

  const CreateKrsSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UpdateKrsFailed extends KrsManagementState {
  final String message;

  const UpdateKrsFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UpdateKrsSuccess extends KrsManagementState {
  final String message;

  const UpdateKrsSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class LockKrsFailed extends KrsManagementState {
  final String message;

  const LockKrsFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class LockKrsSuccess extends KrsManagementState {
  final String message;

  const LockKrsSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ApproveKrsFailed extends KrsManagementState {
  final String message;

  const ApproveKrsFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ApproveKrsSuccess extends KrsManagementState {
  final String message;

  const ApproveKrsSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UnApproveKrsFailed extends KrsManagementState {
  final String message;

  const UnApproveKrsFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class UnApproveKrsSuccess extends KrsManagementState {
  final String message;

  const UnApproveKrsSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CreateKrsFailed extends KrsManagementState {
  final String message;

  const CreateKrsFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
