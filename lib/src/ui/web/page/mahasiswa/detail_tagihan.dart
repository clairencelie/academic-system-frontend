import 'package:academic_system/src/bloc/histori_transaksi/histori_transaksi_bloc.dart';
import 'package:academic_system/src/bloc/rincian_tagihan/rincian_tagihan_bloc.dart';
import 'package:academic_system/src/bloc/tagihan/tagihan_perkuliahan_bloc.dart';
import 'package:academic_system/src/bloc/transaksi/transaksi_bloc.dart';
import 'package:academic_system/src/model/histori_transaksi.dart';
import 'package:academic_system/src/model/rincian_tagihan.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/tagihan_perkuliahan.dart';
import 'package:academic_system/src/repository/transaksi_repository.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTagihanPage extends StatefulWidget {
  final Student student;

  final TagihanPerkuliahan tagihanPerkuliahan;

  const DetailTagihanPage({
    super.key,
    required this.student,
    required this.tagihanPerkuliahan,
  });

  @override
  State<DetailTagihanPage> createState() => _DetailTagihanPageState();
}

class _DetailTagihanPageState extends State<DetailTagihanPage> {
  List<String> title = [
    'Pembayaran ',
    'Tipe pembayaran',
    'Tahun akademik',
    'Semester',
    'Total tagihan',
    'Sisa pembayaran',
    'Status pembayaran',
  ];

  @override
  void initState() {
    super.initState();

    context
        .read<HistoriTransaksiBloc>()
        .add(GetListHistoryTransaksi(nim: widget.student.id));

    context.read<RincianTagihanBloc>().add(
          GetListRincianTagihan(
              idTagihanPembayaran:
                  widget.tagihanPerkuliahan.idTagihanPerkuliahan),
        );
  }

