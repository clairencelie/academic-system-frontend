import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/new_kartu_rencana_studi.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs_header.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/matkul_per_semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListMatkulKRS extends StatefulWidget {
  const ListMatkulKRS({
    Key? key,
    required this.user,
    required this.krsSchedule,
    required this.tranksripLengkap,
  }) : super(key: key);

  final Student user;
  final KrsSchedule krsSchedule;
  // data transkrip untuk mendapatkan data maks beban sks
  final TranksripLengkap tranksripLengkap;

  @override
  State<ListMatkulKRS> createState() => _ListMatkulKRSState();
}

class _ListMatkulKRSState extends State<ListMatkulKRS> {
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
  }

  @override
  Widget build(BuildContext context) {
    // int maxSks = int.tryParse(widget.user.semester)! <= 4 ? 20 : 24;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengisian KRS Semester ${widget.krsSchedule.semester} T.A ${widget.krsSchedule.tahunAkademik}',
                    style: const TextStyle(
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
              Text('Total SKS yang diambil: $totalSks'),
              Text('Maks SKS yang bisa diambil: $maxSks'),
              BlocListener<KrsManagementBloc, KrsManagementState>(
                listener: (context, state) {
                  if (state is CreateKrsSuccess) {
                    Navigator.of(context, rootNavigator: true).pop();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return InfoDialog(
                          title: 'Informasi',
                          body: 'Kartu rencana studi anda berhasil diajukan.',
                          onClose: () {
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
                  } else if (state is CreateKrsFailed) {
                    Navigator.of(context, rootNavigator: true).pop();

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return InfoDialog(
                          title: 'Informasi',
                          body: 'Kartu rencana studi anda gagal diajukan.',
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
                            'Pastikan pilihan mata kuliah anda sudah sesuai.\nSetelah KRS diajukan, maka KRS tidak dapat diubah.',
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
                                // KartuHasilStudi khsSmtSebelumnya = widget
                                //     .tranksripLengkap.khs
                                //     .where((element) =>
                                //         element.semester ==
                                //         (int.tryParse(widget.user.semester)! -
                                //                 1)
                                //             .toString())
                                //     .toList()[0];

                                String ips = widget.tranksripLengkap.khs.isEmpty
                                    ? '0'
                                    : widget.tranksripLengkap.khs
                                        .where((element) =>
                                            element.semester ==
                                            (int.tryParse(
                                                        widget.user.semester)! -
                                                    1)
                                                .toString())
                                        .toList()[0]
                                        .ips;

                                // String bebansSksMaks = widget
                                //     .tranksripLengkap.khs
                                //     .where((element) =>
                                //         element.semester ==
                                //         (int.tryParse(widget.user.semester)! -
                                //                 1)
                                //             .toString())
                                //     .toList()[0]
                                //     .maskSks;

                                String date = DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now());

                                NewKartuRencanaStudi krs = NewKartuRencanaStudi(
                                  nim: widget.user.id,
                                  semester: widget.user.semester,
                                  jurusan: widget.user.major,
                                  ips: ips,
                                  ipk: widget
                                      .tranksripLengkap.transkripNilai.ipk,
                                  kreditDiambil: totalSks.toString(),
                                  bebanSksMaks: maxSksFromTranskrip,
                                  waktuPengisian: date,
                                  tahunAkademik:
                                      widget.krsSchedule.tahunAkademik,
                                );

                                context.read<KrsManagementBloc>().add(
                                      CreateKrs(
                                        krs: krs,
                                        mataKuliahDiambil: learningSubIds,
                                      ),
                                    );

                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Ajukan KRS',
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
                  child: const Text('Ajukan KRS'),
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
