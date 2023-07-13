import 'package:academic_system/src/bloc/all_schedule/all_schedule_bloc.dart';
import 'package:academic_system/src/bloc/pdf_export/schedule_pdf_bloc.dart';
import 'package:academic_system/src/helper/pdf_generate.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/ui/mobile/component/card/simple_schedule_card.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/schedule_not_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSchedulePageMobile extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const AllSchedulePageMobile({
    super.key,
    required this.krsSchedule,
  });

  @override
  State<AllSchedulePageMobile> createState() => _AllSchedulePageMobileState();
}

class _AllSchedulePageMobileState extends State<AllSchedulePageMobile> {
  @override
  void initState() {
    super.initState();
    context.read<AllScheduleBloc>().add(GetAllSchedule(
          tahunAkademik: widget.krsSchedule.tahunAkademik,
          semester: widget.krsSchedule.semester,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderAllSchedulePage(),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AllScheduleBloc, AllScheduleState>(
                      builder: (context, state) {
                        if (state is AllScheduleFound) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Anda dapat mengunduh jadwal perkuliahan lengkap dalam bentuk pdf disini: ',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ExportScheduleButton(
                                krsSchedule: widget.krsSchedule,
                                schedules: state.schedules,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'List Jadwal Perkuliahan Lengkap',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListJadwalPerkuliahanPerHari(
                                jadwalPerkuliahan: state.schedules,
                                hari: 'Senin',
                              ),
                              ListJadwalPerkuliahanPerHari(
                                jadwalPerkuliahan: state.schedules,
                                hari: 'Selasa',
                              ),
                              ListJadwalPerkuliahanPerHari(
                                jadwalPerkuliahan: state.schedules,
                                hari: 'Rabu',
                              ),
                              ListJadwalPerkuliahanPerHari(
                                jadwalPerkuliahan: state.schedules,
                                hari: 'Kamis',
                              ),
                              ListJadwalPerkuliahanPerHari(
                                jadwalPerkuliahan: state.schedules,
                                hari: 'Jumat',
                              ),
                            ],
                          );
                        } else if (state is AllScheduleEmpty) {
                          return const ScheduleNotAvailable();
                        } else if (state is AllScheduleRequestFailed) {
                          return const Text(
                              'Gagal mendapatkan data jadwal perkuliahan');
                        }
                        return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExportScheduleButton extends StatelessWidget {
  final KrsSchedule krsSchedule;
  final List<Schedule> schedules;

  const ExportScheduleButton({
    Key? key,
    required this.krsSchedule,
    required this.schedules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchedulePdfBloc, SchedulePdfState>(
      listener: (context, state) async {
        if (state is SchedulePdfLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 32, 96),
                ),
              );
            },
          );
        } else if (state is SchedulePdfMobileLoaded) {
          Navigator.of(context, rootNavigator: true).pop();
          final pdf = await PDFGenerate.generatePdf(
              state.jadwal, krsSchedule.tahunAkademik, krsSchedule.semester);

          PDFGenerate.openFile(pdf);
        }
      },
      child: TextButton(
        onPressed: () {
          context.read<SchedulePdfBloc>().add(
                ExportScheduleMobile(
                  tahunAkademik: krsSchedule.tahunAkademik,
                  semester: krsSchedule.semester,
                ),
              );
        },
        child: Text(
          'Jadwal Perkuliahan T.A ${krsSchedule.tahunAkademik} - ${krsSchedule.semester[0].toUpperCase()}${krsSchedule.semester.substring(1)}.pdf',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class ListJadwalPerkuliahanPerHari extends StatelessWidget {
  final List<Schedule> jadwalPerkuliahan;
  final String hari;

  const ListJadwalPerkuliahanPerHari({
    super.key,
    required this.jadwalPerkuliahan,
    required this.hari,
  });

  @override
  Widget build(BuildContext context) {
    List<Schedule> jadwalSesuaiHari =
        jadwalPerkuliahan.where((element) => element.day == hari).toList();

    Map<String, Schedule> denormalisasiJadwal = {};

    for (var jadwal in jadwalSesuaiHari) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          hari,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        jadwalSesuaiHari.isEmpty
            ? const Text('Belum ada data jadwal')
            : SizedBox(
                height: 165,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: mergedScheduleList.length,
                  itemBuilder: (context, index) {
                    Schedule jadwal = mergedScheduleList[index];

                    return SimpleScheduleCard(schedule: jadwal);
                  },
                ),
              ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class HeaderAllSchedulePage extends StatelessWidget {
  const HeaderAllSchedulePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Jadwal Perkuliahan Lengkap',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
