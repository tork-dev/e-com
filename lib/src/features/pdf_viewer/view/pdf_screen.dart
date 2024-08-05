import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:kirei/src/common/layouts/layout_with_drawer/layout_with_drawer.dart';
import 'package:kirei/src/features/pdf_viewer/controller/pdf_controller.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({required this.pdfUrl, super.key});

  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PdfController());
    print(pdfUrl);
    return AppLayoutWithDrawer(
        globalKey: controller.pfdKey,
        title: const Text('Pdf Viewer'),
        body: SfPdfViewer.network(
          pdfUrl,
          canShowPageLoadingIndicator: true,
          canShowPaginationDialog: true,
          pageSpacing: 2.0,
        ));
  }
}
