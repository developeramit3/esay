import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

import 'appbar.dart';
class PdfReadFile extends StatefulWidget {
  final PDFDocument document;
  const PdfReadFile({Key key, this.document}) : super(key: key);

  @override
  _PdfReadFileState createState() => _PdfReadFileState();
}

class _PdfReadFileState extends State<PdfReadFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context, "Home", showBack: false),
      body:  Center(
          child: PDFViewer(document:widget.document)),
    );
  }
}