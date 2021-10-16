import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'appbar.dart';
class PdfReadFile extends StatefulWidget {
  final String document;
  const PdfReadFile({Key key, this.document}) : super(key: key);

  @override
  _PdfReadFileState createState() => _PdfReadFileState();
}

class _PdfReadFileState extends State<PdfReadFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context, "Home", showBack: true),
      body:  Center(
          child: PDF().cachedFromUrl(
            widget.document,
            placeholder: (double progress) => Center(child: Text('$progress %')),
            errorWidget: (dynamic error) => Center(child: Text(error.toString())),
          ),),
    );
  }
}