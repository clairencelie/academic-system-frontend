import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/tahun_akademik.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:academic_system/src/ui/web/page/akademik/detail_krs_mhs.dart';
import 'package:academic_system/src/ui/web/page/akademik/form_jadwal_krs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KRSManagementPage extends StatefulWidget {
  const KRSManagementPage({
    super.key,
  });

  @override
  State<KRSManagementPage> createState() => _KRSManagementPageState();
}

class _KRSManagementPageState extends State<KRSManagementPage> {
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
            widthFactor: 0.8,
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
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.arrow_back),
                                      ),
                                      const Text(
                                        'Manajemen KRS',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  DropdownButton(
                                    value: tahunAkademikDropDownValue,
                                    items: dropDownMenuList(listTA),
                                    onChanged: (value) {
                                      setState(() {
                                        tahunAkademikDropDownValue = value;
                                      });
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Jadwal Pengisian KRS: ${DateConverter.convertToDartDateFormat(jadwalKrs.tanggalMulai)} - ${DateConverter.convertToDartDateFormat(jadwalKrs.tanggalSelesai)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Button set Jadwal KRS
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          width: 400,
                                          child: const FormJadwalKrs(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text('Set Jadwal KRS'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              Text(
                                'List KRS Mahasiswa T.A $tahunAkademikDropDownValue',
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
                              BlocListener<KrsManagementBloc,
                                  KrsManagementState>(
                                listener: (context, state) {
                                  if (state is LockKrsSuccess) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return InfoDialog(
                                          title: 'Informasi',
                                          body: state.message,
                                          onClose: () {
                                            Navigator.pop(context);
                                            context
                                                .read<KrsBloc>()
                                                .add(GetAllKrs());
                                          },
                                        );
                                      },
                                    );
                                  } else if (state is LockKrsFailed) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return InfoDialog(
                                          title: 'Informasi',
                                          body: state.message,
                                          onClose: () {
                                            Navigator.pop(context);
                                            context
                                                .read<KrsBloc>()
                                                .add(GetAllKrs());
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                                child: BlocBuilder<KrsBloc, KrsState>(
                                  builder: (context, state) {
                                    if (state is KrsFound) {
                                      return KrsManagementList(
                                        krsLengkap: state.krsLengkap,
                                        tahunAkademik:
                                            tahunAkademikDropDownValue,
                                      );
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                ),
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
                        return Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const CircularProgressIndicator(),
                          ],
                        );
                      },
                    );
                  } else if (state is ScheduleKrsFailed) {
                    return Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Text('Jadwal KRS Gagal didapatkan'),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const CircularProgressIndicator(),
                    ],
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
  final List<KartuRencanaStudiLengkap> krsLengkap;
  final String tahunAkademik;

  const KrsManagementList({
    Key? key,
    required this.krsLengkap,
    required this.tahunAkademik,
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

    return ListView.builder(
      itemCount: filterTahunAkademikKrs.length,
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
                    return DetailKrsMhs(krs: filterTahunAkademikKrs[index]);
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
                          filterTahunAkademikKrs[index].nim,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          filterTahunAkademikKrs[index].nama,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          filterTahunAkademikKrs[index].semester,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          filterTahunAkademikKrs[index].kreditDiambil,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          DateConverter.mySQLToDartDateFormat(
                              filterTahunAkademikKrs[index].waktuPengisian),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          filterTahunAkademikKrs[index].tahunAkademik,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          filterTahunAkademikKrs[index].commit == "1"
                              ? "Dikunci"
                              : "Belum dikunci",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: filterTahunAkademikKrs[index].commit == "1"
                              ? null
                              : () {
                                  // Call commit krs
                                  context.read<KrsManagementBloc>().add(
                                        LockKrs(
                                            idKrs: filterTahunAkademikKrs[index]
                                                .id),
                                      );
                                },
                          child: const Text('Kunci KRS'),
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
              'Smt',
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
          Expanded(
            flex: 1,
            child: Text(
              'Tanggal Pengajuan KRS',
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
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
