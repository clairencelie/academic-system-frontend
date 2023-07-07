import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/bloc/matkul_management/matkul_management_bloc.dart';
import 'package:academic_system/src/bloc/user/user_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormUpdateMatkul extends StatefulWidget {
  final LearningSubject matkul;
  final KrsSchedule krsSchedule;

  const FormUpdateMatkul({
    super.key,
    required this.matkul,
    required this.krsSchedule,
  });

  @override
  State<FormUpdateMatkul> createState() => _FormUpdateMatkulState();
}

class _FormUpdateMatkulState extends State<FormUpdateMatkul> {
  final TextEditingController idDosen = TextEditingController();
  final TextEditingController kelas = TextEditingController();

  @override
  void initState() {
    super.initState();
    idDosen.text = widget.matkul.lecturerId;
    kelas.text = widget.matkul.grade;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Kode Matkul: ${widget.matkul.idMatkul}'),
        const SizedBox(
          height: 10,
        ),
        Text('Nama Matkul: ${widget.matkul.name}'),
        const SizedBox(
          height: 10,
        ),
        const Text('Dosen Pengajar:'),
        DosenChoice(dosenId: idDosen),
        const SizedBox(
          height: 10,
        ),
        const Text('Kelas:'),
        GradeChoice(kelas: kelas),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Batal'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 100,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 53, 230, 112)),
                ),
                onPressed: () {
                  LearningSubject matkulUpdate = LearningSubject(
                    id: widget.matkul.id,
                    idMatkul: widget.matkul.idMatkul,
                    lecturerId: idDosen.text,
                    name: widget.matkul.name,
                    credit: widget.matkul.credit,
                    grade: kelas.text,
                    type: widget.matkul.type,
                    tahunAkademik: widget.matkul.tahunAkademik,
                    semester: widget.matkul.semester,
                  );

                  context
                      .read<MatkulManagementBloc>()
                      .add(UpdateMataKuliah(matkulBaru: matkulUpdate));
                },
                child: const Text('Update'),
              ),
            ),
            BlocListener<MatkulManagementBloc, MatkulManagementState>(
              listener: (context, state) {
                if (state is MatkulUpdateSuccess) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Informasi'),
                        content: const Text('Mata kuliah berhasil diupdate'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              context
                                  .read<MataKuliahBloc>()
                                  .add(GetMataKuliah());
                            },
                            child: const Text('Tutup'),
                          )
                        ],
                      );
                    },
                  );
                } else if (state is MatkulUpdateFailed) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Informasi'),
                        content: const Text('Mata kuliah gagal diupdate'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Tutup'))
                        ],
                      );
                    },
                  );
                }
              },
              child: const SizedBox(),
            )
          ],
        ),
      ],
    );
  }
}

class DosenChoice extends StatefulWidget {
  final TextEditingController dosenId;
  const DosenChoice({
    super.key,
    required this.dosenId,
  });

  @override
  State<DosenChoice> createState() => _DosenChoiceState();
}

class _DosenChoiceState extends State<DosenChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(List<Lecturer> lecturers) {
    return lecturers.map((lecturer) {
      return DropdownMenuItem(
          value: lecturer.id.toString(),
          child: Text(
            lecturer.name,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LecturerFound) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return 'Field pilihan dosen belum terisi!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Pilih dosen...',
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
              menuMaxHeight: 200,
              value: (widget.dosenId.text == '') ? value : widget.dosenId.text,
              isExpanded: true,
              items: dropDownMenuList(state.lecturers),
              onChanged: (value) {
                setState(() {
                  widget.dosenId.text = value;
                });
              },
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

class GradeChoice extends StatefulWidget {
  final TextEditingController kelas;
  const GradeChoice({
    super.key,
    required this.kelas,
  });

  @override
  State<GradeChoice> createState() => _GradeChoiceState();
}

class _GradeChoiceState extends State<GradeChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(List<String> grades) {
    return grades.map((grade) {
      return DropdownMenuItem(
          value: grade,
          child: Text(
            grade,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Field pilihan kelas belum terisi!';
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: 'Pilih kelas...',
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
        menuMaxHeight: 200,
        value: (widget.kelas.text == '') ? value : widget.kelas.text,
        isExpanded: true,
        items: dropDownMenuList(
          [
            '01MAS',
            '01MAT',
            '01MATS',
            '02MAS',
            '02MAT',
            '02MATS',
            '03MAS',
            '03MAT',
            '03MATS',
            '04MAS',
            '04MAT',
            '04MATS',
            '05MAS',
            '05MAT',
            '05MATS',
            '06MAS',
            '06MAT',
            '06MATS',
            '07MAS',
            '07MAT',
            '07MATS',
            '08MAS',
            '08MAT',
            '08MATS',
          ],
        ),
        onChanged: (value) {
          setState(() {
            widget.kelas.text = value;
          });
        },
      ),
    );
  }
}
