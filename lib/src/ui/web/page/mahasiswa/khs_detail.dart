import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';

class KHSDetailPage extends StatelessWidget {
  final Student student;
  final KartuHasilStudi khs;
  final List<NilaiMahasiswa> listNilaiMahasiswa;
  const KHSDetailPage({
    super.key,
    required this.student,
    required this.khs,
    required this.listNilaiMahasiswa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.6,
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
                  const Divider(),
                  const HeaderListNilaiMahasiswa(),
                  const Divider(),
                  // Listview nilai
                  ListNilaiMahasiswa(listNilaiMahasiswa: listNilaiMahasiswa),
                  const Divider(),
                  TotalPerhitunganKhs(listNilaiMahasiswa: listNilaiMahasiswa),
                  const Divider(),
                ],
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

class ListNilaiMahasiswa extends StatelessWidget {
  final List<NilaiMahasiswa> listNilaiMahasiswa;
  const ListNilaiMahasiswa({super.key, required this.listNilaiMahasiswa});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listNilaiMahasiswa.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          decoration: BoxDecoration(
            color: index % 2 == 1
                ? const Color.fromARGB(255, 242, 244, 246)
                : const Color.fromARGB(255, 231, 235, 241),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Text(
                  (index + 1).toString(),
                ),
              ),
              Expanded(
                child: Text(
                  listNilaiMahasiswa[index].idMataKuliah,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  listNilaiMahasiswa[index].namaMataKuliah,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Text(
                  listNilaiMahasiswa[index].jumlahSks.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  listNilaiMahasiswa[index].nilai,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  listNilaiMahasiswa[index].angkaKualitas.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeaderListNilaiMahasiswa extends StatelessWidget {
  const HeaderListNilaiMahasiswa({
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
              'No',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Kode',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Mata Kuliah',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 50,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Sks',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Nilai',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Angka Kualitas',
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

class TotalPerhitunganKhs extends StatelessWidget {
  final List<NilaiMahasiswa> listNilaiMahasiswa;

  const TotalPerhitunganKhs({
    Key? key,
    required this.listNilaiMahasiswa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalSks = 0;
    int totalAngkaKualitas = 0;

    for (var nilaiMahasiswa in listNilaiMahasiswa) {
      totalSks += nilaiMahasiswa.jumlahSks;
      totalAngkaKualitas += nilaiMahasiswa.angkaKualitas;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          const SizedBox(
            width: 50,
          ),
          const Expanded(flex: 1, child: SizedBox()),
          const Expanded(
            flex: 1,
            child: Text(
              'Total',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
          const SizedBox(
            width: 50,
          ),
          Expanded(
            flex: 1,
            child: Text(
              totalSks.toString(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 1,
            child: Text(
              totalAngkaKualitas.toString(),
              style: const TextStyle(
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
