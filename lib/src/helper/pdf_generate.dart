import 'dart:async';

import 'package:academic_system/src/model/schedule.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';

class PDFGenerate {
  static int count = 1;
  static Future<File> generatePdf(
      List<Schedule> schedules, String tahunAkademik, String semester) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a3.landscape,
        ),
        build: (context) {
          return [
            buildTitle(tahunAkademik, semester),
            buildTable(schedules),
            SizedBox(height: 10),
            buildFooter(),
          ];
        },
      ),
    );
    count = 1;
    return PDFGenerate.safeDocument(
        name:
            'Jadwal Perkuliahan STMIK Dharma Putra Semester Ganjil 2022-2023.pdf',
        pdf: pdf);
    // return pdf.save();
  }

  static Widget buildFooter() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        '*Jadwal ini digenerate dari aplikasi STMIK Dharma Putra.',
        textAlign: TextAlign.right,
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  // PDF Title
  static Widget buildTitle(String tahunAkademik, String semester) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'JADWAL PERKULIAHAN SEMESTER ${semester.toUpperCase()} - TAHUN AKADEMIK ${tahunAkademik.toUpperCase()}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            'PROGRAM STUDI : TEKNIK INFORMATIKA & SISTEM INFORMASI',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            'STMIK DHARMA PUTRA',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  // PDF Data Table
  static Widget buildTable(List<Schedule> schedules) {
    final List<String> headers = [
      'No',
      'Kode MK',
      'Mata Kuliah',
      'Sks',
      'Kelas',
      'Nama Dosen',
      'Hari',
      'Waktu',
      'Ruang',
    ];

    final data = schedules.map((schedule) {
      return [
        count++,
        schedule.idMatkul,
        schedule.learningSubName,
        schedule.credit,
        schedule.grade,
        schedule.lecturerName,
        schedule.day,
        '${schedule.startsAt} - ${schedule.endsAt}',
        schedule.room,
      ];
    }).toList();

    return Table.fromTextArray(
      headerDecoration: const BoxDecoration(
        color: PdfColor(0, 0.6, 1),
      ),
      headerPadding: const EdgeInsets.all(8),
      cellPadding: const EdgeInsets.all(8),
      headers: headers,
      data: data,
    );
  }

  static Future<File> safeDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
