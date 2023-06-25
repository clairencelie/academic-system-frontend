import 'package:academic_system/src/bloc/tagihan/tagihan_perkuliahan_bloc.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/tagihan_perkuliahan.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/page/mahasiswa/detail_tagihan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TagihanPembayaran extends StatefulWidget {
  final User user;

  const TagihanPembayaran({
    super.key,
    required this.user,
  });

  @override
  State<TagihanPembayaran> createState() => _TagihanPembayaranState();
}

class _TagihanPembayaranState extends State<TagihanPembayaran> {
  @override
  void initState() {
    super.initState();
    context.read<TagihanPerkuliahanBloc>().add(
          GetListTagihan(nim: widget.user.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    Student student = widget.user as Student;

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'List Tagihan Pembayaran Kuliah',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama : ${student.name}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'NIM : ${student.id}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Semester : ${student.semester}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.blue, width: 1),
                            ),
                          ),
                          child: const Text(
                            'Histori Transaksi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const HeaderListTagihan(),
                const Divider(),
                BlocBuilder<TagihanPerkuliahanBloc, TagihanPerkuliahanState>(
                  builder: (context, state) {
                    if (state is TagihanPerkuliahanLoading) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is TagihanPerkuliahanLoaded) {
                      // List Tagihan
                      return ListTagihanPerkuliahan(
                        listTagihan: state.listTagihan,
                        student: student,
                      );
                    } else if (state is TagihanPerkuliahanNotFound) {
                      return const Text(
                          'Anda belum memiliki tagihan pembayaran perkuliahan');
                    }

                    // Else
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListTagihanPerkuliahan extends StatelessWidget {
  final List<TagihanPerkuliahan> listTagihan;
  final Student student;

  const ListTagihanPerkuliahan({
    Key? key,
    required this.listTagihan,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listTagihan.length,
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
                        return DetailTagihanPage(
                          student: student,
                          tagihanPerkuliahan: listTagihan[index],
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 70,
                  decoration: BoxDecoration(
                    color: listTagihan[index].statusPembayaran == 'lunas'
                        ? const Color.fromARGB(255, 237, 252, 244)
                        : listTagihan[index].statusPembayaran == 'cicilan'
                            ? const Color.fromARGB(255, 255, 253, 234)
                            : const Color.fromARGB(255, 255, 245, 245),
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
                          listTagihan[index].tahunAkademik,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${listTagihan[index].semester[0].toUpperCase()}${listTagihan[index].semester.substring(1).toLowerCase()}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          listTagihan[index].kategori,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(listTagihan[index].totalTagihan),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          NumberFormat.currency(
                            locale: 'id_ID',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(listTagihan[index].sisaPembayaran),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          listTagihan[index].metodePembayaran == 'full'
                              ? "Pembayaran Full"
                              : "Cicilan",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          listTagihan[index].statusPembayaran == "lunas"
                              ? "Lunas"
                              : listTagihan[index].statusPembayaran == "cicilan"
                                  ? "Cicilan"
                                  : "Belum bayar",
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

class HeaderListTagihan extends StatelessWidget {
  const HeaderListTagihan({
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
              'Tahun Akd.',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            flex: 2,
            child: Text(
              'Kategori',
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
              'Total Tagihan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Sisa Tagihan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Tipe Pembayaran',
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
