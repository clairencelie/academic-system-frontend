import 'package:academic_system/src/bloc/histori_transaksi/histori_transaksi_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/histori_transaksi.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MobileHistoriTransakasi extends StatefulWidget {
  final Student mahasiswa;

  const MobileHistoriTransakasi({
    super.key,
    required this.mahasiswa,
  });

  @override
  State<MobileHistoriTransakasi> createState() =>
      _MobileHistoriTransakasiState();
}

class _MobileHistoriTransakasiState extends State<MobileHistoriTransakasi> {
  @override
  void initState() {
    super.initState();

    context
        .read<HistoriTransaksiBloc>()
        .add(GetListHistoryTransaksi(nim: widget.mahasiswa.id));
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          'List Histori Transaksi',
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
                    const Text(
                      'Berikut adalah list histori transaksi anda:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<HistoriTransaksiBloc, HistoriTransaksiState>(
                      builder: (context, state) {
                        if (state is AllHistoriTransaksiLoaded) {
                          if (state.listHistoriTransaksi.isEmpty) {
                            return const Text(
                                'Anda belum pernah melakukan transaksi.');
                          }
                          return ListHistoriTransaksi(
                              listHistoriTransaksi: state.listHistoriTransaksi);
                        }
                        return const SizedBox(
                          height: 100,
                          child: Center(
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

class ListHistoriTransaksi extends StatelessWidget {
  final List<HistoriTransaksi> listHistoriTransaksi;

  const ListHistoriTransaksi({
    Key? key,
    required this.listHistoriTransaksi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listHistoriTransaksi.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var waktuTransaksiDibuat = DateConverter.mySQLToDartDateFormat(
            listHistoriTransaksi[index].waktuTransaksi.split(' ')[0]);

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
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
                    waktuTransaksiDibuat,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    listHistoriTransaksi[index].statusTransaksi == 'settlement'
                        ? 'Berhasil'
                        : listHistoriTransaksi[index].statusTransaksi ==
                                'pending'
                            ? 'Pending'
                            : 'Gagal',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'BNI Virtual Account',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                listHistoriTransaksi[index].noVA,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(
                    int.tryParse(listHistoriTransaksi[index].totalPembayaran)!),
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
