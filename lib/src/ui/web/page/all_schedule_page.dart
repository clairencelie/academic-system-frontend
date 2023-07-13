import 'package:academic_system/src/bloc/all_schedule/all_schedule_bloc.dart';
import 'package:academic_system/src/bloc/pdf_export/schedule_pdf_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/web_schedule_not_available.dart';
import 'package:academic_system/src/ui/web/page/schedule_pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSchedulePage extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const AllSchedulePage({
    super.key,
    required this.krsSchedule,
  });

  @override
  State<AllSchedulePage> createState() => _AllSchedulePageState();
}

class _AllSchedulePageState extends State<AllSchedulePage> {
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
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
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
                            ListJadwalPerkuliahanLengkap(
                              jadwalPerkuliahan: state.schedules,
                            ),
                          ],
                        );
                      } else if (state is AllScheduleEmpty) {
                        return const WebScheduleNotAvailable();
                      } else if (state is AllScheduleRequestFailed) {
                        return const Text(
                            'Gagal mendapatkan data jadwal perkuliahan');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
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
      listener: (context, state) {
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
        } else if (state is SchedulePdfLoaded) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SchedulePDFPreview(pdf: state.pdf);
              },
            ),
          );
        }
      },
      child: TextButton(
        onPressed: () {
          context.read<SchedulePdfBloc>().add(
                ExportSchedule(
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

class ListJadwalPerkuliahanLengkap extends StatelessWidget {
  final List<Schedule> jadwalPerkuliahan;

  ListJadwalPerkuliahanLengkap({
    Key? key,
    required this.jadwalPerkuliahan,
  }) : super(key: key);

  final List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: hari.length,
      itemBuilder: (context, index) {
        return ListJadwalPerkuliahanPerHari(
          jadwalPerkuliahan: jadwalPerkuliahan,
          hari: hari[index],
        );
      },
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
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            hari,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
        const HeaderListJadwalHarian(),
        const Divider(),
        jadwalSesuaiHari.isEmpty
            ? const Text('Belum ada data jadwal')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: mergedScheduleList.length,
                itemBuilder: (context, index) {
                  Schedule jadwal = mergedScheduleList[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    color: index % 2 == 0
                        ? const Color.fromARGB(255, 232, 232, 232)
                        : const Color.fromARGB(255, 245, 245, 245),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              jadwal.idMatkul,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            jadwal.learningSubName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            jadwal.lecturerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            jadwal.grade,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            jadwal.room,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${jadwal.startsAt} - ${jadwal.endsAt}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class HeaderListJadwalHarian extends StatelessWidget {
  const HeaderListJadwalHarian({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Kode MK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Nama MK',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Dosen Pengajar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              'Kelas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Ruangan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Waktu',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
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
          'Detail Kelas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
