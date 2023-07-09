import 'package:academic_system/src/helper/pdf_web_generate.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'schedule_pdf_event.dart';
part 'schedule_pdf_state.dart';

class SchedulePdfBloc extends Bloc<SchedulePdfEvent, SchedulePdfState> {
  final ScheduleRepository repository;

  SchedulePdfBloc({
    required this.repository,
  }) : super(SchedulePdfInitial()) {
    on<ExportSchedule>((event, emit) async {
      emit(SchedulePdfLoading());

      final List<Schedule> jadwalLengkap =
          await repository.getAllSchedule(event.tahunAkademik, event.semester);

      Map<String, Schedule> denormalisasiJadwal = {};

      for (var jadwal in jadwalLengkap) {
        var key =
            '${jadwal.learningSubName}-${jadwal.lecturerName}-${jadwal.day}-${jadwal.room}-${jadwal.semester}-${jadwal.tahunAkademik}-${jadwal.startsAt}-${jadwal.endsAt}';

        if (denormalisasiJadwal.containsKey(key)) {
          denormalisasiJadwal[key]!.idMatkul += " / ${jadwal.idMatkul}";
          if (denormalisasiJadwal[key]!.grade[1] == jadwal.grade[1]) {
            denormalisasiJadwal[key]!.grade =
                '${denormalisasiJadwal[key]!.grade.substring(0, 4)}TS';
          } else {
            denormalisasiJadwal[key]!.grade += " & ${jadwal.grade}";
          }
        } else {
          denormalisasiJadwal[key] = jadwal;
        }
      }

      List<Schedule> mergedScheduleList = denormalisasiJadwal.values.toList();

      final pdf = await PDFWebGenerate.generatePdf(
          mergedScheduleList, event.tahunAkademik, event.semester);

      try {
        emit(SchedulePdfLoaded(pdf: pdf));
      } catch (e) {
        emit(SchedulePdfError());
      }
    });

    on<ExportScheduleMobile>((event, emit) async {
      emit(SchedulePdfLoading());

      final List<Schedule> jadwalLengkap =
          await repository.getAllSchedule(event.tahunAkademik, event.semester);

      Map<String, Schedule> denormalisasiJadwal = {};

      for (var jadwal in jadwalLengkap) {
        var key =
            '${jadwal.learningSubName}-${jadwal.lecturerName}-${jadwal.day}-${jadwal.room}-${jadwal.semester}-${jadwal.tahunAkademik}-${jadwal.startsAt}-${jadwal.endsAt}';

        if (denormalisasiJadwal.containsKey(key)) {
          denormalisasiJadwal[key]!.idMatkul += " / ${jadwal.idMatkul}";
          if (denormalisasiJadwal[key]!.grade[1] == jadwal.grade[1]) {
            denormalisasiJadwal[key]!.grade =
                '${denormalisasiJadwal[key]!.grade.substring(0, 4)}TS';
          } else {
            denormalisasiJadwal[key]!.grade += " & ${jadwal.grade}";
          }
        } else {
          denormalisasiJadwal[key] = jadwal;
        }
      }

      List<Schedule> mergedScheduleList = denormalisasiJadwal.values.toList();

      try {
        emit(SchedulePdfMobileLoaded(jadwal: mergedScheduleList));
      } catch (e) {
        emit(SchedulePdfMobileError());
      }
    });
  }
}
