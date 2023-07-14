import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/bloc/matkul_management/matkul_management_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/bloc/user/user_bloc.dart';
import 'package:academic_system/src/constant/colors.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/tahun_akademik.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/form_tambah_matkul.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/form_update_matkul.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MatkulManagementPage extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const MatkulManagementPage({
    super.key,
    required this.krsSchedule,
  });

  @override
  State<MatkulManagementPage> createState() => _MatkulManagementPageState();
}

class _MatkulManagementPageState extends State<MatkulManagementPage> {
  @override
  void initState() {
    super.initState();

    context.read<MataKuliahBloc>().add(GetMataKuliah());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: MatkulManagementBody(krsSchedule: widget.krsSchedule),
            ),
          ),
        ),
      ),
    );
  }
}

class MatkulManagementBody extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const MatkulManagementBody({
    Key? key,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  State<MatkulManagementBody> createState() => _MatkulManagementBodyState();
}

class _MatkulManagementBodyState extends State<MatkulManagementBody> {
  String tahunAkademikDropDownValue = '';

  List<DropdownMenuItem> dropDownMenuList(List<TahunAkademik> listTA) {
    return listTA.map((tahunAkademik) {
      return DropdownMenuItem(
          value: tahunAkademik.tahunAkademik,
          child: Text(
            tahunAkademik.tahunAkademik,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    context.read<TahunAkademikBloc>().add(GetListTA());
    context.read<UserBloc>().add(GetLecturer());
  }

  @override
  Widget build(BuildContext context) {
    final String semesterBerjalan =
        '${widget.krsSchedule.tahunAkademik} ${widget.krsSchedule.semester}';

    return BlocBuilder<TahunAkademikBloc, TahunAkademikState>(
      builder: (context, state) {
        if (state is TahunAkademikLoaded) {
          // List tahun akademik
          List<TahunAkademik> listTA = state.listTA;

          if (tahunAkademikDropDownValue == '') {
            tahunAkademikDropDownValue = semesterBerjalan;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text(
                        'Manajemen Mata Kuliah',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Tahun Akademik: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton(
                        value: tahunAkademikDropDownValue,
                        items: dropDownMenuList(listTA),
                        onChanged: (value) {
                          setState(() {
                            tahunAkademikDropDownValue = value;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => mainColor),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                'Form Tambah Mata Kuliah',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: 400,
                              child: FormTambahMatkul(
                                  krsSchedule: widget.krsSchedule),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Tambah Mata Kuliah'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'List Mata Kuliah T.A ${tahunAkademikDropDownValue.split(' ')[0]} Semester ${tahunAkademikDropDownValue.split(' ')[1][0].toUpperCase()}${tahunAkademikDropDownValue.split(' ')[1].substring(1)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const HeaderListMataKuliah(),
              const Divider(),
              BlocBuilder<MataKuliahBloc, MataKuliahState>(
                builder: (context, state) {
                  if (state is MataKuliahFound) {
                    List<LearningSubject> listMataKuliah =
                        state.learningSubjects;

                    String tahunAkd = tahunAkademikDropDownValue.split(' ')[0];
                    String smt = tahunAkademikDropDownValue.split(' ')[1];

                    List<LearningSubject> listMatkulTASekarang = listMataKuliah
                        .where((element) =>
                            element.tahunAkademik == tahunAkd &&
                            element.semester == smt)
                        .toList();

                    return ListMataKuliah(
                      listMataKuliah: listMatkulTASekarang,
                      krsSchedule: widget.krsSchedule,
                    );
                  }
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              )
            ],
          );
        } else if (state is TahunAkademikNotFound) {
          return Column(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const Text('List Tahun Akademik Gagal didapatkan'),
            ],
          );
        }

        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 2,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class ListMataKuliah extends StatelessWidget {
  final List<LearningSubject> listMataKuliah;
  final KrsSchedule krsSchedule;

  const ListMataKuliah({
    Key? key,
    required this.listMataKuliah,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LecturerFound) {
          List<Lecturer> listDosen = state.lecturers;

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listMataKuliah.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text(
                                  'Detail Mata Kuliah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                height: MediaQuery.of(context).size.height / 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: Text('Kode Mata Kuliah'),
                                        ),
                                        const Flexible(
                                          child: Text(': '),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                              listMataKuliah[index].idMatkul),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: Text('Nama Mata Kuliah'),
                                        ),
                                        const Flexible(
                                          child: Text(': '),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child:
                                              Text(listMataKuliah[index].name),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: Text('Dosen Pengajar'),
                                        ),
                                        const Flexible(
                                          child: Text(': '),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(listDosen
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  listMataKuliah[index]
                                                      .lecturerId)
                                              .name),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: Text('Kelas'),
                                        ),
                                        const Flexible(
                                          child: Text(': '),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child:
                                              Text(listMataKuliah[index].grade),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: Text('Jenis Mata Kuliah'),
                                        ),
                                        const Flexible(
                                          child: Text(': '),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            listMataKuliah[index]
                                                .type
                                                .toUpperCase(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: Text('Jumlah SKS'),
                                        ),
                                        const Flexible(
                                          child: Text(': '),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            listMataKuliah[index].credit,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tutup'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              'Form Update Mata Kuliah',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          content: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.5,
                                            width: 400,
                                            child: FormUpdateMatkul(
                                                matkul: listMataKuliah[index],
                                                krsSchedule: krsSchedule),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Edit'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        color: const Color.fromARGB(255, 220, 239, 255),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(listMataKuliah[index].idMatkul),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(listMataKuliah[index].name),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(listDosen
                                  .firstWhere((element) =>
                                      element.id ==
                                      listMataKuliah[index].lecturerId)
                                  .name),
                            ),
                            Expanded(
                              child: Text(listMataKuliah[index].grade),
                            ),
                            Expanded(
                              child: Text(
                                  listMataKuliah[index].type.toUpperCase()),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => mainColor),
                                ),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Konfirmasi'),
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  'Apakah anda yakin ingin menghapus mata kuliah ini dibawah ini?'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  'Kode MK: ${listMataKuliah[index].idMatkul}'),
                                              Text(
                                                  'Nama MK: ${listMataKuliah[index].name}'),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Batal'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return const CircularProgressIndicator();
                                                },
                                              );

                                              context
                                                  .read<MatkulManagementBloc>()
                                                  .add(
                                                    DeleteMataKuliah(
                                                        id: listMataKuliah[
                                                                index]
                                                            .id),
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Hapus',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Hapus'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocListener<MatkulManagementBloc, MatkulManagementState>(
                    listener: (context, state) {
                      if (state is MatkulDeleteSuccess) {
                        Navigator.pop(context);
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Informasi'),
                              content:
                                  const Text('Berhasil hapus mata kuliah.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context
                                        .read<MataKuliahBloc>()
                                        .add(GetMataKuliah());
                                  },
                                  child: const Text('Tutup'),
                                ),
                              ],
                            );
                          },
                        );
                      } else if (state is MatkulDeleteFailed) {
                        Navigator.pop(context);
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Informasi'),
                              content: const Text('Gagal hapus mata kuliah.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tutup'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const SizedBox(),
                  )
                ],
              );
            },
          );
        } else if (state is UserNotFound) {
          return const Text('Data dosen tidak ditemukan');
        }
        return Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 2,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class HeaderListMataKuliah extends StatelessWidget {
  const HeaderListMataKuliah({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: const [
          Expanded(
            child: Text(
              'Kode MK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Nama MK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Dosen Pengajar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Kelas',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Jenis',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
