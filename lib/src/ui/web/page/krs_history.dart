import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/web/page/krs_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KrsHistoryPage extends StatefulWidget {
  final Student student;

  const KrsHistoryPage({
    super.key,
    required this.student,
  });

  @override
  State<KrsHistoryPage> createState() => _KrsHistoryPageState();
}

class _KrsHistoryPageState extends State<KrsHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetKrsLengkap(nim: widget.student.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<KrsBloc>().add(
                              GetKrsSchedule(
                                nim: widget.student.id,
                                semester: widget.student.semester,
                              ),
                            );
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    'List Mata KRS',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<KrsBloc, KrsState>(
                builder: (context, state) {
                  if (state is KrsFound) {
                    return Column(
                      children: [
                        const KrsListHeader(),
                        const Divider(),
                        KrsList(
                          krsLengkap: state.krsLengkap,
                          student: widget.student,
                        ),
                      ],
                    );
                  } else if (state is KrsLoading) {
                    return const CircularProgressIndicator();
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KrsList extends StatelessWidget {
  final List<KartuRencanaStudiLengkap> krsLengkap;
  final Student student;

  const KrsList({
    Key? key,
    required this.krsLengkap,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: krsLengkap.length,
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
                        return KRSDetailPage(
                          krs: krsLengkap[index],
                          student: student,
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
                          krsLengkap[index].semester,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          krsLengkap[index].kreditDiambil,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          krsLengkap[index].waktuPengisian,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          krsLengkap[index].tahunAkademik,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          krsLengkap[index].commit == "1"
                              ? "Dikunci"
                              : "Belum dikunci",
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
        ],
      ),
    );
  }
}
