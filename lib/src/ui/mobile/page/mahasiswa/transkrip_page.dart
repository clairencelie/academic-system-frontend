import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_rinci.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/khs_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileTranskripPage extends StatefulWidget {
  final User mahasiswa;

  const MobileTranskripPage({
    super.key,
    required this.mahasiswa,
  });

  @override
  State<MobileTranskripPage> createState() => _MobileTranskripPageState();
}

class _MobileTranskripPageState extends State<MobileTranskripPage> {
  @override
  void initState() {
    super.initState();

    context.read<KhsBloc>().add(
          GetTranskripRinciEvent(nim: widget.mahasiswa.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocBuilder<KhsBloc, KhsState>(
                  builder: (context, state) {
                    if (state is TranskripRinciLoaded) {
                      final TranskripRinci transkripRinci =
                          state.tranksripRinci;

                      final List<String> totalSemester = transkripRinci
                          .listNilaiKhs
                          .map((nilai) => nilai.semester)
                          .toList();

                      return RincianTranskrip(
                        transkripRinci: transkripRinci,
                        totalSemester: totalSemester.toSet().toList(),
                        mahasiswa: (widget.mahasiswa as Student),
                      );
                    } else if (state is KhsLoading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is TranskripFailed) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Text(
                          'Data transkrip nilai gagal didapatkan\nMohon refresh halaman.',
                        ),
                      );
                    }

                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RincianTranskrip extends StatelessWidget {
  final TranskripRinci transkripRinci;
  final List<String> totalSemester;
  final Student mahasiswa;

  const RincianTranskrip({
    Key? key,
    required this.transkripRinci,
    required this.totalSemester,
    required this.mahasiswa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              'Transkrip Nilai Anda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        KartuTranskripMahasiswa(
          mahasiswa: mahasiswa,
          transkripRinci: transkripRinci,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'List Kartu Hasil Studi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        transkripRinci.khs.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                child: const Center(
                  child: Text(
                    'Anda belum memiliki KHS',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : ListKhs(
                transkripRinci: transkripRinci,
                totalSemester: totalSemester,
                mahasiswa: mahasiswa,
              ),
      ],
    );
  }
}

class KartuTranskripMahasiswa extends StatelessWidget {
  const KartuTranskripMahasiswa({
    Key? key,
    required this.mahasiswa,
    required this.transkripRinci,
  }) : super(key: key);

  final Student mahasiswa;
  final TranskripRinci transkripRinci;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 32, 96),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Color.fromARGB(55, 0, 0, 0),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Color.fromARGB(105, 234, 234, 234),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mahasiswa.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        mahasiswa.id,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        mahasiswa.major,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Semester ${mahasiswa.semester}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 45),
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 2,
                          color: Color.fromARGB(105, 234, 234, 234),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'IPK',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          transkripRinci.transkripNilai.ipk.length > 3
                              ? transkripRinci.transkripNilai.ipk
                                  .substring(0, 4)
                              : transkripRinci.transkripNilai.ipk,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Kredit',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Total Diambil',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    transkripRinci.transkripNilai.totalKreditDiambil.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Total Perolehan',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    transkripRinci.transkripNilai.totalKreditDiperoleh
                        .toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ListKhs extends StatelessWidget {
  final TranskripRinci transkripRinci;
  final List<String> totalSemester;
  final Student mahasiswa;
  const ListKhs({
    super.key,
    required this.transkripRinci,
    required this.totalSemester,
    required this.mahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: totalSemester.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MobileKHSDetailPage(
                    student: mahasiswa,
                    khs: transkripRinci.khs[index],
                    listNilaiMahasiswa: transkripRinci.listNilaiKhs
                        .where((nilaiMhs) =>
                            nilaiMhs.semester ==
                            transkripRinci.khs[index].semester)
                        .toList(),
                  );
                },
              ),
            );
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                // margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: index % 2 == 1
                      ? const Color.fromARGB(255, 251, 253, 255)
                      : const Color.fromARGB(255, 239, 242, 252),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromARGB(55, 0, 0, 0),
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Semester ${transkripRinci.khs[index].semester.toString()}',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                          child: Text(
                            transkripRinci.khs[index].tahunAkademik,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'IPS',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          transkripRinci.khs[index].ips,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Kredit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Diambil: ${transkripRinci.khs[index].kreditDiambil}',
                      style: const TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Diperoleh: ${transkripRinci.khs[index].kreditDiperoleh}',
                      style: const TextStyle(
                        fontSize: 17,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Beban Maks SKS Semester Selanjutnya',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      transkripRinci.khs[index].maskSks,
                      style: const TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              index == totalSemester.length - 1
                  ? const SizedBox()
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
