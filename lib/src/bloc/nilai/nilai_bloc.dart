import 'package:academic_system/src/repository/nilai_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nilai_event.dart';
part 'nilai_state.dart';

class NilaiBloc extends Bloc<NilaiEvent, NilaiState> {
  final NilaiRepository repository;

  NilaiBloc({required this.repository}) : super(NilaiInitial()) {
    on<UpdateNilaiMhs>((event, emit) async {
      emit(NilaiLoading());

      final String message = await repository.updateNilai(
        event.nim,
        event.idKhs,
        event.idNilai,
        event.jumlahSks,
        event.kehadiran,
        event.tugas,
        event.uts,
        event.uas,
      );

      if (message == 'update khs berhasil') {
        emit(const UpdateNilaiSuccess(message: 'Update nilai berhasil'));
      } else {
        emit(
            UpdateNilaiFailed(message: 'Update nilai gagal.\nError: $message'));
      }
    });
  }
}
