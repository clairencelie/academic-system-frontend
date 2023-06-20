import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/new_kartu_rencana_studi.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/matkul_per_semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMatkulEditKRS extends StatefulWidget {
  const ListMatkulEditKRS({
    Key? key,
    required this.user,
    required this.krsSchedule,
    required this.krs,
    required this.tranksripLengkap,
  }) : super(key: key);

  final Student user;
  final KrsSchedule krsSchedule;
  // data transkrip untuk mendapatkan data maks beban sks
  final KartuRencanaStudiLengkap krs;
  final TranksripLengkap tranksripLengkap;

  @override
  State<ListMatkulEditKRS> createState() => _ListMatkulEditKRSState();
}

class _ListMatkulEditKRSState extends State<ListMatkulEditKRS> {
  List<String> learningSubIds = [];
  int totalSks = 0;

  void totalSksIncrement(int credit) {
    setState(() {
      totalSks += credit;
    });
  }

  void totalSksDecrement(int credit) {
    setState(() {
      totalSks -= credit;
    });
  }

  void addLearningSubIds(String id) {
    setState(() {
      learningSubIds.add(id);
    });
  }

  void removeLearningSubIds(String id) {
    setState(() {
      learningSubIds.remove(id);
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<MataKuliahBloc>().add(
        GetKRSMatkul(student: widget.user, krsSchedule: widget.krsSchedule));

    learningSubIds =
        widget.krs.pilihanMataKuliah.map((matkul) => matkul.id).toList();
    totalSks = int.tryParse(widget.krs.kreditDiambil)!;
  }

  @override
  Widget build(BuildContext context) {
    // int maxSks = int.tryParse(widget.user.semester)! <= 4 ? 20 : 24;
    List<String> idMatkulLulus = widget.tranksripLengkap.matkulLulus;

    // int maxSks = int.tryParse(widget.krs.bebanSksMaks)!;
    String maxSksFromTranskrip = widget.tranksripLengkap.khs.isEmpty
        ? "20"
        : widget.tranksripLengkap.khs
            .where((element) =>
                element.semester ==
                (int.tryParse(widget.user.semester)! - 1).toString())
            .toList()[0]
            .maskSks;
    int maxSks = int.tryParse(widget.user.semester)! <= 4
        ? 20
        : int.tryParse(maxSksFromTranskrip)!;

    return BlocBuilder<MataKuliahBloc, MataKuliahState>(
      builder: (context, state) {
        if (state is MataKuliahFound) {
          final List<LearningSubject> userLearningSubjects =
              state.learningSubjects;

          List<int> semesterList = (widget.krsSchedule.semester == 'genap')
              ? [2, 4, 6, 8]
              : [1, 3, 5, 7];

          List<List<LearningSubject>> separatedCourses = List.generate(
            semesterList.length,
            (semesterIndex) => userLearningSubjects
                .where((matkul) =>
                    matkul.grade.contains('${semesterList[semesterIndex]}'))
                .toList(),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pilihan Mata Kuliah',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${DateConverter.convertToDartDateFormat(widget.krsSchedule.tanggalMulai)} - ${DateConverter.convertToDartDateFormat(widget.krsSchedule.tanggalSelesai)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: semesterList
                    .map(
                      (value) => MatkulPerSemester(
                        user: widget.user,
                        semester: value.toString(),
                        learningSubIds: learningSubIds,
                        matkulLulus: idMatkulLulus,
                        matkul: separatedCourses[semesterList.indexOf(value)],
                        maxSks: maxSks,
                        totalSks: totalSks,
                        totalSksIncrement: totalSksIncrement,
                        totalSksDecrement: totalSksDecrement,
                        addLearningSubIds: addLearningSubIds,
                        removeLearningSubIds: removeLearningSubIds,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Total SKS yang diambil: $totalSks',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Maks SKS yang bisa diambil: $maxSks',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocListener<KrsManagementBloc, KrsManagementState>(
                listener: (context, state) {
                  // TODO: Ganti statenya listen to UpdateKrsSuccess
                  if (state is UpdateKrsSuccess) {
                    Navigator.of(context, rootNavigator: true).pop();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return InfoDialog(
                          title: 'Informasi',
                          body: state.message,
                          onClose: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // Get krs mahasiswa
                            context.read<KrsBloc>().add(GetKrsSchedule(
                                  nim: widget.user.id,
                                  semester: widget.user.semester,
                                ));
                          },
                        );
                      },
                    );
                  } else if (state is UpdateKrsFailed) {
                    Navigator.of(context, rootNavigator: true).pop();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return InfoDialog(
                          title: 'Informasi',
                          body: state.message,
                          onClose: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  } else if (state is KrsManagementLoading) {
                    // TODO: show dialog loading
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
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Show dialog konfirmasi
                    print(learningSubIds);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Konfirmasi',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 32, 96),
                            ),
                          ),
                          content: const Text(
                            'Pastikan pilihan mata kuliah anda sudah sesuai.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cek kembali',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 32, 96),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                NewKartuRencanaStudi krs = NewKartuRencanaStudi(
                                  nim: widget.user.id,
                                  semester: widget.user.semester,
                                  jurusan: widget.user.major,
                                  ips: widget.krs.ips,
                                  ipk: widget.krs.ipk,
                                  kreditDiambil: totalSks.toString(),
                                  bebanSksMaks: maxSks.toString(),
                                  waktuPengisian: widget.krs.waktuPengisian,
                                  tahunAkademik:
                                      widget.krsSchedule.tahunAkademik,
                                );

                                //TODO: Call UPDATE KRS
                                context.read<KrsManagementBloc>().add(
                                      UpdateKrs(
                                        idKrs: widget.krs.id,
                                        krs: krs,
                                        mataKuliahDiambil: learningSubIds,
                                      ),
                                    );

                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Ajukan Perubahan KRS',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 32, 96),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Ajukan Perubahan KRS'),
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
