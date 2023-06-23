import 'package:academic_system/src/repository/nilai_repository.dart';
import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/tahun_akademik.dart';

part 'tahun_akademik_event.dart';
part 'tahun_akademik_state.dart';

class TahunAkademikBloc extends Bloc<TahunAkademikEvent, TahunAkademikState> {
  final NilaiRepository nilaiRepository;
  final ScheduleRepository scheduleRepository;

  TahunAkademikBloc(
      {required this.nilaiRepository, required this.scheduleRepository})
      : super(TahunAkademikInitial()) {
    on<GetListTA>((event, emit) async {
      emit(TahunAkademikLoading());

      final List<TahunAkademik> listTA =
          await nilaiRepository.getTahunAkademik();

      if (listTA.isNotEmpty) {
        emit(TahunAkademikLoaded(listTA: listTA));
      } else {
        emit(TahunAkademikNotFound());
      }
    });

    on<SetTahunAkademik>((event, emit) async {
      emit(TahunAkademikLoading());

      final String message = await scheduleRepository.setTahunAkademik(
          event.tahunAkademik, event.semester);

      if (message == 'set tahun akademik baru berhasil') {
        emit(TahunAkademikUpdateSuccess(message: message));
      } else {
        emit(TahunAkademikUpdateFailed(message: message));
      }
    });
  }
}
