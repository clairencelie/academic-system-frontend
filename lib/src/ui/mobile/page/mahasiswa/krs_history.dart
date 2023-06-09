import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/penasehat_akademik.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/krs_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileKrsHistoryPage extends StatefulWidget {
  final Student student;

  const MobileKrsHistoryPage({
    super.key,
    required this.student,
  });

  @override
  State<MobileKrsHistoryPage> createState() => _MobileKrsHistoryPageState();
}

class _MobileKrsHistoryPageState extends State<MobileKrsHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetKrsLengkap(nim: widget.student.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            padding: const EdgeInsets.only(right: 15),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            constraints: const BoxConstraints(),
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
                          'Histori Pengisian KRS',
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
                    const Text(
                      'Anda dapat mengajukan perubahan pilihan mata kuliah pada KRS yang sudah diajukan selama KRS anda belum dikunci.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Hubungi penasehat akademik anda terlebih dahulu untuk mengajukan perubahan pilihan mata kuliah.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'List Histori KRS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<KrsBloc, KrsState>(
                      builder: (context, state) {
                        if (state is KrsFound) {
                          return Column(
                            children: [
                              KrsList(
                                krsLengkap: state.krsLengkap,
                                student: widget.student,
                              ),
                            ],
                          );
                        } else if (state is KrsLoading) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height / 1.7,
                              child: const Center(
                                  child: CircularProgressIndicator()));
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
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
    List<PenasehatAkademik> listPA = [
      PenasehatAkademik(
        id: '151190003',
        name: 'Sugesti, S.Si., M.Kom.',
      ),
      PenasehatAkademik(
        id: '151190006',
        name: 'Hari Santoso, S.Kom., M.Kom.',
      ),
      PenasehatAkademik(
        id: '151190010',
        name: 'Hans Saputra, S.Kom., MMSI.',
      ),
      PenasehatAkademik(
        id: '151190012',
        name: 'Desy Mora Daulay, S.Kom., M.Kom.',
      ),
      PenasehatAkademik(
        id: '151190013',
        name: 'Syarah, S.Kom., M.Kom.',
      ),
      PenasehatAkademik(
        id: '151190009',
        name: 'Sobiyanto, S.E., S.Kom., M.Kom., MTA.',
      ),
      PenasehatAkademik(
        id: '151190018',
        name: 'Rama Putra, S.Kom., M.Kom.',
      ),
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: krsLengkap.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MobileKRSDetailPage(
                        krs: krsLengkap[index],
                        student: student,
                      );
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: index % 2 == 1
                      ? const Color.fromARGB(255, 247, 249, 253)
                      : const Color.fromARGB(255, 227, 238, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 1,
                      color: Color.fromARGB(55, 0, 0, 0),
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Semester ${krsLengkap[index].semester}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            krsLengkap[index].commit == "1"
                                ? "Dikunci"
                                : "Belum dikunci",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Tahun Akademik: ${krsLengkap[index].tahunAkademik}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Kredit Diambil: ${krsLengkap[index].kreditDiambil}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Maks SKS: ${krsLengkap[index].bebanSksMaks}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Tanggal Pengisian: ${krsLengkap[index].waktuPengisian}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'P.A: ${listPA.where((element) => element.id == krsLengkap[index].idDosen).first.name}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        krsLengkap[index].approve == '1'
                            ? 'Sudah Diapprove'
                            : 'Belum Diapprove',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            index == krsLengkap.length - 1
                ? const SizedBox()
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(thickness: 1),
                  ),
          ],
        );
      },
    );
  }
}
