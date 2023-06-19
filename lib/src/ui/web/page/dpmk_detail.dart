import 'package:academic_system/src/bloc/dosen/dosen_bloc.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DPMKDetailPage extends StatefulWidget {
  final String idDosen;
  final String idMataKuliah;
  final KrsSchedule krsSchedule;

  const DPMKDetailPage({
    super.key,
    required this.idDosen,
    required this.idMataKuliah,
    required this.krsSchedule,
  });

  @override
  State<DPMKDetailPage> createState() => _DPMKDetailPageState();
}

class _DPMKDetailPageState extends State<DPMKDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DosenBloc>().add(
          GetNilaiMhs(
            idMataKuliah: widget.idMataKuliah,
            tahunAkademik: widget.krsSchedule.tahunAkademik,
            semester: widget.krsSchedule.semester,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: BlocBuilder<DosenBloc, DosenState>(
          builder: (context, state) {
            if (state is NilaiMhsFound) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DPMKDetailHeader(
                    idDosen: widget.idDosen,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'List Nilai Kelas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Jumlah peserta: ${state.nilaiMhsList.length}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ListNilaiHeader(),
                  const Divider(),
                  ListNilaiMahasiswa(listNilaiMhs: state.nilaiMhsList),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class DPMKDetailHeader extends StatelessWidget {
  final String idDosen;
  const DPMKDetailHeader({
    Key? key,
    required this.idDosen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<DosenBloc>().add(
                  GetMatkulDosen(idDosen: idDosen),
                );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Detail Kelas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ListNilaiMahasiswa extends StatelessWidget {
  final List<NilaiMahasiswa> listNilaiMhs;
  const ListNilaiMahasiswa({
    Key? key,
    required this.listNilaiMhs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          itemCount: listNilaiMhs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      print(listNilaiMhs[index].nama);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                        color: index % 2 == 1
                            ? const Color.fromARGB(255, 251, 251, 251)
                            : const Color.fromARGB(255, 245, 247, 251),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1,
                            color: Color.fromARGB(55, 0, 0, 0),
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].nim,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              listNilaiMhs[index].nama,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              listNilaiMhs[index].jurusan,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].kehadiran.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].tugas.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].uts.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].uas.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].nilai.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].angkaKualitas,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              listNilaiMhs[index].status,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ListNilaiHeader extends StatelessWidget {
  const ListNilaiHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Text(
              'NIM',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Nama',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Jurusan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Absen',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Tugas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'UTS',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'UAS',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Total',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Kualitas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Status',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
