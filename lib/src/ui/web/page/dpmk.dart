import 'package:academic_system/src/bloc/dosen/dosen_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/matkul_dosen.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/dpmk_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DPMKPage extends StatefulWidget {
  final User dosen;
  const DPMKPage({
    super.key,
    required this.dosen,
  });

  @override
  State<DPMKPage> createState() => _DPMKPageState();
}

class _DPMKPageState extends State<DPMKPage> {
  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetTahunAkademik());
    context.read<DosenBloc>().add(GetMatkulDosen(idDosen: widget.dosen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DPMKTitle(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'List Mata Kuliah',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ListMatkulHeader(),
            const Divider(),
            BlocBuilder<DosenBloc, DosenState>(
              builder: (context, state) {
                if (state is MatkulDosenFound) {
                  return ListMatkulDosen(
                    idDosen: widget.dosen.id,
                    matkulDosen: state.matkulDosen,
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListMatkulDosen extends StatelessWidget {
  final String idDosen;
  final List<MatkulDosen> matkulDosen;
  const ListMatkulDosen({
    Key? key,
    required this.idDosen,
    required this.matkulDosen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KrsBloc, KrsState>(
      builder: (context, state) {
        if (state is KrsScheduleLoaded) {
          final String semester = state.krsSchedule.semester;
          List<MatkulDosen> filteredMatkul = semester == "genap"
              ? matkulDosen
                  .where((matkul) => int.tryParse(matkul.kelas[1])! % 2 == 0)
                  .toList()
              : matkulDosen
                  .where((matkul) => int.tryParse(matkul.kelas[1])! % 2 == 1)
                  .toList();

          return Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: filteredMatkul.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DPMKDetailPage(
                                    idDosen: idDosen,
                                    idMataKuliah:
                                        filteredMatkul[index].idMataKuliah,
                                    krsSchedule: state.krsSchedule,
                                  );
                                },
                              ),
                            );
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
                                    filteredMatkul[index].idMataKuliah,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    filteredMatkul[index].nama,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    filteredMatkul[index].kelas,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    filteredMatkul[index].jumlahSks,
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
        return const CircularProgressIndicator();
      },
    );
  }
}

class ListMatkulHeader extends StatelessWidget {
  const ListMatkulHeader({
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
              'Kode Mata Kuliah',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Nama Mata Kuliah',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Kelas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Jumlah SKS',
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

class DPMKTitle extends StatelessWidget {
  const DPMKTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Data Peserta Mata Kuliah',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: const [
            Text(
              'T.A 2022/2023',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Semester Genap',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
