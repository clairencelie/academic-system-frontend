import 'package:academic_system/src/bloc/tagihan/tagihan_perkuliahan_bloc.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/tagihan_perkuliahan.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/detail_tagihan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MobileTagihanPembayaran extends StatefulWidget {
  final User user;

  const MobileTagihanPembayaran({
    super.key,
    required this.user,
  });

  @override
  State<MobileTagihanPembayaran> createState() =>
      _MobileTagihanPembayaranState();
}

class _MobileTagihanPembayaranState extends State<MobileTagihanPembayaran> {
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Text(
                          'List Tagihan Pembayaran Kuliah',
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
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.blue, width: 1),
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
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'List Tagihan Kuliah',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<TagihanPerkuliahanBloc,
                        TagihanPerkuliahanState>(
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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listTagihan.length,
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
                      return MobileDetailTagihanPage(
                        student: student,
                        tagihanPerkuliahan: listTagihan[index],
                      );
                    },
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 253, 255),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listTagihan[index].kategori,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          listTagihan[index].statusPembayaran == "lunas"
                              ? "Lunas"
                              : listTagihan[index].statusPembayaran == "cicilan"
                                  ? "Cicilan"
                                  : "Belum bayar",
                          style: listTagihan[index].statusPembayaran == "lunas"
                              ? const TextStyle(
                                  color: Color.fromARGB(255, 5, 157, 68),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )
                              : const TextStyle(
                                  color: Color.fromARGB(255, 164, 37, 28),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(listTagihan[index].totalTagihan),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Text(
                    //   'Sisa : ${NumberFormat.currency(
                    //     locale: 'id_ID',
                    //     symbol: 'Rp ',
                    //     decimalDigits: 0,
                    //   ).format(listTagihan[index].sisaPembayaran)}',
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // Text(
                    //   listTagihan[index].metodePembayaran == 'full'
                    //       ? "Pembayaran Full"
                    //       : "Cicilan",
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //   ),
                    // ),
                    Text(
                      'T.A ${listTagihan[index].tahunAkademik}',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Semester ${listTagihan[index].semester[0].toUpperCase()}${listTagihan[index].semester.substring(1).toLowerCase()}',
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
