// library cheque_template;

// import 'dart:typed_data';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import './amount_to_words.dart';

// const double point = 1.0;
// const double inch = 72.0;
// const double cm = inch / 2.54;
// double mm(double pt) {
//   return pt * 72.0 / 25.4;
// }

// class ChequeTemplateData {
//   final String date;
//   final String payee;
//   final int amount;
//   final bool crossSign;

//   ChequeTemplateData({
//     required this.date,
//     required this.payee,
//     required this.amount,
//     this.crossSign = false,
//   });
// }

// class ChequeTemplateConfig {
//   final double width;
//   final double height;
//   final double crossSignX;
//   final double crossSignY;
//   final double dateX;
//   final double dateY;
//   final double dateSpacing;
//   final double payeeWidth;
//   final double payeeX;
//   final double payeeY;
//   final double amountInWordsWidth;
//   final double amountInWordsX;
//   final double amountInWordsLine1Y;
//   final double amountInWordsLine2Y;
//   final double amountInFiguresX;
//   final double amountInFiguresY;
//   final double amountInFiguresWidth;

//   ChequeTemplateConfig({
//     required this.width,
//     required this.height,
//     required this.crossSignX,
//     required this.crossSignY,
//     required this.dateX,
//     required this.dateY,
//     required this.dateSpacing,
//     required this.payeeWidth,
//     required this.payeeX,
//     required this.payeeY,
//     required this.amountInWordsWidth,
//     required this.amountInWordsX,
//     required this.amountInWordsLine1Y,
//     required this.amountInWordsLine2Y,
//     required this.amountInFiguresX,
//     required this.amountInFiguresY,
//     required this.amountInFiguresWidth,
//   });
// }

// var config = ChequeTemplateConfig(
//   width: 204,
//   height: 92,
//   crossSignX: 70,
//   crossSignY: 10,
//   dateX: 158,
//   dateY: 8,
//   dateSpacing: 5,
//   payeeWidth: 130,
//   payeeX: 21,
//   payeeY: 22,
//   amountInWordsWidth: 120,
//   amountInWordsX: 25,
//   amountInWordsLine1Y: 31,
//   amountInWordsLine2Y: 4,
//   amountInFiguresX: 160,
//   amountInFiguresY: 37,
//   amountInFiguresWidth: 100,
// );
// final data = [
//   ChequeTemplateData(
//     payee: "Tmb Account",
//     amount: 22678,
//     date: "11102023",
//   ),
//   // ChequeTemplateData(
//   //   payee: "ICICI Account",
//   //   amount: 3000,
//   //   date: "11112023",
//   // ),
//   // ChequeTemplateData(
//   //   payee: "SBI Account",
//   //   amount: 5800,
//   //   date: "14112023",
//   // )
// ];

// Future<Uint8List> buildCheque(
//   List<ChequeTemplateData> data,
//   ChequeTemplateConfig config,
// ) async {
//   final pdf = pw.Document();

//   for (final record in data) {
//     var page = pw.Page(
//       pageTheme: pw.PageTheme(
//         pageFormat: PdfPageFormat(mm(config.width), mm(config.height)),
//         theme: pw.ThemeData.withFont(base: pw.Font.courier(), bold: pw.Font.courierBold()),
//       ),
//       build: (context) {
//         return pw.Stack(
//           children: [
//             pw.Positioned(
//               top: mm(config.crossSignY),
//               left: mm(config.crossSignX),
//               child: pw.Text(
//                 'AC PAYEE',
//                 style: pw.TextStyle(
//                   fontSize: 14,
//                   fontWeight: pw.FontWeight.bold,
//                   decoration: pw.TextDecoration.combine(
//                     [
//                       pw.TextDecoration.overline,
//                       pw.TextDecoration.underline,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             pw.Positioned(
//               left: mm(config.dateX),
//               top: mm(config.dateY),
//               child: pw.Text(
//                 record.date,
//                 style: pw.TextStyle(
//                   letterSpacing: config.dateSpacing,
//                   fontSize: 14,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ),
//             pw.Positioned(
//               top: mm(config.payeeY),
//               left: mm(config.payeeX),
//               child: pw.SizedBox(
//                 width: mm(config.payeeWidth),
//                 child: pw.Text(
//                   record.payee,
//                   style: pw.TextStyle(
//                     fontSize: 12,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             pw.Positioned(
//               top: mm(config.amountInWordsLine1Y),
//               left: mm(config.amountInWordsX),
//               child: pw.SizedBox(
//                 width: mm(config.amountInWordsWidth),
//                 child: pw.Text(
//                   '${AmountToWords().convert(record.amount).trimRight()} only/-',
//                   style: pw.TextStyle(
//                     fontSize: 12,
//                     lineSpacing: mm(config.amountInWordsLine2Y),
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             pw.Positioned(
//               top: mm(config.amountInFiguresY),
//               left: mm(config.amountInFiguresX),
//               child: pw.Text(
//                 '${record.amount.toStringAsFixed(2)}/-',
//                 style: pw.TextStyle(
//                   fontSize: 12,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//     pdf.addPage(page);
//   }
//   return pdf.save();
// }
