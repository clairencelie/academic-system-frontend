import 'package:academic_system/src/bloc/histori_transaksi/histori_transaksi_bloc.dart';
import 'package:academic_system/src/model/histori_transaksi.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WebHistoriTransakasi extends StatefulWidget {
  final Student mahasiswa;

  const WebHistoriTransakasi({
    super.key,
    required this.mahasiswa,
  });

  @override
  State<WebHistoriTransakasi> createState() => _WebHistoriTransakasiState();
}

class _WebHistoriTransakasiState extends State<WebHistoriTransakasi> {
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
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
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
                const Divider(),
                const HeaderHistoriTransaksi(),
                const Divider(),
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
    );
  }
}

class HeaderHistoriTransaksi extends StatelessWidget {
  const HeaderHistoriTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: Text(
                  'ID Transaksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Metode Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Nomor V.A',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Waktu Transaksi Dibuat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Waktu Transaksi Kedaluwarsa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
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
      itemCount: listHistoriTransaksi.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          height: 80,
          decoration: BoxDecoration(
            color: index % 2 == 1
                ? const Color.fromARGB(255, 245, 245, 245)
                : const Color.fromARGB(255, 236, 239, 245),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].idTransaksi,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'BNI Virtual Account',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(int.tryParse(
                      listHistoriTransaksi[index].totalPembayaran)!),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].noVA,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].statusTransaksi == 'settlement'
                      ? 'Berhasil'
                      : listHistoriTransaksi[index].statusTransaksi == 'pending'
                          ? 'Pending'
                          : 'Gagal',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].waktuTransaksi,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].waktuKedaluwarsa,
                  style: const TextStyle(
                    fontSize: 16,
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
