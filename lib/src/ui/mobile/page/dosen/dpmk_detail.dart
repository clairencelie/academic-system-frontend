import 'package:academic_system/src/bloc/dosen/dosen_bloc.dart';
import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileDPMKDetailPage extends StatefulWidget {
  final String idDosen;
  final String idMataKuliah;
  final String namaMataKuliah;
  final String tahunAkademik;

  const MobileDPMKDetailPage({
    super.key,
    required this.idDosen,
    required this.idMataKuliah,
    required this.namaMataKuliah,
    required this.tahunAkademik,
  });

  @override
  State<MobileDPMKDetailPage> createState() => _MobileDPMKDetailPageState();
}

class _MobileDPMKDetailPageState extends State<MobileDPMKDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DosenBloc>().add(
          GetNilaiMhs(
            idMataKuliah: widget.idMataKuliah,
            tahunAkademik: widget.tahunAkademik.split(" ").toList()[0],
            semester: widget.tahunAkademik.split(" ").toList()[1],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<DosenBloc>().add(
              GetMatkulDosen(idDosen: widget.idDosen),
            );
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DetailKelas(
                    idDosen: widget.idDosen,
                    idMataKuliah: widget.idMataKuliah,
                    namaMataKuliah: widget.namaMataKuliah,
                    tahunAkademik: widget.tahunAkademik,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailKelas extends StatelessWidget {
  const DetailKelas({
    Key? key,
    required this.idDosen,
    required this.idMataKuliah,
    required this.namaMataKuliah,
    required this.tahunAkademik,
  }) : super(key: key);

  final String idDosen;
  final String idMataKuliah;
  final String namaMataKuliah;
  final String tahunAkademik;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DosenBloc, DosenState>(
      builder: (context, state) {
        if (state is NilaiMhsFound) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DPMKDetailHeader(
                idDosen: idDosen,
                namaMataKuliah: namaMataKuliah,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                namaMataKuliah,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Jumlah peserta kelas: ${state.nilaiMhsList.length}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'List Peserta',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListNilaiMahasiswa(
                listNilaiMhs: state.nilaiMhsList,
                namaMataKuliah: namaMataKuliah,
                idDosen: idDosen,
                tahunAkademik: tahunAkademik,
              ),
            ],
          );
        } else if (state is NilaiMhsNotFound) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DPMKDetailHeader(
                  idDosen: idDosen,
                  namaMataKuliah: namaMataKuliah,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  namaMataKuliah,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const Center(
                    child: Text(
                      'Mata kuliah ini belum memiliki peserta',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class DPMKDetailHeader extends StatelessWidget {
  final String idDosen;
  final String namaMataKuliah;
  const DPMKDetailHeader({
    Key? key,
    required this.idDosen,
    required this.namaMataKuliah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.only(right: 15),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
            context.read<DosenBloc>().add(
                  GetMatkulDosen(idDosen: idDosen),
                );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Detail Kelas',
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
  final String idDosen;
  final String tahunAkademik;
  final String namaMataKuliah;
  final List<NilaiMahasiswa> listNilaiMhs;
  const ListNilaiMahasiswa({
    Key? key,
    required this.namaMataKuliah,
    required this.listNilaiMhs,
    required this.idDosen,
    required this.tahunAkademik,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listNilaiMhs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    children: [
                      Expanded(
                        child: Text(
                          listNilaiMhs[index].nama,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          listNilaiMhs[index].nim,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Jurusan: ${listNilaiMhs[index].jurusan}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // Text(
                  //   listNilaiMhs[index].kehadiran.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   listNilaiMhs[index].tugas.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   listNilaiMhs[index].uts.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   listNilaiMhs[index].uas.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   listNilaiMhs[index].nilai.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   listNilaiMhs[index].angkaKualitas.toString(),
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   listNilaiMhs[index].status,
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
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

class ListNilaiHeader extends StatelessWidget {
  const ListNilaiHeader({
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
          SizedBox(
            width: 10,
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
            flex: 2,
            child: Text(
              'Jurusan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Absen',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Tugas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'UTS',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'UAS',
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
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     'Kualitas',
          //     style: TextStyle(
          //       fontSize: 17,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Text(
              'Status',
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
