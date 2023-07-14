import 'package:academic_system/src/bloc/dosen/dosen_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/model/matkul_dosen.dart';
import 'package:academic_system/src/model/tahun_akademik.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/dosen/dpmk_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileDPMKPage extends StatefulWidget {
  final User dosen;
  const MobileDPMKPage({
    super.key,
    required this.dosen,
  });

  @override
  State<MobileDPMKPage> createState() => _MobileDPMKPageState();
}

class _MobileDPMKPageState extends State<MobileDPMKPage> {
  String tahunAkademikDropDownValue = '';

  List<DropdownMenuItem> dropDownMenuList(List<TahunAkademik> listTA) {
    return listTA.map((tahunAkademik) {
      return DropdownMenuItem(
        value: tahunAkademik.tahunAkademik,
        child: Text(
          tahunAkademik.tahunAkademik,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetTahunAkademik());
    context.read<TahunAkademikBloc>().add(GetListTA());
    context.read<DosenBloc>().add(GetMatkulDosen(idDosen: widget.dosen.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocBuilder<KrsBloc, KrsState>(
                  builder: (context, state) {
                    if (state is KrsScheduleLoaded) {
                      // semester berjalan
                      final String semesterBerjalan =
                          '${state.krsSchedule.tahunAkademik} ${state.krsSchedule.semester}';

                      return BlocBuilder<TahunAkademikBloc, TahunAkademikState>(
                        builder: (context, state) {
                          if (state is TahunAkademikLoaded) {
                            // List tahun akademik
                            List<TahunAkademik> listTA = state.listTA;

                            return BlocBuilder<DosenBloc, DosenState>(
                              builder: (context, state) {
                                if (state is MatkulDosenFound) {
                                  if (tahunAkademikDropDownValue == '') {
                                    tahunAkademikDropDownValue =
                                        semesterBerjalan;
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const HeaderDPMK(),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Tahun Akademik:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton(
                                              isExpanded: true,
                                              value: tahunAkademikDropDownValue,
                                              items: dropDownMenuList(listTA),
                                              onChanged: (value) {
                                                setState(() {
                                                  tahunAkademikDropDownValue =
                                                      value;
                                                });
                                                context.read<DosenBloc>().add(
                                                    GetMatkulDosen(
                                                        idDosen:
                                                            widget.dosen.id));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'List Mata Kuliah',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListMatkulDosen(
                                        idDosen: widget.dosen.id,
                                        matkulDosen: state.matkulDosen,
                                        tahunAkademik:
                                            tahunAkademikDropDownValue,
                                      ),
                                    ],
                                  );
                                }
                                return SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: const Center(
                                        child: CircularProgressIndicator()));
                              },
                            );
                          }
                          return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                  child: CircularProgressIndicator()));
                        },
                      );
                    }
                    return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child:
                            const Center(child: CircularProgressIndicator()));
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

class HeaderDPMK extends StatelessWidget {
  const HeaderDPMK({
    Key? key,
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
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Data Peserta Mata Kuliah',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ListMatkulDosen extends StatelessWidget {
  final String idDosen;
  final List<MatkulDosen> matkulDosen;
  final String tahunAkademik;
  const ListMatkulDosen({
    Key? key,
    required this.idDosen,
    required this.matkulDosen,
    required this.tahunAkademik,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String tahunAkd = tahunAkademik.split(" ").toList()[0];
    final String semester = tahunAkademik.split(" ").toList()[1];
    List<MatkulDosen> filteredMatkul = semester == "genap"
        ? matkulDosen
            .where((matkul) => int.tryParse(matkul.kelas[1])! % 2 == 0)
            .toList()
        : matkulDosen
            .where((matkul) => int.tryParse(matkul.kelas[1])! % 2 == 1)
            .toList();

    List<MatkulDosen> filteredMatkulTahunAkademik = filteredMatkul
        .where((element) => element.tahunAkademik == tahunAkd)
        .toList();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredMatkulTahunAkademik.length,
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
                      return MobileDPMKDetailPage(
                        idDosen: idDosen,
                        idMataKuliah:
                            filteredMatkulTahunAkademik[index].idMataKuliah,
                        namaMataKuliah: filteredMatkulTahunAkademik[index].nama,
                        tahunAkademik: tahunAkademik,
                      );
                    },
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            filteredMatkulTahunAkademik[index].nama,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            filteredMatkulTahunAkademik[index]
                                .idMataKuliahMaster,
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
                      height: 10,
                    ),
                    Text(
                      filteredMatkulTahunAkademik[index].kelas,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${filteredMatkulTahunAkademik[index].jumlahSks} SKS',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
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

class ListMatkulHeader extends StatelessWidget {
  const ListMatkulHeader({
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
              'Nama Mata Kuliah',
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
              'Jumlah SKS',
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
