import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';

class MobileMatkulPerSemester extends StatefulWidget {
  const MobileMatkulPerSemester({
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
  State<MobileMatkulPerSemester> createState() =>
      _MobileMatkulPerSemesterState();
}

class _MobileMatkulPerSemesterState extends State<MobileMatkulPerSemester> {
  @override
  Widget build(BuildContext context) {
    int userSemester = int.tryParse(widget.user.semester)!;
    int semester = int.tryParse(widget.semester)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isSelected =
                widget.learningSubIds.contains(widget.matkul[index].id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (semester <= userSemester)
                      ? widget.matkulLulus.contains(widget.matkul[index].id)
                          ? const Color.fromARGB(255, 201, 247, 225)
                          : (widget.totalSks +
                                      int.tryParse(
                                          widget.matkul[index].credit)!) <=
                                  widget.maxSks
                              ? Colors.white
                              : widget.learningSubIds
                                      .contains(widget.matkul[index].id)
                                  ? Colors.white
                                  : const Color.fromARGB(255, 244, 218, 218)
                      : const Color.fromARGB(255, 230, 230, 230),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromARGB(55, 0, 0, 0),
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: isSelected
                      ? const Border(
                          bottom: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          left: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          top: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          right: BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: ListTile(
                  // tileColor: (semester <= userSemester)
                  //     ? widget.matkulLulus.contains(widget.matkul[index].id)
                  //         ? const Color.fromARGB(255, 201, 247, 225)
                  //         : (widget.totalSks +
                  //                     int.tryParse(
                  //                         widget.matkul[index].credit)!) <=
                  //                 widget.maxSks
                  //             ? Colors.white
                  //             : const Color.fromARGB(255, 244, 218, 218)
                  //     : const Color.fromARGB(255, 230, 230, 230),
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
                  // trailing:
                  title: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.matkul[index].id,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            isSelected
                                ? const Icon(Icons.check_box_rounded)
                                : (widget.matkulLulus
                                        .contains(widget.matkul[index].id))
                                    ? const Text(
                                        'Lulus',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : (semester <= userSemester)
                                        ? const Icon(
                                            Icons.check_box_outline_blank)
                                        : const SizedBox(),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.matkul[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.matkul[index].credit} SKS',
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.matkul[index].grade,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.matkul[index].type[0].toUpperCase()}${widget.matkul[index].type.substring(1)}',
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
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
