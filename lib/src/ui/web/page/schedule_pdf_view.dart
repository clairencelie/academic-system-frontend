import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class SchedulePDFPreview extends StatelessWidget {
  final Uint8List pdf;
  const SchedulePDFPreview({
    super.key,
    required this.pdf,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ],
        allowPrinting: false,
        canDebug: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        build: (format) => pdf,
      ),
    );
  }
}
