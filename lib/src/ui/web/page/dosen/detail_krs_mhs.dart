import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DetailKrsMhs extends StatelessWidget {
  final KartuRencanaStudiLengkap krs;
  final KrsSchedule krsSchedule;

  DetailKrsMhs({
    super.key,
    required this.krs,
    required this.krsSchedule,
  });

  final String formattedDateNow =
      DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final isAfterTime = DateFormat('dd-MM-yyyy')
        .parse(formattedDateNow)
        .isAfter(DateFormat('dd-MM-yyyy').parse(krsSchedule.tanggalSelesai));

    // final isBeforeTime = DateFormat('dd-MM-yyyy')
    //     .parse(formattedDateNow)
    //     .isBefore(DateFormat('dd-MM-yyyy').parse(krsSchedule.tanggalMulai));

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KRSDetailHeader(),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<KrsBloc, KrsState>(
                    builder: (context, state) {
                      if (state is KrsFound) {
                        KartuRencanaStudiLengkap updatedKrs = state.krsLengkap
                            .singleWhere((element) => element.id == krs.id);
                        return DetailKRSBody(
                            krs: updatedKrs, isAfterTime: isAfterTime);
                      }
                      return DetailKRSBody(krs: krs, isAfterTime: isAfterTime);
                    },
                  ),
                  BlocListener<KrsManagementBloc, KrsManagementState>(
                    listener: (context, state) {
                      if (state is LockKrsSuccess) {
                        showResponseDialog(context, state.message);
                      } else if (state is LockKrsFailed) {
                        showResponseDialog(context, state.message);
                      } else if (state is ApproveKrsSuccess) {
                        showResponseDialog(context, state.message);
                      } else if (state is ApproveKrsFailed) {
                        showResponseDialog(context, state.message);
                      } else if (state is UnApproveKrsSuccess) {
                        showResponseDialog(context, state.message);
                      } else if (state is UnApproveKrsFailed) {
                        showResponseDialog(context, state.message);
                      }
                    },
                    child: const SizedBox(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showResponseDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return InfoDialog(
          title: 'Informasi',
          body: message,
          onClose: () {
            Navigator.pop(context);
            context.read<KrsBloc>().add(GetKrsLengkap(nim: krs.nim));
          },
        );
      },
    );
  }
}

class DetailKRSBody extends StatelessWidget {
  const DetailKRSBody({
    Key? key,
    required this.krs,
    required this.isAfterTime,
  }) : super(key: key);

  final KartuRencanaStudiLengkap krs;
  final bool isAfterTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KRSDetailInfo(krs: krs),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'List Mata Kuliah Dipilih',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                ApprovalButton(krs: krs, isAfterTime: isAfterTime),
                const SizedBox(
                  width: 20,
                ),
                LockButton(krs: krs, isAfterTime: isAfterTime),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // List Matkul yang diambil
        const MatkulListHeader(),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: krs.pilihanMataKuliah.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 70,
              decoration: BoxDecoration(
                color: index % 2 == 1
                    ? const Color.fromARGB(255, 238, 238, 238)
                    : const Color.fromARGB(255, 228, 228, 228),
              ),
              child: Center(
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(krs.pilihanMataKuliah[index].idMatkul),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(krs.pilihanMataKuliah[index].name),
                      ),
                      Expanded(
                        child: Text(krs.pilihanMataKuliah[index].credit),
                      ),
                      Expanded(
                        child: Text(krs.pilihanMataKuliah[index].grade),
                      ),
                      Expanded(
                        child: Text(
                            krs.pilihanMataKuliah[index].type.toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class LockButton extends StatelessWidget {
  const LockButton({
    Key? key,
    required this.krs,
    required this.isAfterTime,
  }) : super(key: key);

  final KartuRencanaStudiLengkap krs;
  final bool isAfterTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: krs.approve == '0'
            ? null
            : krs.commit == '1'
                ? null
                : isAfterTime
                    ? () {
                        showConfirmationDialog(context,
                            message:
                                'Apakah anda yakin ingin mengunci KRS atas nama ${krs.nama} ?',
                            onProceed: () {
                          context
                              .read<KrsManagementBloc>()
                              .add(LockKrs(idKrs: krs.id));
                        });
                      }
                    : null,
        child: krs.commit == '1'
            ? const Text('Sudah Dikunci')
            : const Text('Kunci KRS'),
      ),
    );
  }

  Future<dynamic> showConfirmationDialog(
    BuildContext context, {
    required String message,
    required Function onProceed,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onProceed();
              },
              child: const Text('Yakin'),
            ),
          ],
        );
      },
    );
  }
}

class ApprovalButton extends StatelessWidget {
  const ApprovalButton({
    Key? key,
    required this.krs,
    required this.isAfterTime,
  }) : super(key: key);

  final KartuRencanaStudiLengkap krs;
  final bool isAfterTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: krs.approve == '0'
            ? () {
                showConfirmationDialog(
                  context,
                  message:
                      'Apakah anda yakin ingin mengapprove KRS atas nama ${krs.nama} ?',
                  onProceed: () {
                    context
                        .read<KrsManagementBloc>()
                        .add(ApproveKrs(idKrs: krs.id));
                  },
                );
              }
            : isAfterTime
                ? null
                : () {
                    showConfirmationDialog(
                      context,
                      message:
                          'Apakah anda yakin ingin membatalkan approval KRS atas nama ${krs.nama} ?',
                      onProceed: () {
                        context
                            .read<KrsManagementBloc>()
                            .add(UnApproveKrs(idKrs: krs.id));
                      },
                    );
                  },
        child: krs.approve == '0'
            ? const Text('Approve KRS')
            : const Text('Batalkan Approval KRS'),
      ),
    );
  }

  Future<dynamic> showConfirmationDialog(
    BuildContext context, {
    required String message,
    required Function onProceed,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(
            message,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onProceed();
              },
              child: const Text('Yakin'),
            ),
          ],
        );
      },
    );
  }
}

class KRSDetailInfo extends StatelessWidget {
  KRSDetailInfo({
    Key? key,
    required this.krs,
  }) : super(key: key);

  final KartuRencanaStudiLengkap krs;

  final List<String> title = [
    'Nama',
    'NIM',
    'Semester',
    'Program Studi',
    'IPK',
    'IPS',
    'Kredit Diambil',
    'Maks SKS',
    'Tanggal Pengajuan',
    'Tahun Akademik',
    'Approval',
    'Status KRS',
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> value = [
      krs.nama,
      krs.nim,
      krs.semester,
      krs.jurusan,
      krs.ipk,
      krs.ips,
      krs.kreditDiambil,
      krs.bebanSksMaks,
      DateConverter.mySQLToDartDateFormat(krs.waktuPengisian),
      krs.tahunAkademik,
      krs.approve == '1' ? 'Sudah Diapprove' : 'Belum Diapprove',
      krs.commit == '1' ? 'Sudah Dikunci' : 'Belum Dikunci',
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: title.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title[index],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const Flexible(
                child: Text(
                  ': ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value[index],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
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
          onPressed: () {
            Navigator.pop(context);
            context.read<KrsBloc>().add(GetAllKrs());
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
