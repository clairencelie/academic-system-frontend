import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs_header.dart';
import 'package:flutter/material.dart';

class MatkulPerSemester extends StatefulWidget {
  const MatkulPerSemester({
    Key? key,
    required this.user,
    required this.semester,
    required this.learningSubIds,
    required this.matkulLulus,
    required this.matkul,
    required this.maxSks,
    required this.totalSks,
    required this.totalSksIncrement,
    required this.totalSksDecrement,
    required this.addLearningSubIds,
    required this.removeLearningSubIds,
  }) : super(key: key);

  final Student user;
  final String semester;
  final List<String> learningSubIds;
  final List<String> matkulLulus;
  final List<LearningSubject> matkul;
  final int maxSks;
  final int totalSks;
  final Function(int credit) totalSksIncrement;
  final Function(int credit) totalSksDecrement;
  final Function(String id) addLearningSubIds;
  final Function(String id) removeLearningSubIds;

  @override
  State<MatkulPerSemester> createState() => _MatkulPerSemesterState();
}

class _MatkulPerSemesterState extends State<MatkulPerSemester> {
  @override
  Widget build(BuildContext context) {
    int userSemester = int.tryParse(widget.user.semester)!;
    int semester = int.tryParse(widget.semester)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 10, 0, 10),
          child: Text(
            'Semester ${widget.semester}',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        const ListMatkulKrsHeader(),
        const SizedBox(
          height: 10,
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isSelected =
                widget.learningSubIds.contains(widget.matkul[index].id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                tileColor: (semester <= userSemester)
                    ? widget.matkulLulus.contains(widget.matkul[index].id)
                        ? const Color.fromARGB(255, 201, 247, 225)
                        : (widget.totalSks +
                                    int.tryParse(
                                        widget.matkul[index].credit)!) <=
                                widget.maxSks
                            ? Colors.white
                            : const Color.fromARGB(255, 244, 218, 218)
                    : const Color.fromARGB(255, 244, 218, 218),
                onTap: (semester <= (userSemester + 1))
                    ? (widget.matkulLulus.contains(widget.matkul[index].id))
                        ? null
                        : (widget.totalSks +
                                    int.tryParse(
                                        widget.matkul[index].credit)!) <=
                                widget.maxSks
                            ? () {
                                setState(() {
                                  if (isSelected) {
                                    widget.removeLearningSubIds(
                                        widget.matkul[index].id);
                                    widget.totalSksDecrement(int.tryParse(
                                        widget.matkul[index].credit)!);
                                  } else {
                                    widget.addLearningSubIds(
                                        widget.matkul[index].id);
                                    widget.totalSksIncrement(int.tryParse(
                                        widget.matkul[index].credit)!);
                                  }
                                });
                              }
                            : isSelected
                                ? () {
                                    setState(() {
                                      if (isSelected) {
                                        widget.removeLearningSubIds(
                                            widget.matkul[index].id);
                                        widget.totalSksDecrement(int.tryParse(
                                            widget.matkul[index].credit)!);
                                      } else {
                                        widget.addLearningSubIds(
                                            widget.matkul[index].id);
                                        widget.totalSksIncrement(int.tryParse(
                                            widget.matkul[index].credit)!);
                                      }
                                    });
                                  }
                                : null
                    : null,
                selected: isSelected,
                trailing: isSelected
                    ? const Icon(Icons.check_box_rounded)
                    : (widget.matkulLulus.contains(widget.matkul[index].id))
                        ? const Icon(Icons.check_circle)
                        : userSemester < semester
                            ? const SizedBox()
                            : const Icon(Icons.check_box_outline_blank),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      // width: 150,
                      child: Text(widget.matkul[index].idMatkul),
                    ),
                    Expanded(
                      flex: 2,
                      // width: 300,
                      child: Text(widget.matkul[index].name),
                    ),
                    // const SizedBox(width: ,),
                    Expanded(
                      // width: 100,
                      child: Text(widget.matkul[index].credit),
                    ),
                    Expanded(
                      // width: 100,
                      child: Text(widget.matkul[index].grade),
                    ),
                    Expanded(
                      // width: 120,
                      child: Text(widget.matkul[index].type),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: widget.matkul.length,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
