

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:zembora_driver_app/common/common_app_bar.dart';
// import 'package:zembora_driver_app/common/common_background.dart';
// import 'package:zembora_driver_app/core/constants/global_keys.dart';

// class PdfViewerPageParams {
//   final String pdfPath;
//   final bool isurl;
//   PdfViewerPageParams({required this.pdfPath, this.isurl = true});
// }

// @RoutePage()
// class PdfViewerPage extends StatelessWidget {
//   final PdfViewerPageParams params;

//   const PdfViewerPage({super.key, required this.params});

//   @override
//   Widget build(BuildContext context) {
//     return CommonBackground(
//       appBar: CommonAppBar(titleText: "PDF Viewer"),
//       child: params.isurl
//           ? SfPdfViewer.network(params.pdfPath, key: GlobalKeys.pdfViewerKey)
//           : SfPdfViewer.asset(params.pdfPath, key: GlobalKeys.pdfViewerKey),
//     );
//   }
// }
