import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MataKuliahChoice extends StatefulWidget {
  final Function callback;
  final KrsSchedule krsSchedule;
  final TextEditingController idMK;
  final TextEditingController idDosen;

  const MataKuliahChoice({
    super.key,
    required this.callback,
    required this.krsSchedule,
    required this.idMK,
    required this.idDosen,
  });

  @override
  State<MataKuliahChoice> createState() => _MataKuliahChoiceState();
}

class _MataKuliahChoiceState extends State<MataKuliahChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(
      List<LearningSubject> learningSubjects) {
    return learningSubjects.map((learningSubject) {
      return DropdownMenuItem(
          value: learningSubject.id.toString(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    learningSubject.idMatkul,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    learningSubject.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(learningSubject.grade),
              )
            ],
          ));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<MataKuliahBloc>().add(GetMataKuliah());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MataKuliahBloc, MataKuliahState>(
      builder: (context, state) {
        if (state is MataKuliahFound) {
          List<LearningSubject> matkulTahunAkdSkr = state.learningSubjects
              .where((element) =>
                  element.tahunAkademik == widget.krsSchedule.tahunAkademik &&
                  element.semester == widget.krsSchedule.semester)
              .toList();

          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Field pilihan mata kuliah belum terisi!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Pilih mata kuliah...',
                  errorStyle: TextStyle(
                    height: 0.7,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(55, 112, 112, 112),
                    ),
                  ),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(55, 112, 112, 112),
                    ),
                  ),
                ),
                menuMaxHeight: MediaQuery.of(context).size.height / 2,
                value: (widget.idMK.text == '') ? value : widget.idMK.text,
                isExpanded: true,
                items: dropDownMenuList(matkulTahunAkdSkr),
                onChanged: (value) {
                  setState(() {
                    widget.idMK.text = value;
                    LearningSubject matkul = matkulTahunAkdSkr
                        .where((element) => element.id == value)
                        .first;
                    widget.callback(matkul.lecturerId);
                  });
                },
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
