import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KRSManagementPage extends StatefulWidget {
  const KRSManagementPage({
    super.key,
  });

  @override
  State<KRSManagementPage> createState() => _KRSManagementPageState();
}

class _KRSManagementPageState extends State<KRSManagementPage> {
  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetAllKrs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Manajemen KRS',
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
              BlocListener<KrsManagementBloc, KrsManagementState>(
                listener: (context, state) {
                  if (state is LockKrsSuccess) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return InfoDialog(
                          title: 'Informasi',
                          body: state.message,
                          onClose: () {
                            Navigator.pop(context);
                            context.read<KrsBloc>().add(GetAllKrs());
                          },
                        );
                      },
                    );
                  } else if (state is LockKrsFailed) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return InfoDialog(
                          title: 'Informasi',
                          body: state.message,
                          onClose: () {
                            Navigator.pop(context);
                            context.read<KrsBloc>().add(GetAllKrs());
                          },
                        );
                      },
                    );
                  }
                },
                child: BlocBuilder<KrsBloc, KrsState>(
                  builder: (context, state) {
                    if (state is KrsFound) {
                      return KrsManagementList(krsLengkap: state.krsLengkap);
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KrsManagementList extends StatelessWidget {
  final List<KartuRencanaStudiLengkap> krsLengkap;
  const KrsManagementList({
    Key? key,
    required this.krsLengkap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: krsLengkap.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 70,
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
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      krsLengkap[index].nim,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      krsLengkap[index].semester,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      krsLengkap[index].kreditDiambil,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      krsLengkap[index].waktuPengisian,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      krsLengkap[index].tahunAkademik,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      krsLengkap[index].commit == "1"
                          ? "Dikunci"
                          : "Belum dikunci",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: krsLengkap[index].commit == "1"
                          ? null
                          : () {
                              // Call commit krs
                              context.read<KrsManagementBloc>().add(
                                    LockKrs(idKrs: krsLengkap[index].id),
                                  );
                            },
                      child: const Text('Kunci KRS'),
                    ),
                  ),
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
