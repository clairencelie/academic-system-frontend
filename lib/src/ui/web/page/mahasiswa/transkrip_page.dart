import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_rinci.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/mahasiswa/khs_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TranskripPage extends StatefulWidget {
  final User mahasiswa;

  const TranskripPage({
    super.key,
    required this.mahasiswa,
  });

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
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
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BlocBuilder<KhsBloc, KhsState>(
              builder: (context, state) {
                if (state is TranskripRinciLoaded) {
                  final TranskripRinci transkripRinci = state.tranksripRinci;

                  final List<String> totalSemester = transkripRinci.listNilaiKhs
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
        const Text(
          'Transkrip Nilai Mahasiswa',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IdentitasMahasiswa(mahasiswa: mahasiswa),
            PerolehanMahasiswa(transkripRinci: transkripRinci),
          ],
        ),
        // ListView
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
        const KhsListHeader(),
        const Divider(),
        ListKhs(
          transkripRinci: transkripRinci,
          totalSemester: totalSemester,
          mahasiswa: mahasiswa,
        ),
      ],
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
      shrinkWrap: true,
      itemCount: totalSemester.length,
      itemBuilder: (context, index) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return KHSDetailPage(
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
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
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
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Text(
                      transkripRinci.khs[index].semester.toString(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      transkripRinci.khs[index].tahunAkademik,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      transkripRinci.khs[index].ips,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      transkripRinci.khs[index].kreditDiambil,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      transkripRinci.khs[index].kreditDiperoleh,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      transkripRinci.khs[index].maskSks,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PerolehanMahasiswa extends StatelessWidget {
  const PerolehanMahasiswa({
    Key? key,
    required this.transkripRinci,
  }) : super(key: key);

  final TranskripRinci transkripRinci;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color.fromARGB(255, 0, 32, 96),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'IPK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                transkripRinci.transkripNilai.ipk,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 50,
          ),
          Column(
            children: [
              const Text(
                'Total Kredit Diambil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                transkripRinci.transkripNilai.totalKreditDiambil.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              const Text(
                'Total Kredit Diperoleh',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                transkripRinci.transkripNilai.totalKreditDiperoleh.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IdentitasMahasiswa extends StatelessWidget {
  const IdentitasMahasiswa({
    Key? key,
    required this.mahasiswa,
  }) : super(key: key);

  final Student mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama: ${mahasiswa.name}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'NIM: ${mahasiswa.id}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Semester: ${mahasiswa.semester}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Angkatan: ${mahasiswa.batchOf}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class KhsListHeader extends StatelessWidget {
  const KhsListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: const [
          SizedBox(
            width: 50,
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
              'Tahun Akademik',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'IPS',
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
              'Kredit Diperoleh',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Beban Maks SKS Selanjutnya',
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
