import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:simple_router/simple_router.dart';

class MyPDFSceen extends StatefulWidget {
  final String pathfile;
  MyPDFSceen({this.pathfile});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyPDFSceen> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.pathfile);

    setState(() => _isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Xem tài liệu'),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => SimpleRouter.back(),
        ),
        backgroundColor: colorbartop,
      ),
      body: Center(child: PDFViewer(document: document)),
    ));
  }
}
