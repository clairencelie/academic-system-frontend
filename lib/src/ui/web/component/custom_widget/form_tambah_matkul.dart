import 'package:academic_system/src/bloc/master_mata_kuliah/master_mata_kuliah_bloc.dart';
import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/bloc/matkul_management/matkul_management_bloc.dart';
import 'package:academic_system/src/bloc/user/user_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/master_matkul.dart';
import 'package:academic_system/src/model/matkul_baru.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormTambahMatkul extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const FormTambahMatkul({
    super.key,
    required this.krsSchedule,
  });

  @override
  State<FormTambahMatkul> createState() => _FormTambahMatkulState();
}

class _FormTambahMatkulState extends State<FormTambahMatkul> {
  TextEditingController matkul = TextEditingController();
  TextEditingController namaMatkul = TextEditingController();
  TextEditingController jenisMatkul = TextEditingController();
  TextEditingController sksMatkul = TextEditingController();
  TextEditingController idDosen = TextEditingController();
  TextEditingController kelas = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<MasterMataKuliahBloc>().add(GetMataKuliahMaster());

    context.read<UserBloc>().add(GetLecturer());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterMataKuliahBloc, MasterMataKuliahState>(
      builder: (context, state) {
        if (state is MasterMataKuliahFound) {
          List<MasterMatkul> listMasterMatkul = state.listMasterMatkul;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Mata Kuliah',
                style: TextStyle(fontSize: 14),
              ),
              MatkulChoice(matkul: matkul),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Dosen Pengajar',
                style: TextStyle(fontSize: 14),
              ),
              DosenChoice(dosenId: idDosen),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Kelas',
                style: TextStyle(fontSize: 14),
              ),
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
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red),
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
                            (states) =>
                                const Color.fromARGB(255, 53, 230, 112)),
                      ),
                      onPressed: () {
                        String namaMatkul = listMasterMatkul
                            .where((element) =>
                                element.idMataKuliahMaster == matkul.text)
                            .first
                            .nama;

                        String jenisMatkul = listMasterMatkul
                            .where((element) =>
                                element.idMataKuliahMaster == matkul.text)
                            .first
                            .jenis;

                        int jumlahSks = listMasterMatkul
                            .where((element) =>
                                element.idMataKuliahMaster == matkul.text)
                            .first
                            .jumlahSKS;

                        MatkulBaru matkulBaru = MatkulBaru(
                          idMataKuliahMaster: matkul.text,
                          idDosen: idDosen.text,
                          namaMataKuliah: namaMatkul,
                          jumlahSks: jumlahSks.toString(),
                          kelas: kelas.text,
                          jenis: jenisMatkul,
                          tahunAkademik: widget.krsSchedule.tahunAkademik,
                          semester: widget.krsSchedule.semester,
                        );

                        context
                            .read<MatkulManagementBloc>()
                            .add(TambahMataKuliah(matkulBaru: matkulBaru));
                      },
                      child: const Text('Tambah'),
                    ),
                  ),
                  BlocListener<MatkulManagementBloc, MatkulManagementState>(
                    listener: (context, state) {
                      if (state is CreateMatkulSuccess) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Informasi'),
                              content:
                                  const Text('Mata kuliah berhasil ditambah'),
                              actions: [
                                TextButton(
                                  onPressed: () {
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
                      } else if (state is CreateMatkulFailed) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Informasi'),
                              content: const Text('Mata kuliah gagal ditambah'),
                              actions: [
                                TextButton(
                                    onPressed: () {
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
                    child: Container(),
                  )
                ],
              ),
            ],
          );
        } else if (state is MasterMataKuliahNotFound) {
          return const Text('Mata kuliah master gagal didapatkan.');
        }
        return Container(
          alignment: Alignment.center,
          height: 100,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
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

class MatkulChoice extends StatefulWidget {
  final TextEditingController matkul;
  const MatkulChoice({
    super.key,
    required this.matkul,
  });

  @override
  State<MatkulChoice> createState() => _MatkulChoiceState();
}

class _MatkulChoiceState extends State<MatkulChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(List<MasterMatkul> listMasterMatkul) {
    return listMasterMatkul.map((matkul) {
      return DropdownMenuItem(
          value: matkul.idMataKuliahMaster,
          child: Row(
            children: [
              Text(matkul.idMataKuliahMaster),
              const SizedBox(
                width: 20,
              ),
              Text(
                matkul.nama,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasterMataKuliahBloc, MasterMataKuliahState>(
      builder: (context, state) {
        if (state is MasterMataKuliahFound) {
          List<MasterMatkul> listMasterMatkul = state.listMasterMatkul;

          return Padding(
            padding: const EdgeInsets.only(top: 5),
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
              menuMaxHeight: 200,
              value: (widget.matkul.text == '') ? value : widget.matkul.text,
              isExpanded: true,
              items: dropDownMenuList(listMasterMatkul),
              onChanged: (value) {
                setState(() {
                  widget.matkul.text = value;
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
