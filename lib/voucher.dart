import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

const double point = 1.0;
const double inch = 72.0;
const double cm = inch / 2.54;
double mm(double pt) {
  return pt * 72.0 / 25.4;
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 900.0,
          width: 800.0,
          child: PdfPreview(
            build: (_) => _generatePdf('Test'),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = pw.Font.courier();
    final bold = pw.Font.courierBold();
    // const pageFormat = PdfPageFormat.a4;

    Configuration config = Configuration(pageFormat: 'a4');

    final List<InventoryBookRecord> data = [
      InventoryBookRecord(
        particulars: '11/02/2023',
        inward: '58',
        outward: '88',
      ),
      InventoryBookRecord(
        particulars: '16/03/2023',
        inward: '58',
        outward: '76',
      ),
      InventoryBookRecord(
        particulars: '22/04/2023',
        inward: '34',
        outward: '45',
      ),
      InventoryBookRecord(
        particulars: '11/05/2023',
        inward: '58',
        outward: '100',
      ),
      InventoryBookRecord(
        particulars: '11/02/2023',
        inward: '58',
        outward: '88',
      ),
      InventoryBookRecord(
        particulars: '16/03/2023',
        inward: '58',
        outward: '76',
      ),
      InventoryBookRecord(
        particulars: '16/03/2023',
        inward: '58',
        outward: '76',
      ),
      InventoryBookRecord(
        particulars: '22/04/2023',
        inward: '34',
        outward: '45',
      ),
      InventoryBookRecord(
        particulars: '11/05/2023',
        inward: '58',
        outward: '100',
      ),
    ];

    pdf.addPage(
      pw.MultiPage(
        // header: (context) {
        //   return context.pageNumber == 1
        //       ? pw.Padding(
        //           padding: const pw.EdgeInsets.only(top: -15),
        //           child: pw.Row(
        //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        //             children: [
        //               pw.Text(
        //                 'ORIGINAL COPY',
        //                 style: const pw.TextStyle(fontSize: 9),
        //               ),
        //               pw.Text(
        //                 'TAX INVOICE',
        //                 style: const pw.TextStyle(fontSize: 9),
        //               ),
        //               pw.Text(
        //                 'CASH SALE INVOICE',
        //                 style: const pw.TextStyle(fontSize: 9),
        //               ),
        //             ],
        //           ),
        //         )
        //       : pw.Padding(
        //           padding: pw.EdgeInsets.zero,
        //         );
        // },
        footer: (context) {
          return pw.Column(
            children: [
              // if ((context.pageNumber / context.pagesCount) == 1)
              // pw.Divider(
              //   color: PdfColors.grey,
              //   height: 5,
              // ),
              // if ((context.pageNumber / context.pagesCount) == 1)
              //   pw.Padding(
              //     padding: const pw.EdgeInsets.symmetric(horizontal: 2),
              //     child: pw.Row(
              //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //       children: [
              //         pw.Column(
              //           children: [
              //             _buildRow(keyText: 'Total Inward', valueText: '870.50'),
              //           ],
              //         ),
              //         pw.Column(
              //           children: [
              //             _buildRow(keyText: 'Total Outward', valueText: '600.50'),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // if ((context.pageNumber / context.pagesCount) == 1)
              //   pw.Divider(
              //     color: PdfColors.grey,
              //     height: 5,
              //   ),
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: -15),
                alignment: pw.Alignment.bottomRight,
                child: pw.Text(
                  'Page ${context.pageNumber}/${context.pagesCount}',
                  style: const pw.TextStyle(fontSize: 9),
                ),
              ),
            ],
          );
        },
        maxPages: 50,
        pageTheme: pw.PageTheme(
          theme: pw.ThemeData.withFont(base: font, bold: bold),
          pageFormat: config.pageFormat == 'a4'
              ? PdfPageFormat(mm(210), mm(297), marginAll: mm(10))
              : PdfPageFormat(mm(148), mm(105), marginAll: mm(5)),
          // orientation: pw.PageOrientation.landscape,
          buildBackground: (context) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey),
              ),
            );
          },
        ),
        build: (context) {
          return [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(2),
                  width: 260,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(color: PdfColors.grey),
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'VELAVAN MEDICAL',
                            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 1),
                          pw.Text(
                            '115/8, DEVARPURAM ROAD',
                            style: const pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            'THOOTHUKUDI - 628002',
                            style: const pw.TextStyle(fontSize: 8),
                          ),
                          pw.Text(
                            '20-01-2023 to 08-11-2023',
                            style: const pw.TextStyle(fontSize: 8),
                          ),
                          _buildRow(keyText: 'Phone', valueText: '9632587415'),
                          _buildRow(keyText: 'Email', valueText: 'dproadmed@gmail.com'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _buildRow(keyText: 'GSTIN', valueText: '33AANFV6837B1Z2'),
                          _buildRow(keyText: 'LIC.No', valueText: 'DLNo: TNT/278/20,21'),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Text(
                          'SALE',
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            decoration: pw.TextDecoration.underline,
                            decorationColor: PdfColors.grey,
                            decorationStyle: pw.TextDecorationStyle.double,
                          ),
                        ),
                      ),
                      _buildRow(keyText: 'Bill No', valueText: 'Dp2223456923245'),
                      _buildRow(keyText: 'Bill Date', valueText: '11/11/2023'),
                      _buildRow(keyText: 'Ref.No', valueText: 'Dp1'),
                    ],
                  ),
                )
              ],
            ),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey),
              columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(1),
                2: const pw.FlexColumnWidth(1),
                3: const pw.FlexColumnWidth(1.5),
                4: const pw.FlexColumnWidth(0.7),
                5: const pw.FlexColumnWidth(1),
                6: const pw.FlexColumnWidth(1),
                7: const pw.FlexColumnWidth(1),
                8: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _buildTableHeader(
                          header: 'PARTICULARS',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        _buildTableHeader(
                          header: 'RACK',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        _buildTableHeader(
                          header: 'BATCH',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        _buildTableHeader(
                          header: 'EXP',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        _buildTableHeader(
                          header: 'QTY',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        _buildTableHeader(
                          header: 'MRP',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        _buildTableHeader(
                          header: 'RATE',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        _buildTableHeader(
                          header: 'DISC',
                          isHeader: true,
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        _buildTableHeader(
                          header: 'AMOUNT',
                          isHeader: true,
                        ),
                      ],
                    ),
                  ],
                ),
                for (final record in data)
                  pw.TableRow(
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _buildTableHeader(header: 'Vicks'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          _buildTableHeader(header: 'Candy'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          _buildTableHeader(header: 'V1'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          _buildTableHeader(header: '12-01-2024'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          _buildTableHeader(header: '1'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          _buildTableHeader(header: '2.00'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          _buildTableHeader(header: '2.00'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          _buildTableHeader(header: '0.00'),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          _buildTableHeader(header: '2.00'),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            pw.Row(
              children: [
                pw.Column(
                  children: [],
                ),
                pw.Column(
                  children: [],
                ),
              ],
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildRow({
    required String keyText,
    required String valueText,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 30,
          child: pw.Text(
            keyText,
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(
          width: 5,
          child: pw.Text(
            ':',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Text(
          valueText,
          style: const pw.TextStyle(fontSize: 8),
          softWrap: true,
        ),
      ],
    );
  }

  pw.Widget _buildTableHeader({
    required String header,
    bool isHeader = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(
        header,
        style: isHeader
            ? pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)
            : const pw.TextStyle(
                fontSize: 8,
              ),
      ),
    );
  }
}

class InventoryBookRecord {
  final String particulars;
  final String inward;
  final String outward;
  InventoryBookRecord({
    required this.particulars,
    required this.inward,
    required this.outward,
  });
}

class Configuration {
  final String? pageFormat;
  Configuration({this.pageFormat});
}
