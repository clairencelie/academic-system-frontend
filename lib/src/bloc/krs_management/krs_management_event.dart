part of 'krs_management_bloc.dart';

abstract class KrsManagementEvent extends Equatable {
  const KrsManagementEvent();

  @override
  List<Object> get props => [];
}

class CreateKrs extends KrsManagementEvent {
  final NewKartuRencanaStudi krs;
  final List<String> mataKuliahDiambil;

  const CreateKrs({
    required this.krs,
    required this.mataKuliahDiambil,
  });

  @override
  List<Object> get props => [krs, mataKuliahDiambil];
}

class UpdateKrs extends KrsManagementEvent {
  final String idKrs;
  final NewKartuRencanaStudi krs;
  final List<String> mataKuliahDiambil;

  const UpdateKrs({
    required this.idKrs,
    required this.krs,
    required this.mataKuliahDiambil,
  });

  @override
  List<Object> get props => [krs, mataKuliahDiambil];
}

class LockKrs extends KrsManagementEvent {
  final String idKrs;

  const LockKrs({required this.idKrs});

  @override
  List<Object> get props => [idKrs];
}

class ApproveKrs extends KrsManagementEvent {
  final String idKrs;

  const ApproveKrs({required this.idKrs});

  @override
  List<Object> get props => [idKrs];
}
