import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:flutter/material.dart';

class MobileDetailKrsMhs extends StatelessWidget {
  final KartuRencanaStudiLengkap krs;

  const MobileDetailKrsMhs({
    super.key,
    required this.krs,
  });

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const KRSDetailHeader(),
                    const SizedBox(
                      height: 20,
                    ),
                    KRSDetailInfo(krs: krs),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'List Mata Kuliah Dipilih',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: krs.pilihanMataKuliah.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 15),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    krs.pilihanMataKuliah[index].idMatkul,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    krs.pilihanMataKuliah[index].grade,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                krs.pilihanMataKuliah[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Jumlah SKS: ${krs.pilihanMataKuliah[index].credit}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                // '${krs.pilihanMataKuliah[index].type[0].toUpperCase()}${krs.pilihanMataKuliah[index].type.substring(1)}',
                                krs.pilihanMataKuliah[index].type.toUpperCase(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

class KRSDetailInfo extends StatelessWidget {
  const KRSDetailInfo({
    Key? key,
    required this.krs,
  }) : super(key: key);

  final KartuRencanaStudiLengkap krs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama: ${krs.nama}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'NIM: ${krs.nim}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Semester: ${krs.semester}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Program Studi: ${krs.jurusan}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'IPK: ${krs.ipk}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'IPS: ${krs.ips}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Kredit Diambil: ${krs.kreditDiambil}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Beban Maks SKS: ${int.tryParse(krs.semester)! < 5 ? '20' : krs.bebanSksMaks}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Tanggal Pengisian KRS: ${DateConverter.mySQLToDartDateFormat(krs.waktuPengisian)}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'T.A Akademik: ${krs.tahunAkademik}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Approval: ${krs.approve == '1' ? "Sudah diapprove" : "Belum diapprove"}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Status KRS: ${krs.commit == '1' ? "Sudah dikunci" : "Belum dikunci"}',
          style: const TextStyle(
            fontSize: 18,
          ),
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
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          constraints: const BoxConstraints(),
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
