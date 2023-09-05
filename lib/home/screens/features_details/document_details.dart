import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocumentDetail extends StatefulWidget {
  static const routeName = "/document-detail/";
  final String documentUrl;

  const DocumentDetail({super.key, required this.documentUrl});

  @override
  State<DocumentDetail> createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const  Text("Document"),
      ),
      body: SfPdfViewer.network(
        widget.documentUrl
      ),
    );
  }
}
