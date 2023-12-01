import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/common.dart';
import './inventory_book_input_model.dart';

Future<Uint8List> generateInventoryBook(InventoryBook data) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.courier();
  final bold = pw.Font.courierBold();
  final pageFormat = PdfPageFormat(mm(210), mm(297), marginAll: mm(10));

  pdf.addPage(
    pw.MultiPage(
      footer: (context) => buildPageFooter(context),
      maxPages: 50,
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: font, bold: bold),
        pageFormat: pageFormat,
      ),
      build: (context) {
        return [
          buildReportHeader(
            organizationName: data.organizationName,
            branchInfo: data.branchInfo,
            fromDate: data.fromDate,
            toDate: data.toDate,
            title: data.title,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Column(
              children: [
                buildFilterRow(
                  keyText: 'Branch',
                  valueText: data.branches.map((e) => e).join(','),
                ),
                buildFilterRow(
                  keyText: 'Inventory',
                  valueText: data.inventory,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    buildFilterRow(
                      keyText: 'Opening Stock',
                      valueText: data.summary.opening.toString(),
                    ),
                    buildFilterRow(
                      keyText: 'Closing Stock',
                      valueText: data.summary.closing.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(4),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(1),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Particulars',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Inward',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Outward',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                ],
              ),
            ],
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey800),
            columnWidths: {
              0: const pw.FlexColumnWidth(4),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(1),
            },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      valueText: record.particulars,
                    ),
                    buildTableCell(
                      valueText: record.inward,
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.outward,
                      alignment: pw.Alignment.centerRight,
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(1),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Total Inward : ${data.summary.inward.toString()}',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Total Outward : ${data.summary.outward.toString()}',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                ],
              ),
            ],
          ),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}
