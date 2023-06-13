import 'package:academic_system/src/model/learning_subject.dart';
import 'package:flutter/material.dart';

class MatkulPerSemester extends StatefulWidget {
  const MatkulPerSemester({
    Key? key,
    required this.semester,
    required this.learningSubIds,
    required this.matkul,
    required this.totalSks,
    required this.totalSksIncrement,
    required this.totalSksDecrement,
    required this.addLearningSubIds,
    required this.removeLearningSubIds,
  }) : super(key: key);

  final String semester;
  final List<String> learningSubIds;
  final List<LearningSubject> matkul;
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
    return Column(
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
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      widget.removeLearningSubIds(widget.matkul[index].id);
                      widget.totalSksDecrement(
                          int.tryParse(widget.matkul[index].credit)!);
                    } else {
                      widget.addLearningSubIds(widget.matkul[index].id);
                      widget.totalSksIncrement(
                          int.tryParse(widget.matkul[index].credit)!);
                    }
                  });
                },
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