  @override
  Widget build(BuildContext context) {
    List<String> value = [
      widget.tagihanPerkuliahan.kategori,
      widget.tagihanPerkuliahan.metodePembayaran == 'full'
          ? 'Pembayaran Full'
          : 'Cicilan',
      widget.tagihanPerkuliahan.tahunAkademik,
      '${widget.tagihanPerkuliahan.semester[0].toUpperCase()}${widget.tagihanPerkuliahan.semester.substring(1)}',
      NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(widget.tagihanPerkuliahan.totalTagihan),
      NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(widget.tagihanPerkuliahan.sisaPembayaran),
      widget.tagihanPerkuliahan.statusPembayaran == 'belum_bayar'
          ? 'Belum bayar'
          : 'Lunas',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: BlocBuilder<HistoriTransaksiBloc, HistoriTransaksiState>(
                builder: (context, state) {
                  if (state is AllHistoriTransaksiLoaded) {
                    List<HistoriTransaksi> listHistoriTransaksi =
                        state.listHistoriTransaksi;

                    List<HistoriTransaksi> listHistoriPembayaran =
                        listHistoriTransaksi
                            .where((histori) =>
                                histori.idPembayaranKuliah ==
                                widget.tagihanPerkuliahan.idTagihanPerkuliahan)
                            .toList();

                    var transaksiSukses = listHistoriPembayaran
                        .where((histori) =>
                            histori.statusTransaksi == 'settlement')
                        .toList();

                    var transaksiPending = listHistoriPembayaran
                        .where(
                            (histori) => histori.statusTransaksi == 'pending')
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const HeaderDetailTagihan(),
                        const SizedBox(
                          height: 20,
                        ),

                        // Deskripsi dari tagihan perkuliahan
                        Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: title.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          title[index],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      const Flexible(
                                        flex: 1,
                                        child: Text(
                                          ': ',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: Text(
                                          value[index],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            transaksiPending.isNotEmpty
                                ? Column(
                                    children: [
                                      Text(
                                          'Kamu sedang ada transaksi aktif melalui virtual akun ini: ${transaksiPending[0].noVA}.'),
                                      ElevatedButton(
                                        onPressed: () {
                                          TransaksiRepository()
                                              .refreshStatusTransaksi(
                                            widget.tagihanPerkuliahan
                                                .idTagihanPerkuliahan,
                                            transaksiPending[0].idOrder,
                                          )
                                              .then((value) {
                                            context
                                                .read<HistoriTransaksiBloc>()
                                                .add(GetListHistoryTransaksi(
                                                    nim: widget.student.id));

                                            context
                                                .read<TagihanPerkuliahanBloc>()
                                                .add(
                                                  GetListTagihan(
                                                    nim: widget.student.id,
                                                  ),
                                                );
                                          });
                                        },
                                        child: const Text(
                                            'Refresh Status Pembayaran'),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.student.name,
                            ),
                            Text(
                              widget.student.id,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Rincian tagihan (list item tagihan perkuliahan)
                        BlocBuilder<RincianTagihanBloc, RincianTagihanState>(
                          builder: (context, state) {
                            if (state is RincianTagihanLoaded) {
                              List<RincianTagihan> listRincianTagihan =
                                  state.listRincianTagihan;

                              return Column(
                                children: [
                                  // Header
                                  const DetailItemHeader(),
                                  const Divider(),

                                  // rincian tagihan
                                  ListRincianTagihan(
                                    listRincianTagihan: listRincianTagihan,
                                    student: widget.student,
                                  ),
                                  // total tagihan

                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                              child: SizedBox(),
                                            ),
                                            const Expanded(
                                              child: SizedBox(),
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Total tagihan:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                NumberFormat.currency(
                                                  locale: 'id_ID',
                                                  symbol: 'Rp ',
                                                  decimalDigits: 0,
                                                ).format(
                                                  widget.tagihanPerkuliahan
                                                      .totalTagihan,
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // button bayar
                                  transaksiSukses.isNotEmpty
                                      ? const Text('Sudah Lunas')
                                      : BlocListener<TransaksiBloc,
                                          TransaksiState>(
                                          listener: (context, state) {
                                            if (state is TransaksiCreated) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();

                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return InfoDialog(
                                                    title: 'Informasi',
                                                    body: state.message,
                                                    onClose: () {
                                                      Navigator.pop(context);
                                                      context
                                                          .read<
                                                              HistoriTransaksiBloc>()
                                                          .add(
                                                              GetListHistoryTransaksi(
                                                                  nim: widget
                                                                      .student
                                                                      .id));
                                                    },
                                                  );
                                                },
                                              );
                                            } else if (state
                                                is TransaksiFailed) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();

                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return InfoDialog(
                                                    title: 'Informasi',
                                                    body:
                                                        'Gagal membuat transaksi',
                                                    onClose: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            } else if (state
                                                is TransaksiLoading) {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color.fromARGB(
                                                          255, 0, 32, 96),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              width: 100,
                                              height: 50,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                    (states) =>
                                                        const Color.fromARGB(
                                                            255, 11, 39, 118),
                                                  ),
                                                ),
                                                onPressed: transaksiPending
                                                        .isNotEmpty
                                                    ? null
                                                    : () {
                                                        String
                                                            idTagihanPerkuliahan =
                                                            widget
                                                                .tagihanPerkuliahan
                                                                .idTagihanPerkuliahan;

                                                        String totalTagihan =
                                                            widget
                                                                .tagihanPerkuliahan
                                                                .sisaPembayaran
                                                                .toString();

                                                        context
                                                            .read<
                                                                TransaksiBloc>()
                                                            .add(
                                                              CreateTransaksi(
                                                                idTagihanPerkuliahan:
                                                                    idTagihanPerkuliahan,
                                                                nim: widget
                                                                    .student.id,
                                                                totalTagihan:
                                                                    totalTagihan,
                                                              ),
                                                            );
                                                      },
                                                child: const Text('Bayar'),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              );
                            } else if (state is RincianTagihanLoading) {
                              return const CircularProgressIndicator();
                            } else if (state is RincianTagihanNotFound) {
                              return const Text(
                                  'Rincian tagihan tidak ditemukan');
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderDetailTagihan extends StatelessWidget {
  const HeaderDetailTagihan({
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
          'Detail Tagihan Pembayaran',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ListRincianTagihan extends StatelessWidget {
  final List<RincianTagihan> listRincianTagihan;
  final Student student;

  const ListRincianTagihan({
    Key? key,
    required this.listRincianTagihan,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listRincianTagihan.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
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
                  listRincianTagihan[index].item,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listRincianTagihan[index].jumlahItem.toString(),
                  style: const TextStyle(
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
                  ).format(listRincianTagihan[index].hargaItem),
                  style: const TextStyle(
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
                  ).format(listRincianTagihan[index].totalHargaItem),
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

class DetailItemHeader extends StatelessWidget {
  const DetailItemHeader({super.key});

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
                  'Nama Item',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Jumlah Item',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Harga Item',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Total Harga Item',
                  style: TextStyle(
                    fontSize: 16,
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
