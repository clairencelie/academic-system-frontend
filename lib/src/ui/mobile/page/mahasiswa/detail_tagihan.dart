import 'package:academic_system/src/bloc/histori_transaksi/histori_transaksi_bloc.dart';
import 'package:academic_system/src/bloc/rincian_tagihan/rincian_tagihan_bloc.dart';
import 'package:academic_system/src/bloc/tagihan/tagihan_perkuliahan_bloc.dart';
import 'package:academic_system/src/bloc/transaksi/transaksi_bloc.dart';
import 'package:academic_system/src/model/histori_transaksi.dart';
import 'package:academic_system/src/model/rincian_tagihan.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/tagihan_perkuliahan.dart';
import 'package:academic_system/src/repository/transaksi_repository.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/timer_va_mobile.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MobileDetailTagihanPage extends StatefulWidget {
  final Student student;

  final TagihanPerkuliahan tagihanPerkuliahan;

  const MobileDetailTagihanPage({
    super.key,
    required this.student,
    required this.tagihanPerkuliahan,
  });

  @override
  State<MobileDetailTagihanPage> createState() =>
      _MobileDetailTagihanPageState();
}

class _MobileDetailTagihanPageState extends State<MobileDetailTagihanPage> {
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
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocBuilder<HistoriTransaksiBloc, HistoriTransaksiState>(
                  builder: (context, state) {
                    if (state is AllHistoriTransaksiLoaded) {
                      List<HistoriTransaksi> listHistoriTransaksi =
                          state.listHistoriTransaksi;

                      List<HistoriTransaksi> listHistoriPembayaran =
                          listHistoriTransaksi
                              .where((histori) =>
                                  histori.idPembayaranKuliah ==
                                  widget
                                      .tagihanPerkuliahan.idTagihanPerkuliahan)
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

                                return PaymentDetail(
                                    title: title, value: newValue);
                              }
                              return PaymentDetail(title: title, value: value);
                            },
                          ),
                          transaksiPending.isNotEmpty
                              ? ShowVANumber(
                                  transaksiPending: transaksiPending,
                                  tagihanPerkuliahan: widget.tagihanPerkuliahan,
                                  mahasiswa: widget.student,
                                )
                              : const SizedBox(),

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
                                    const Text(
                                      'Rincian Tagihan',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: Color.fromARGB(201, 184, 184, 184),
                                    ),
                                    const HeaderRincianTagihan(),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: Color.fromARGB(201, 184, 184, 184),
                                    ),
                                    ListRincianTagihan(
                                      listRincianTagihan: listRincianTagihan,
                                    ),
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: Color.fromARGB(201, 184, 184, 184),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color.fromARGB(
                                                201, 184, 184, 184),
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Expanded(
                                                flex: 4,
                                                child: SizedBox(),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Text(
                                                  'Total :',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 2,
                                                child: SizedBox(),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  NumberFormat.currency(
                                                    locale: 'id_ID',
                                                    symbol: '',
                                                    decimalDigits: 0,
                                                  ).format(
                                                    widget.tagihanPerkuliahan
                                                        .totalTagihan,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                          'Gagal membuat transaksi, silahkan coba lagi.',
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
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                                      .student
                                                                      .id,
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
      ),
    );
  }
}

class HeaderRincianTagihan extends StatelessWidget {
  const HeaderRincianTagihan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: const [
          Expanded(
            flex: 4,
            child: Text(
              'Item',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Harga',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Jml',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Total Harga',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowVANumber extends StatelessWidget {
  const ShowVANumber({
    Key? key,
    required this.transaksiPending,
    required this.tagihanPerkuliahan,
    required this.mahasiswa,
  }) : super(key: key);

  final List<HistoriTransaksi> transaksiPending;
  final TagihanPerkuliahan tagihanPerkuliahan;
  final Student mahasiswa;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: const Color.fromARGB(255, 239, 243, 255),
      child: Column(
        children: [
          const Text(
            'Anda sedang memiliki transaksi aktif',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            child: Text(
              'Harap melakukan refresh status pembayaran jika sudah berhasil melakukan transfer melalui nomor virtual akun yang diberikan.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'No. Virtual Akun:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    transaksiPending[0].noVA,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(left: 5),
                    constraints: const BoxConstraints(),
                    onPressed: () async {
                      await Clipboard.setData(
                        ClipboardData(
                          text: transaksiPending[0].noVA,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            child: MobileTimerVA(
                targetUnixTime:
                    DateTime.parse(transaksiPending[0].waktuKedaluwarsa)
                            .millisecondsSinceEpoch ~/
                        1000),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 11, 39, 118),
                  ),
                ),
                onPressed: () {
                  TransaksiRepository()
                      .refreshStatusTransaksi(
                    tagihanPerkuliahan.idTagihanPerkuliahan,
                    transaksiPending[0].idOrder,
                  )
                      .then((value) {
                    context
                        .read<HistoriTransaksiBloc>()
                        .add(GetListHistoryTransaksi(nim: mahasiswa.id));

                    context.read<TagihanPerkuliahanBloc>().add(
                          GetListTagihan(
                            nim: mahasiswa.id,
                          ),
                        );
                    // Refresh detail
                    // setState(() {});
                  });
                },
                child: const Text('Refresh Status Pembayaran'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentDetail extends StatelessWidget {
  const PaymentDetail({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final List<String> title;
  final List<String> value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: title.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
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
                    flex: 7,
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
      ],
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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listRincianTagihan.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: (index == listRincianTagihan.length - 1)
              ? null
              : const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(203, 227, 227, 227),
                    ),
                  ),
                ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  listRincianTagihan[index].item,
                  style: const TextStyle(
                    fontSize: 13.5,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: '',
                    decimalDigits: 0,
                  ).format(listRincianTagihan[index].hargaItem),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 13.5,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '${listRincianTagihan[index].jumlahItem.toString()}x',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 13.5,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: '',
                    decimalDigits: 0,
                  ).format(listRincianTagihan[index].totalHargaItem),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 13.5,
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
                flex: 2,
                child: Text(
                  listHistoriTransaksi[index].idTransaksi,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  'BNI Virtual Account',
                  style: TextStyle(
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
                  ).format(int.tryParse(
                      listHistoriTransaksi[index].totalPembayaran)!),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].noVA,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
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
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].waktuTransaksi,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  listHistoriTransaksi[index].waktuKedaluwarsa,
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
                flex: 2,
                child: Text(
                  'ID Transaksi',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
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
