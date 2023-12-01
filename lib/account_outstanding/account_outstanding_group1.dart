import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../account_outstanding/account_outstanding_input.dart';
import '../common/common.dart';

Future<Uint8List> generateAccountOutstandingGroup1(AccountOutstanding data) async {
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
            title: data.title,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Column(
              children: [
                if (data.branches.isNotEmpty)
                  buildFilterRow(
                    keyText: 'Branch',
                    keyWidth: 100,
                    valueText: data.branches.map((e) => e).join(','),
                  ),
                if (data.accounts.isNotEmpty)
                  buildFilterRow(
                    keyText: 'Account',
                    keyWidth: 100,
                    valueText: data.accounts.map((e) => e).join(','),
                  ),
                buildFilterRow(
                  keyText: 'As On Date',
                  keyWidth: 100,
                  valueText: data.asOnDate,
                ),
                buildFilterRow(
                  keyText: 'Printed On',
                  keyWidth: 100,
                  valueText: data.printedOn,
                ),
                buildFilterRow(
                  keyText: 'Closing Balance',
                  keyWidth: 100,
                  valueText: (data.summary.closing >= 0)
                      ? '${data.summary.closing.toStringAsFixed(2)} Dr'
                      : '${data.summary.closing.abs().toStringAsFixed(2)} Cr',
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(1),
              3: const pw.FlexColumnWidth(1),
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
                  buildTableCell(
                    valueText: 'Balance',
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
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
              2: const pw.FlexColumnWidth(1),
              3: const pw.FlexColumnWidth(1),
            },
            children: [
              for (final entry in data.records.entries)
                for (final record in entry.value)
                  pw.TableRow(
                    children: [
                      buildTableCell(
                        valueText: record.accountName ?? record.branchName,
                      ),
                      buildTableCell(
                        valueText: record.debit.toStringAsFixed(2),
                        alignment: pw.Alignment.centerRight,
                      ),
                      buildTableCell(
                        valueText: record.credit.abs().toStringAsFixed(2),
                        alignment: pw.Alignment.centerRight,
                      ),
                      buildTableCell(
                        valueText: (record.closing >= 0)
                            ? '${record.closing.toStringAsFixed(2)} Dr'
                            : '${record.closing.abs().toStringAsFixed(2)} Cr',
                        alignment: pw.Alignment.centerRight,
                      ),
                    ],
                  )
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
                    valueText: 'Total Debit : ${data.summary.debit.toStringAsFixed(2)} Dr',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Total Credit : ${data.summary.credit.toStringAsFixed(2)} Cr',
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
