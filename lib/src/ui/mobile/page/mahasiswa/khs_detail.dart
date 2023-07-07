import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';

class MobileKHSDetailPage extends StatelessWidget {
  final Student student;
  final KartuHasilStudi khs;
  final List<NilaiMahasiswa> listNilaiMahasiswa;
  const MobileKHSDetailPage({
    super.key,
    required this.student,
    required this.khs,
    required this.listNilaiMahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    int totalSks = 0;
    int totalAngkaKualitas = 0;

    for (var nilaiMahasiswa in listNilaiMahasiswa) {
      totalSks += nilaiMahasiswa.jumlahSks;
      totalAngkaKualitas += nilaiMahasiswa.angkaKualitas;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderKhsDetail(),
                    const SizedBox(
                      height: 20,
                    ),
                    DetailInfoKhs(student: student, khs: khs),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'List Mata Kuliah Diambil',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Listview nilai
                    ListNilaiMahasiswa(listNilaiMahasiswa: listNilaiMahasiswa),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Total angka kualitas',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                ':',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '$totalAngkaKualitas',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Total sks diambil',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                ':',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                '$totalSks',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class DetailInfoKhs extends StatelessWidget {
  const DetailInfoKhs({
    Key? key,
    required this.student,
    required this.khs,
  }) : super(key: key);

  final Student student;
  final KartuHasilStudi khs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama: ${student.name}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'NIM: ${student.id}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'KHS Semester: ${khs.semester} ${int.tryParse(khs.semester)! % 2 == 0 ? '(Genap)' : '(Ganjil)'}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Tahun akademik: ${khs.tahunAkademik}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'IPS: ${khs.ips}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Kredit diambil: ${khs.kreditDiambil}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Kredit diperoleh: ${khs.kreditDiperoleh}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          'Maks beban sks semester selanjutnya: ${khs.maskSks}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class ListNilaiMahasiswa extends StatelessWidget {
  final List<NilaiMahasiswa> listNilaiMahasiswa;
  const ListNilaiMahasiswa({super.key, required this.listNilaiMahasiswa});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listNilaiMahasiswa.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: index % 2 == 1
                ? const Color.fromARGB(255, 242, 244, 246)
                : const Color.fromARGB(255, 231, 235, 241),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      '${(index + 1)}. ',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                listNilaiMahasiswa[index].namaMataKuliah,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  listNilaiMahasiswa[index].idMataKuliahMaster,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              // flex: 4,
                              child: SizedBox(),
                            ),
                            Expanded(
                              child: Text(
                                '${listNilaiMahasiswa[index].jumlahSks.toString()} SKS',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              // flex: 10,
                              child: SizedBox(),
                            ),
                            Expanded(
                              child: Text(
                                listNilaiMahasiswa[index].nilai,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Angka Kualitas',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const Flexible(
                              child: Text(
                                ': ',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                listNilaiMahasiswa[index]
                                    .angkaKualitas
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeaderKhsDetail extends StatelessWidget {
  const HeaderKhsDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Detail Kartu Hasil Studi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
