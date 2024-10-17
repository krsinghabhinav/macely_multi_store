import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PDFGeneratorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate PDF'),
      ),
      body: SizedBox(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final pdf = await _createPDF();
              await _savePDF(pdf);
            },
            child: Text('Generate PDF'),
          ),
        ),
      ),
    );
  }

  // Function to create the PDF document
  Future<Uint8List> _createPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Hello, this is a PDF document!',
              style: pw.TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // Function to save the PDF to a file
  Future<void> _savePDF(Uint8List pdfData) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/generated_document.pdf');
      await file.writeAsBytes(pdfData);
      print('PDF saved at ${file.path}');
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }
}
