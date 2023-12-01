import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/common.dart';
import './account_book_input_model.dart';

Future<Uint8List> generateAccountBook(AccountBook data) async {
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
                  keyText: 'Account',
                  valueText: data.account,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    buildFilterRow(
                      keyText: 'Opening Balance',
                      valueText: (data.summary.opening >= 0)
                          ? '${data.summary.opening.toStringAsFixed(2)} Dr'
                          : '${data.summary.opening.abs().toStringAsFixed(2)} Cr',
                    ),
                    buildFilterRow(
                      keyText: 'Closing Balance',
                      valueText: (data.summary.closing >= 0)
                          ? '${data.summary.closing.toStringAsFixed(2)} Dr'
                          : '${data.summary.closing.abs().toStringAsFixed(2)} Cr',
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
                    valueText: 'Debit',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Credit',
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
                      valueText: record.debit.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.credit.toStringAsFixed(2),
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
              0: const pw.FlexColumnWidth(7),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Total :',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: '${data.summary.debit.abs().toStringAsFixed(2)} Dr',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: '${data.summary.credit.abs().toStringAsFixed(2)} Cr',
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
