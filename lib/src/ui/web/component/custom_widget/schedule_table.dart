import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/bloc/schedule_management/schedule_management_bloc.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/cms_item.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/schedule_detail_text.dart';
import 'package:academic_system/src/ui/web/page/akademik/update_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTable extends StatefulWidget {
  const ScheduleTable({super.key});

  @override
  State<ScheduleTable> createState() => _ScheduleTableState();
}

class _ScheduleTableState extends State<ScheduleTable> {
  TextEditingController searchController = TextEditingController();

  List<Schedule> tempSchedules = [];

  bool isEdit = false;

  List<String> selectedSchedule = [];

  final List<String> columns = ['ID', 'Mata Kuliah', 'Hari'];

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (title) => DataColumn(
          label: Text(title),
        ),
      )
      .toList();

  List<DataRow> getRows(List<Schedule> schedules) => schedules
      .map(
        (schedule) => DataRow(
          color: (schedules.indexOf(schedule) % 2 == 0)
              ? MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 213, 226, 236),
                )
              : MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 221, 237, 250),
                ),
          onLongPress: () {},
          selected: isEdit ? selectedSchedule.contains(schedule.id) : false,
          onSelectChanged: (value) {
            isEdit
                ? setState(() {
                    final isAdding = value != null && value;
                    isAdding
                        ? selectedSchedule.add(schedule.id)
                        : selectedSchedule.remove(schedule.id);
                  })
                : showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return UpdateSchedulePage(schedule: schedule);
                                },
                              ));
                            },
                            child: const Text('Edit'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Kembali'),
                          ),
                        ],
                        title: const Center(child: Text('Detail Jadwal')),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ScheduleDetailText(
                              title: 'ID',
                              data: schedule.id,
                            ),
                            ScheduleDetailText(
                              title: 'Nama Matkul',
                              data: schedule.learningSubName,
                            ),
                            ScheduleDetailText(
                              title: 'Nama Dosen',
                              data: schedule.lecturerName,
                            ),
                            ScheduleDetailText(
                              title: 'Waktu',
                              data: '${schedule.startsAt} - ${schedule.endsAt}',
                            ),
                            ScheduleDetailText(
                              title: 'Hari',
                              data: schedule.day,
                            ),
                            ScheduleDetailText(
                              title: 'Kelas',
                              data: schedule.grade,
                            ),
                            ScheduleDetailText(
                              title: 'Sks',
                              data: schedule.credit,
                            ),
                            ScheduleDetailText(
                              title: 'Keterangan',
                              data: schedule.information,
                            ),
                            ScheduleDetailText(
                              title: 'Ruangan',
                              data: schedule.room,
                            ),
                          ],
                        ),
                      );
                    });
          },
          cells: [
            DataCell(
              Text(schedule.learningSubId),
            ),
            DataCell(
              Text(
                schedule.learningSubName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DataCell(
              Text(schedule.day),
            ),
          ],
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(RequestAllSchedule());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Cari jadwal...',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      context.read<ScheduleBloc>().add(
                            SearchSchedule(
                              keyword: searchController.text,
                              schedules: tempSchedules,
                            ),
                          );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CMSItem(
                  height: 65,
                  width: 65,
                  title: 'Seleksi',
                  icons: Icons.select_all_rounded,
                  onTap: () {
                    setState(() {
                      selectedSchedule = [];
                      isEdit = !isEdit;
                    });
                  },
                  color:
                      isEdit ? const Color.fromARGB(255, 214, 232, 248) : null,
                ),
              ),
              CMSItem(
                height: 65,
                width: 65,
                title: 'Delete',
                icons: Icons.delete_forever_rounded,
                onTap: isEdit
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            if (selectedSchedule.isEmpty) {
                              return AlertDialog(
                                title: const Text('Info'),
                                content: const Text(
                                    'Belum ada jadwal yang dipilih untuk dihapus, mohon pilih minimal 1 jadwal.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              );
                            }
                            return AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text('Yakin ingin hapus?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<ScheduleManagementBloc>().add(
                                          DeleteSchedule(
                                            scheduleIds: selectedSchedule,
                                          ),
                                        );
                                    selectedSchedule = [];
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Hapus',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    : null,
                contentColor: isEdit ? Colors.red : Colors.grey,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        // Listener to show alert dialog about delete schedule event.
        BlocListener<ScheduleManagementBloc, ScheduleManagementState>(
          // Bloc builder to build schedule table.
          child: BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              if (state is ScheduleInitial) {
                return DataTable(
                  columns: getColumns(columns),
                  rows: const [],
                );
              } else if (state is RequestingSchedule) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 32, 96),
                    ),
                  ),
                );
              } else if (state is ScheduleLoaded) {
                tempSchedules = state.schedules;
                return DataTable(
                  border: const TableBorder(
                    verticalInside: BorderSide(
                      color: Color.fromARGB(19, 0, 0, 0),
                    ),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 164, 192, 252),
                  ),
                  showCheckboxColumn: isEdit,
                  columnSpacing: 15,
                  columns: getColumns(columns),
                  rows: getRows(state.schedules),
                );
              } else if (state is SearchScheduleFound) {
                return DataTable(
                  border: const TableBorder(
                    verticalInside: BorderSide(
                      color: Color.fromARGB(19, 0, 0, 0),
                    ),
                  ),
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 164, 192, 252),
                  ),
                  showCheckboxColumn: isEdit,
                  columnSpacing: 15,
                  columns: getColumns(columns),
                  rows: getRows(state.filteredSchedules),
                );
              } else if (state is ScheduleEmpty) {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text('Jadwal tidak ditemukan.'),
                  ),
                );
              } else if (state is ScheduleRequestFailed) {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text('Table has error...'),
                  ),
                );
              }
              return Container();
            },
          ),
          listener: (context, state) {
            if (state is ScheduleDeleted) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Info'),
                    content: const Text('Jadwal terpilih berhasil dihapus.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Add get schedule list event to refresh table schedule list.
                          context
                              .read<ScheduleBloc>()
                              .add(RequestAllSchedule());
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            } else if (state is ScheduleDeleteFailed) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Info'),
                    content: const Text('Jadwal terpilih gagal dihapus.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            }
          },
        )
      ],
    );
  }
}
