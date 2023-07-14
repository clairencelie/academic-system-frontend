import 'package:academic_system/src/bloc/dosen/dosen_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/model/matkul_dosen.dart';
import 'package:academic_system/src/model/tahun_akademik.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/dosen/dpmk_detail.dart';
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
    context.read<KrsBloc>().add(GetTahunAkademik());
    context.read<TahunAkademikBloc>().add(GetListTA());
    context.read<DosenBloc>().add(GetMatkulDosen(idDosen: widget.dosen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: BlocBuilder<KrsBloc, KrsState>(
          builder: (context, state) {
            if (state is KrsScheduleLoaded) {
              // semester berjalan
              final String semesterBerjalan =
                  '${state.krsSchedule.tahunAkademik} ${state.krsSchedule.semester}';

              return BlocBuilder<TahunAkademikBloc, TahunAkademikState>(
                builder: (context, state) {
                  if (state is TahunAkademikLoaded) {
                    // List tahun akademik
                    List<TahunAkademik> listTA = state.listTA;

                    return BlocBuilder<DosenBloc, DosenState>(
                      builder: (context, state) {
                        if (state is MatkulDosenFound) {
                          if (tahunAkademikDropDownValue == '') {
                            tahunAkademikDropDownValue = semesterBerjalan;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Data Peserta Mata Kuliah',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Tahun akademik: ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      DropdownButton(
                                        value: tahunAkademikDropDownValue,
                                        items: dropDownMenuList(listTA),
                                        onChanged: (value) {
                                          setState(() {
                                            tahunAkademikDropDownValue = value;
                                          });
                                          context.read<DosenBloc>().add(
                                                GetMatkulDosen(
                                                    idDosen: widget.dosen.id),
                                              );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'List Mata Kuliah T.A ${tahunAkademikDropDownValue.split(' ')[0]} Semester ${tahunAkademikDropDownValue.split(' ')[1][0].toUpperCase()}${tahunAkademikDropDownValue.split(' ')[1].substring(1)}',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const ListMatkulHeader(),
                              const Divider(),
                              ListMatkulDosen(
                                idDosen: widget.dosen.id,
                                matkulDosen: state.matkulDosen,
                                tahunAkademik: tahunAkademikDropDownValue,
                              ),
                            ],
                          );
                        }
                        return Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );
                  }
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              );
            }
            return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListMatkulDosen extends StatelessWidget {
  final String idDosen;
  final List<MatkulDosen> matkulDosen;
  final String tahunAkademik;
  const ListMatkulDosen({
    Key? key,
    required this.idDosen,
    required this.matkulDosen,
    required this.tahunAkademik,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String tahunAkd = tahunAkademik.split(" ").toList()[0];
    final String semester = tahunAkademik.split(" ").toList()[1];
    List<MatkulDosen> filteredMatkul = semester == "genap"
        ? matkulDosen
            .where((matkul) => int.tryParse(matkul.kelas[1])! % 2 == 0)
            .toList()
        : matkulDosen
            .where((matkul) => int.tryParse(matkul.kelas[1])! % 2 == 1)
            .toList();

    List<MatkulDosen> filteredMatkulTahunAkademik = filteredMatkul
        .where((element) => element.tahunAkademik == tahunAkd)
        .toList();

    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          itemCount: filteredMatkulTahunAkademik.length,
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
                              idMataKuliah: filteredMatkulTahunAkademik[index]
                                  .idMataKuliah,
                              namaMataKuliah:
                                  filteredMatkulTahunAkademik[index].nama,
                              tahunAkademik: tahunAkademik,
                              kelas: filteredMatkulTahunAkademik[index].kelas,
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
                              filteredMatkulTahunAkademik[index]
                                  .idMataKuliahMaster,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              filteredMatkulTahunAkademik[index].nama,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              filteredMatkulTahunAkademik[index].kelas,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              filteredMatkulTahunAkademik[index].jumlahSks,
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
