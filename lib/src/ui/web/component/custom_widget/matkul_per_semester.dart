import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';

class MatkulPerSemester extends StatefulWidget {
  const MatkulPerSemester({
    Key? key,
    required this.user,
    required this.semester,
    required this.learningSubIds,
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(17, 10, 0, 20),
          child: Text(
            'Semester ${widget.semester}',
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isSelected =
                widget.learningSubIds.contains(widget.matkul[index].id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                tileColor: (semester <= userSemester)
                    ? (widget.totalSks +
                                int.tryParse(widget.matkul[index].credit)!) <=
                            widget.maxSks
                        ? Colors.white
                        : const Color.fromARGB(255, 244, 218, 218)
                    : const Color.fromARGB(255, 244, 218, 218),
                onTap: (semester <= (userSemester + 1))
                    ? (widget.totalSks +
                                int.tryParse(widget.matkul[index].credit)!) <=
                            widget.maxSks
                        ? () {
                            setState(() {
                              if (isSelected) {
                                widget.removeLearningSubIds(
                                    widget.matkul[index].id);
                                widget.totalSksDecrement(
                                    int.tryParse(widget.matkul[index].credit)!);
                              } else {
                                widget
                                    .addLearningSubIds(widget.matkul[index].id);
                                widget.totalSksIncrement(
                                    int.tryParse(widget.matkul[index].credit)!);
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
                    : const Icon(Icons.check_box_outline_blank),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(widget.matkul[index].id),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(widget.matkul[index].name),
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(widget.matkul[index].credit),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(widget.matkul[index].grade),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(widget.matkul[index].type),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: widget.matkul.length,
        ),
      ],
    );
  }
}
