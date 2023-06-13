import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/matkul_per_semester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMatkulKRS extends StatefulWidget {
  const ListMatkulKRS({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Student user;

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
    context.read<MataKuliahBloc>().add(GetKRSMatkul(student: widget.user));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MataKuliahBloc, MataKuliahState>(
      builder: (context, state) {
        if (state is MataKuliahFound) {
          final List<LearningSubject> userLearningSubjects =
              state.learningSubjects;

          List<int> studentGrades =
              ((int.tryParse(widget.user.semester)! + 1) % 2 == 0)
                  ? [2, 4, 6, 8]
                  : [1, 3, 5, 7];

          List<List<LearningSubject>> separatedCourses = List.generate(
            studentGrades.length,
            (gradeIndex) => userLearningSubjects
                .where((matkul) =>
                    matkul.grade.contains('${studentGrades[gradeIndex]}'))
                .toList(),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: Buat listview builder untuk setiap semester (ganjil 1,3,5,7 / genap 2,4,6,8)
              Column(
                children: studentGrades
                    .map(
                      (value) => MatkulPerSemester(
                        semester: value.toString(),
                        learningSubIds: learningSubIds,
                        matkul: separatedCourses[studentGrades.indexOf(value)],
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
              const Text('Maks SKS yang bisa diambil: 20'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Ajukan KRS'),
              ),
            ],
          );
        }
        return Container(
          width: 50,
          height: 50,
          color: Colors.red,
        );
      },
    );
  }
}
