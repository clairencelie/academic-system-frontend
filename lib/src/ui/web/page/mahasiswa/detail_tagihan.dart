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
import 'package:academic_system/src/ui/web/component/custom_widget/timer_va.dart';
import 'package:flutter/services.dart';
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
    'Nama',
    'NIM',
    'Pembayaran',
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
    var currentTagihanPerkuliahan = widget.tagihanPerkuliahan;

    List<String> value = [
      widget.student.name,
      widget.student.id,
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
      ).format(currentTagihanPerkuliahan.totalTagihan),
      NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(widget.tagihanPerkuliahan.sisaPembayaran),
      currentTagihanPerkuliahan.statusPembayaran == 'belum_bayar'
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
                            BlocBuilder<TagihanPerkuliahanBloc,
                                TagihanPerkuliahanState>(
                              builder: (context, state) {
                                if (state is TagihanPerkuliahanLoaded) {
                                  TagihanPerkuliahan newStatusTagihan = state
                                      .listTagihan
                                      .where((element) =>
                                          element.idTagihanPerkuliahan ==
                                          widget.tagihanPerkuliahan
                                              .idTagihanPerkuliahan)
                                      .first;

                                  List<String> newValue = [
                                    widget.student.name,
                                    widget.student.id,
                                    newStatusTagihan.kategori,
                                    newStatusTagihan.metodePembayaran == 'full'
                                        ? 'Pembayaran Full'
                                        : 'Cicilan',
                                    newStatusTagihan.tahunAkademik,
                                    '${newStatusTagihan.semester[0].toUpperCase()}${newStatusTagihan.semester.substring(1)}',
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(newStatusTagihan.totalTagihan),
                                    NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(newStatusTagihan.sisaPembayaran),
                                    newStatusTagihan.statusPembayaran ==
                                            'belum_bayar'
                                        ? 'Belum bayar'
                                        : 'Lunas',
                                  ];

                                  return BillDetail(
                                      title: title, value: newValue);
                                }
                                return BillDetail(title: title, value: value);
                              },
                            ),
                            transaksiPending.isNotEmpty
                                ? Container(
                                    padding: const EdgeInsets.all(20),
                                    color: const Color.fromARGB(
                                        255, 239, 243, 255),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Anda sedang memiliki transaksi aktif',
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: const Text(
                                                    'Harap melakukan refresh status pembayaran jika sudah berhasil melakukan transfer melalui nomor virtual akun yang diberikan.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TimerVA(
                                                    targetUnixTime: DateTime.parse(
                                                                transaksiPending[
                                                                        0]
                                                                    .waktuKedaluwarsa)
                                                            .millisecondsSinceEpoch ~/
                                                        1000),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Text(
                                                  'No. Virtual Akun:',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      transaksiPending[0].noVA,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        await Clipboard.setData(
                                                          ClipboardData(
                                                            text:
                                                                transaksiPending[
                                                                        0]
                                                                    .noVA,
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.copy),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        BlocListener<TagihanPerkuliahanBloc,
                                            TagihanPerkuliahanState>(
                                          listener: (context, state) {
                                            if (state
                                                is TagihanPerkuliahanLoaded) {
                                              currentTagihanPerkuliahan = state
                                                  .listTagihan
                                                  .where((tagihan) =>
                                                      tagihan
                                                          .idTagihanPerkuliahan ==
                                                      widget.tagihanPerkuliahan
                                                          .idTagihanPerkuliahan)
                                                  .first;
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              width: 230,
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
                                                onPressed: () {
                                                  TransaksiRepository()
                                                      .refreshStatusTransaksi(
                                                    widget.tagihanPerkuliahan
                                                        .idTagihanPerkuliahan,
                                                    transaksiPending[0].idOrder,
                                                  )
                                                      .then((value) {
                                                    context
                                                        .read<
                                                            HistoriTransaksiBloc>()
                                                        .add(
                                                            GetListHistoryTransaksi(
                                                                nim: widget
                                                                    .student
                                                                    .id));

                                                    context
                                                        .read<
                                                            TagihanPerkuliahanBloc>()
                                                        .add(
                                                          GetListTagihan(
                                                            nim: widget
                                                                .student.id,
                                                          ),
                                                        );
                                                    // Refresh detail
                                                    setState(() {});
                                                  });
                                                },
                                                child: const Text(
                                                    'Refresh Status Pembayaran'),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
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
                                  const Divider(),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: DetailItemHeader(),
                                  ),
                                  const Divider(),

                                  // rincian tagihan
                                  ListRincianTagihan(
                                    listRincianTagihan: listRincianTagihan,
                                  ),
                                  // total tagihan

                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            ),
                                            const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            ),
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Total tagihan:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
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
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  // button bayar
                                  transaksiSukses.isNotEmpty
                                      ? const SizedBox()
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
                                                      transaksiPending
                                                              .isNotEmpty
                                                          ? MaterialStateColor
                                                              .resolveWith(
                                                              (states) =>
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      204,
                                                                      204,
                                                                      205),
                                                            )
                                                          : MaterialStateColor
                                                              .resolveWith(
                                                              (states) =>
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      11,
                                                                      39,
                                                                      118),
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
                        // List histori transaksi pada tagihan ini

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Histori Transaksi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const HeaderHistoriTransaksi(),
                        const Divider(),
                        ListHistoriTransaksi(
                            listHistoriTransaksi: listHistoriPembayaran),
                      ],
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BillDetail extends StatelessWidget {
  const BillDetail({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final List<String> title;
  final List<String> value;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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

  const ListRincianTagihan({
    Key? key,
    required this.listRincianTagihan,
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
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listRincianTagihan[index].jumlahItem.toString(),
                  style: const TextStyle(
                    fontSize: 18,
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
                    fontSize: 18,
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
                    fontSize: 18,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Jumlah Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Harga Item',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Total Harga Item',
                  style: TextStyle(
                    fontSize: 18,
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
                    fontSize: 18,
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
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Total Pembayaran',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Nomor V.A',
                  style: TextStyle(
                    fontSize: 18,
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
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Waktu Transaksi Dibuat',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Waktu Transaksi Kedaluwarsa',
                  style: TextStyle(
                    fontSize: 18,
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
