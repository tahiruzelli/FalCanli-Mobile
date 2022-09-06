import 'package:falcanli/Globals/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  late String title;
  late String path;
  PdfView({required this.title, required this.path});
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: title),
      body: SfPdfViewer.asset(
        path,
        key: _pdfViewerKey,
      ),
    );
  }
}
