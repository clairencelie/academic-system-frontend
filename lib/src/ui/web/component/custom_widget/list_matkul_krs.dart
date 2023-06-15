import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs_header.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/matkul_per_semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    String maxSksFromTranskrip = widget.tranksripLengkap.khs
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
              const ListMatkulKrsHeader(),
              const Divider(),
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
              ElevatedButton(
                onPressed: () {},
                child: const Text('Ajukan KRS'),
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
