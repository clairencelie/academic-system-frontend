import 'package:academic_system/src/repository/krs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/kartu_rencana_studi.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';

part 'krs_event.dart';
part 'krs_state.dart';

class KrsBloc extends Bloc<KrsEvent, KrsState> {
  final KrsRepository repository;
  KrsBloc({required this.repository}) : super(KrsInitial()) {
    on<GetKrsSchedule>((event, emit) async {
      emit(KrsLoading());

      KrsSchedule? krsSchedule = await repository.getKrsSchedule();

      bool isAlreadyFillKrs = false;

      final List<KartuRencanaStudi> krs = await repository.getKrs(event.nim);

      if (krs.isNotEmpty) {
        for (var element in krs) {
          if (element.semester == event.semester) {
            isAlreadyFillKrs = true;
          }
        }
      }

      if (krsSchedule != null) {
        if (isAlreadyFillKrs) {
          emit(AlreadyFillKrs(
              message:
                  'Anda telah mengisi KRS untuk Semester ${krsSchedule.semester} Tahun Akademik ${krsSchedule.tahunAkademik}'));
        } else {
          emit(KrsScheduleLoaded(krsSchedule: krsSchedule));
        }
      } else {
        emit(KrsScheduleNotFound());
      }
    });

    on<GetKrsScheduleForUpdate>((event, emit) async {
      emit(KrsLoading());

      KrsSchedule? krsSchedule = await repository.getKrsSchedule();

      if (krsSchedule != null) {
        emit(KrsScheduleLoaded(krsSchedule: krsSchedule));
      } else {
        emit(KrsScheduleNotFound());
      }
    });

    on<GetKrsLengkap>((event, emit) async {
      emit(KrsLoading());
      final List<KartuRencanaStudiLengkap> krsLengkap =
          await repository.getKrsLengkap(event.nim);

      if (krsLengkap.isNotEmpty) {
        emit(KrsFound(krsLengkap: krsLengkap));
      } else {
        emit(KrsNotFound());
      }
    });

    on<GetKrsSmtIni>((event, emit) async {
      emit(KrsLoading());
      final List<KartuRencanaStudiLengkap> krsLengkap =
          await repository.getKrsLengkap(event.nim);
      if (krsLengkap.isNotEmpty) {
        try {
          KartuRencanaStudiLengkap krsSmtIni = krsLengkap
              .where((element) =>
                  element.tahunAkademik == event.tahunAkademik &&
                  element.semester == event.semester)
              .first;

          emit(KrsSmtIniFound(krsLengkap: krsSmtIni));
        } catch (e) {
          emit(KrsSmtIniNotFound());
        }
      } else {
        emit(KrsSmtIniNotFound());
      }
    });

    on<GetAllKrs>((event, emit) async {
      emit(KrsLoading());
      final List<KartuRencanaStudiLengkap> krsLengkap =
          await repository.getAllKrs();

      if (krsLengkap.isNotEmpty) {
        emit(KrsFound(krsLengkap: krsLengkap));
      } else {
        emit(KrsNotFound());
      }
    });

    on<GetTahunAkademik>((event, emit) async {
      emit(KrsLoading());

      final KrsSchedule? krsSchedule = await repository.getKrsSchedule();

      if (krsSchedule != null) {
        emit(KrsScheduleLoaded(krsSchedule: krsSchedule));
      } else {
        emit(KrsScheduleNotFound());
      }
    });
  }
}
