import 'package:academic_system/src/repository/krs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/new_kartu_rencana_studi.dart';

part 'krs_management_event.dart';
part 'krs_management_state.dart';

class KrsManagementBloc extends Bloc<KrsManagementEvent, KrsManagementState> {
  final KrsRepository repository;
  KrsManagementBloc({required this.repository})
      : super(KrsManagementInitial()) {
    on<CreateKrs>((event, emit) async {
      emit(KrsManagementLoading());

      String message =
          await repository.createKrs(event.krs, event.mataKuliahDiambil);

      if (message == "krs created successfully") {
        emit(const CreateKrsSuccess(
            message: "Kartu rencana studi berhasil diajukan."));
      } else {
        emit(const CreateKrsFailed(
            message: "Kartu rencana studi gagal diajukan"));
      }
    });

    on<UpdateKrs>((event, emit) async {
      emit(KrsManagementLoading());

      String message = await repository.updateKrs(
          event.idKrs, event.krs, event.mataKuliahDiambil);

      if (message == "krs berhasil diupdate") {
        emit(const UpdateKrsSuccess(
            message: "Perubahan kartu rencana studi berhasil diajukan."));
      } else {
        emit(UpdateKrsFailed(message: message));
      }
    });

    on<LockKrs>((event, emit) async {
      emit(KrsManagementLoading());

      String message = await repository.lockKrs(event.idKrs);

      if (message == "krs commited successfuly") {
        emit(const LockKrsSuccess(message: "Krs Berhasil dikunci"));
      } else {
        emit(LockKrsFailed(message: message));
      }
    });
  }
}
