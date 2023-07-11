import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/tahun_akademik.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/dosen/detail_krs_mhs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PenasehatAkademikPage extends StatefulWidget {
  final User dosen;

  const PenasehatAkademikPage({
    super.key,
    required this.dosen,
  });

  @override
  State<PenasehatAkademikPage> createState() => _PenasehatAkademikPageState();
}

class _PenasehatAkademikPageState extends State<PenasehatAkademikPage> {
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
    context.read<KrsBloc>().add(GetAllKrs());
    context.read<ScheduleKrsBloc>().add(GetScheduleKrs());
    context.read<TahunAkademikBloc>().add(GetListTA());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: BlocBuilder<ScheduleKrsBloc, ScheduleKrsState>(
                builder: (context, state) {
                  if (state is ScheduleKrsLoaded) {
                    final KrsSchedule jadwalKrs = state.krsSchedule;

                    final String semesterBerjalan =
                        '${jadwalKrs.tahunAkademik} ${jadwalKrs.semester}';

                    return BlocBuilder<TahunAkademikBloc, TahunAkademikState>(
                      builder: (context, state) {
                        if (state is TahunAkademikLoaded) {
                          // List tahun akademik
                          List<TahunAkademik> listTA = state.listTA;

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
                                    'Penasehat Akademik',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Tahun Akademik: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
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
                              Text(
                                'List KRS Mahasiswa T.A ${tahunAkademikDropDownValue.split(' ')[0]} Semester ${tahunAkademikDropDownValue.split(' ')[1][0].toUpperCase()}${tahunAkademikDropDownValue.split(' ')[1].substring(1)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const KrsListHeader(),
                              const Divider(),
                              BlocBuilder<KrsBloc, KrsState>(
                                builder: (context, state) {
                                  if (state is KrsFound) {
                                    return KrsManagementList(
                                      krsSchedule: jadwalKrs,
                                      dosen: widget.dosen as Lecturer,
                                      krsLengkap: state.krsLengkap,
                                      tahunAkademik: tahunAkademikDropDownValue,
                                    );
                                  }
                                  return Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: const CircularProgressIndicator(),
                                  );
                                },
                              ),
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
                              const Text(
                                  'List Tahun Akademik Gagal didapatkan'),
                            ],
                          );
                        }
                        return Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height / 2,
                          child: const CircularProgressIndicator(),
                        );
                      },
                    );
                  } else if (state is ScheduleKrsFailed) {
                    return const Text('Jadwal KRS Gagal didapatkan');
                  }

                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 2,
                    child: const CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KrsManagementList extends StatelessWidget {
  final Lecturer dosen;
  final List<KartuRencanaStudiLengkap> krsLengkap;
  final String tahunAkademik;
  final KrsSchedule krsSchedule;

  const KrsManagementList({
    Key? key,
    required this.krsLengkap,
    required this.tahunAkademik,
    required this.dosen,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String tahunAkdm = tahunAkademik.split(" ").toList()[0];
    final String semester = tahunAkademik.split(" ").toList()[1];

    final List<KartuRencanaStudiLengkap> filterSemesterKrsLengkap =
        semester == 'genap'
            ? krsLengkap
                .where((krs) => int.tryParse(krs.semester)! % 2 == 0)
                .toList()
            : krsLengkap
                .where((krs) => int.tryParse(krs.semester)! % 2 == 1)
                .toList();

    final List<KartuRencanaStudiLengkap> filterTahunAkademikKrs =
        filterSemesterKrsLengkap
            .where((krs) => krs.tahunAkademik == tahunAkdm)
            .toList();

    final List<KartuRencanaStudiLengkap> listKrsBimbinganPenasehatAkademik =
        filterTahunAkademikKrs
            .where((element) => element.idDosen == dosen.id)
            .toList();

    return listKrsBimbinganPenasehatAkademik.isEmpty
        ? const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                'Belum ada KRS yang diajukan oleh mahasiswa.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
        : ListView.builder(
            itemCount: listKrsBimbinganPenasehatAkademik.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailKrsMhs(
                            krs: listKrsBimbinganPenasehatAkademik[index],
                            krsSchedule: krsSchedule,
                          );
                        },
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
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
                                listKrsBimbinganPenasehatAkademik[index].nim,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                listKrsBimbinganPenasehatAkademik[index].nama,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                listKrsBimbinganPenasehatAkademik[index]
                                    .bebanSksMaks,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                listKrsBimbinganPenasehatAkademik[index]
                                    .kreditDiambil,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                int.tryParse(listKrsBimbinganPenasehatAkademik[
                                                    index]
                                                .semester)! %
                                            2 ==
                                        0
                                    ? 'Genap'
                                    : 'Ganjil',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                listKrsBimbinganPenasehatAkademik[index]
                                    .tahunAkademik,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                listKrsBimbinganPenasehatAkademik[index]
                                            .approve ==
                                        "1"
                                    ? "Sudah Diapprove"
                                    : "Belum Diapprove",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

class KrsListHeader extends StatelessWidget {
  const KrsListHeader({
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
            flex: 1,
            child: Text(
              'Maks Kredit',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Kredit Diambil',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Semester',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'T.A Akademik',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Status KRS',
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
