import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:flutter/material.dart';

class DetailKrsMhs extends StatelessWidget {
  final KartuRencanaStudiLengkap krs;

  const DetailKrsMhs({
    super.key,
    required this.krs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KRSDetailHeader(),
                  const SizedBox(
                    height: 20,
                  ),
                  KRSDetailInfo(nama: krs.nama, krs: krs),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'List Mata Kuliah Dipilih',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // List Matkul yang diambil
                  const MatkulListHeader(),
                  const Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: krs.pilihanMataKuliah.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 15),
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
                        child: Center(
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      krs.pilihanMataKuliah[index].idMatkul),
                                ),
                                Expanded(
                                  flex: 2,
                                  child:
                                      Text(krs.pilihanMataKuliah[index].name),
                                ),
                                Expanded(
                                  child:
                                      Text(krs.pilihanMataKuliah[index].credit),
                                ),
                                Expanded(
                                  child:
                                      Text(krs.pilihanMataKuliah[index].grade),
                                ),
                                Expanded(
                                  child:
                                      Text(krs.pilihanMataKuliah[index].type),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KRSDetailInfo extends StatelessWidget {
  const KRSDetailInfo({
    Key? key,
    required this.nama,
    required this.krs,
  }) : super(key: key);

  final String nama;
  final KartuRencanaStudiLengkap krs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: $nama',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'NIM: ${krs.nim}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Semester: ${krs.semester}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Program Studi: ${krs.jurusan}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IPK: ${krs.ipk}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'IPS: ${krs.ips}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Kredit Diambil: ${krs.kreditDiambil}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Beban Maks SKS: ${int.tryParse(krs.semester)! < 5 ? '20' : krs.bebanSksMaks}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tanggal Pengisian KRS: ${krs.waktuPengisian}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'T.A Akademik: ${krs.tahunAkademik}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Status KRS: ${krs.commit == '1' ? "Dikunci" : "Belum dikunci"}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class KRSDetailHeader extends StatelessWidget {
  const KRSDetailHeader({
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
          'Detail Kartu Rencana Studi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MatkulListHeader extends StatelessWidget {
  const MatkulListHeader({
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
              'Nama  Mata Kuliah',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'SKS',
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
              'Jenis',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
