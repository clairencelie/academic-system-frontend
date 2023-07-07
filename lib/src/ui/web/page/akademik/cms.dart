import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/cms_item.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/schedule_table.dart';
import 'package:academic_system/src/ui/web/page/akademik/create_schedule.dart';
import 'package:academic_system/src/ui/web/page/akademik/form_tahun_akademik.dart';
import 'package:academic_system/src/ui/web/page/akademik/krs_management.dart';
import 'package:academic_system/src/ui/web/page/akademik/matkul_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CMSPage extends StatefulWidget {
  const CMSPage({super.key});

  @override
  State<CMSPage> createState() => _CMSPageState();
}

class _CMSPageState extends State<CMSPage> {
  Color backgroundColor = const Color.fromARGB(255, 248, 250, 252);

  Color contentColor = const Color.fromARGB(255, 0, 32, 96);

  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetTahunAkademik());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: BlocBuilder<KrsBloc, KrsState>(
              builder: (context, state) {
                if (state is KrsScheduleLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Content Management System',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            CMSItem(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width < 700
                                  ? MediaQuery.of(context).size.width / 6
                                  : MediaQuery.of(context).size.width / 8.5,
                              title: 'Tambah Jadwal',
                              fontSize: 15,
                              icons: Icons.post_add_rounded,
                              iconSize: 35,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateSchedulePage(
                                        krsSchedule: state.krsSchedule),
                                  ),
                                );
                              },
                            ),
                            CMSItem(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width < 700
                                  ? MediaQuery.of(context).size.width / 6
                                  : MediaQuery.of(context).size.width / 8.5,
                              title: 'Manajemen KRS',
                              fontSize: 15,
                              iconSize: 35,
                              icons: Icons.library_books,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const KRSManagementPage(),
                                    ));
                              },
                            ),
                            CMSItem(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width < 700
                                  ? MediaQuery.of(context).size.width / 6
                                  : MediaQuery.of(context).size.width / 8.5,
                              title: 'Tahun Akademik',
                              fontSize: 15,
                              icons: Icons.view_timeline,
                              iconSize: 35,
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        width: 430,
                                        child: FormTahunAkademik(
                                          krsSchedule: state.krsSchedule,
                                        ),
                                      ), //
                                    );
                                  },
                                );
                              },
                            ),
                            CMSItem(
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width < 700
                                  ? MediaQuery.of(context).size.width / 6
                                  : MediaQuery.of(context).size.width / 8.5,
                              title: 'Manajemen Mata Kuliah',
                              fontSize: 15,
                              icons: Icons.list_alt_sharp,
                              iconSize: 35,
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MatkulManagementPage(
                                        krsSchedule: state.krsSchedule,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'List Jadwal Perkuliahan T.A ${state.krsSchedule.tahunAkademik} - ${state.krsSchedule.semester[0].toUpperCase()}${state.krsSchedule.semester.substring(1)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ScheduleTable(
                          krsSchedule: state.krsSchedule,
                        ),
                      ],
                    ),
                  );
                } else if (state is KrsScheduleNotFound) {
                  return const Center(
                    child: Text(
                        'Data Tahun Akademik Gagal Didapatkan\nMohon refresh halaman.'),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
