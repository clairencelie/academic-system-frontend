import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/model/new_kartu_rencana_studi.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/penasehat_akademik.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/matkul_per_semester.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MobileListMatkulKRS extends StatefulWidget {
  const MobileListMatkulKRS({
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
  State<MobileListMatkulKRS> createState() => _MobileListMatkulKRSState();
}

class _MobileListMatkulKRSState extends State<MobileListMatkulKRS> {
  String? penasehatAkademik;

  List<PenasehatAkademik> listPA = [
    PenasehatAkademik(
      id: '151190003',
      name: 'Sugesti, S.Si., M.Kom.',
    ),
    PenasehatAkademik(
      id: '151190006',
      name: 'Hari Santoso, S.Kom., M.Kom.',
    ),
    PenasehatAkademik(
      id: '151190010',
      name: 'Hans Saputra, S.Kom., MMSI.',
    ),
    PenasehatAkademik(
      id: '151190012',
      name: 'Desy Mora Daulay, S.Kom., M.Kom.',
    ),
    PenasehatAkademik(
      id: '151190013',
      name: 'Syarah, S.Kom., M.Kom.',
    ),
    PenasehatAkademik(
      id: '151190009',
      name: 'Sobiyanto, S.E., S.Kom., M.Kom., MTA.',
    ),
    PenasehatAkademik(
      id: '151190018',
      name: 'Rama Putra, S.Kom., M.Kom.',
    ),
  ];

  List<DropdownMenuItem> dropDownMenuList(List<PenasehatAkademik> listPA) {
    return listPA.map((pa) {
      return DropdownMenuItem(
          value: pa.id,
          child: Text(
            pa.name,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList();
  }

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
    List<String> idMatkulLulus = widget.tranksripLengkap.matkulLulus;

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
                    matkul.grade.contains('${semesterList[semesterIndex]}') &&
                    matkul.tahunAkademik == widget.krsSchedule.tahunAkademik &&
                    matkul.semester == widget.krsSchedule.semester)
                .toList(),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Form Pengisian KRS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Penasehat Akademik:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              DropdownButton(
                isExpanded: true,
                value: penasehatAkademik,
                hint: const Text('Pilih Penasehat Akademik...'),
                items: dropDownMenuList(listPA),
                onChanged: (value) {
                  setState(() {
                    penasehatAkademik = value;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: semesterList
                    .map(
                      (value) => MobileMatkulPerSemester(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Max SKS',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$maxSks',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: const Color.fromARGB(255, 199, 199, 199),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      const Text(
                        'SKS Diambil',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$totalSks',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: learningSubIds.isEmpty
                          ? MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(255, 214, 214, 214),
                            )
                          : penasehatAkademik == null
                              ? MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 214, 214, 214),
                                )
                              : MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 11, 39, 118),
                                ),
                    ),
                    onPressed: learningSubIds.isEmpty
                        ? null
                        : penasehatAkademik == null
                            ? null
                            : () {
                                maxSks > totalSks
                                    ? showDialogPeringatanPengajuanKRS(
                                        context, maxSks.toString())
                                    : showDialogKonfirmasiPengajuanKRS(
                                        context, maxSks.toString());
                              },
                    child: const Text(
                      'Ajukan KRS',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<dynamic> showDialogKonfirmasiPengajuanKRS(
      BuildContext context, String maxSks) {
    return showDialog(
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
          content: const SizedBox(
            width: 400,
            child: Text(
              'Pastikan pilihan mata kuliah anda sudah sesuai.\n\nJika anda ingin mengubah KRS setelah KRS diajukan, dapat dilakukan di dalam menu histori pengisian KRS (Sebelum KRS dikunci).',
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 0, 32, 96),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
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
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 0, 32, 96),
                ),
              ),
              onPressed: () {
                String ips = widget.tranksripLengkap.khs.isEmpty
                    ? '0'
                    : widget.tranksripLengkap.khs
                        .where((element) =>
                            element.semester ==
                            (int.tryParse(widget.user.semester)! - 1)
                                .toString())
                        .toList()[0]
                        .ips;

                String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

                NewKartuRencanaStudi krs = NewKartuRencanaStudi(
                  nim: widget.user.id,
                  idDosen: penasehatAkademik!,
                  semester: widget.user.semester,
                  jurusan: widget.user.major,
                  ips: ips,
                  ipk: widget.tranksripLengkap.transkripNilai.ipk,
                  kreditDiambil: totalSks.toString(),
                  bebanSksMaks: maxSks,
                  waktuPengisian: date,
                  tahunAkademik: widget.krsSchedule.tahunAkademik,
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
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> showDialogPeringatanPengajuanKRS(
      BuildContext context, String maxSksFromTranskrip) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Peringatan',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Anda masih memiliki sisa sks, apakah anda yakin tetap ingin mengajukan KRS ini dengan sks yang masih tersisa?\n\nJika ya, maka pastikan pilihan mata kuliah anda sudah sesuai.\n\nJika anda ingin mengubah KRS setelah KRS diajukan, dapat dilakukan di dalam menu histori pengisian KRS (Sebelum KRS dikunci).',
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 0, 32, 96),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
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
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 0, 32, 96),
                ),
              ),
              onPressed: () {
                String ips = widget.tranksripLengkap.khs.isEmpty
                    ? '0'
                    : widget.tranksripLengkap.khs
                        .where((element) =>
                            element.semester ==
                            (int.tryParse(widget.user.semester)! - 1)
                                .toString())
                        .toList()[0]
                        .ips;

                String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

                NewKartuRencanaStudi krs = NewKartuRencanaStudi(
                  nim: widget.user.id,
                  idDosen: penasehatAkademik!,
                  semester: widget.user.semester,
                  jurusan: widget.user.major,
                  ips: ips,
                  ipk: widget.tranksripLengkap.transkripNilai.ipk,
                  kreditDiambil: totalSks.toString(),
                  bebanSksMaks: maxSksFromTranskrip,
                  waktuPengisian: date,
                  tahunAkademik: widget.krsSchedule.tahunAkademik,
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
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
