import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/common.dart';
import '../bank_reconciliation/bank_reconciliation_input_model.dart';

Future<Uint8List> generateBankReconciliation(BankReconciliation data) async {
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
                  keyWidth: 60,
                  valueText: data.branch,
                ),
                buildFilterRow(
                  keyText: 'Account',
                  keyWidth: 60,
                  valueText: data.account,
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(1.8),
              1: const pw.FlexColumnWidth(2.5),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(1.5),
              4: const pw.FlexColumnWidth(1.8),
              5: const pw.FlexColumnWidth(1.5),
              6: const pw.FlexColumnWidth(1.5),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Date',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Particulars',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Voucher Type',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Ref No',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Bank Date',
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
            border: pw.TableBorder.all(
              color: PdfColors.grey800,
            ),
            columnWidths: {
              0: const pw.FlexColumnWidth(1.8),
              1: const pw.FlexColumnWidth(2.5),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(1.5),
              4: const pw.FlexColumnWidth(1.8),
              5: const pw.FlexColumnWidth(1.5),
              6: const pw.FlexColumnWidth(1.5),
            },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      valueText: record.date,
                    ),
                    buildTableCell(
                      valueText: record.particulars ?? '',
                    ),
                    buildTableCell(
                      valueText: record.voucherType,
                    ),
                    buildTableCell(
                      valueText: record.voucherNo,
                    ),
                    buildTableCell(
                      valueText: record.bankDate ?? '',
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
              0: const pw.FlexColumnWidth(10),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Balance As Per Company Book :',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: (data.summary.balanceAsPerCompanyBook >= 0)
                        ? data.summary.balanceAsPerCompanyBook.toStringAsFixed(2)
                        : '',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: (data.summary.balanceAsPerCompanyBook < 0)
                        ? data.summary.balanceAsPerCompanyBook.abs().toStringAsFixed(2)
                        : '',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                ],
              ),
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsetsDirectional.only(top: 2),
                    child: buildTableCell(
                      valueText: 'Amount Not Reflected In Bank :',
                      isHeader: true,
                      alignment: pw.Alignment.centerRight,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsetsDirectional.only(top: 2),
                    child: buildTableCell(
                      valueText: (data.summary.amountNotReflectedInBank >= 0)
                          ? data.summary.amountNotReflectedInBank.toStringAsFixed(2)
                          : '',
                      isHeader: true,
                      alignment: pw.Alignment.centerRight,
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsetsDirectional.only(top: 2),
                    child: buildTableCell(
                      valueText: (data.summary.amountNotReflectedInBank < 0)
                          ? data.summary.amountNotReflectedInBank.abs().toStringAsFixed(2)
                          : '',
                      isHeader: true,
                      alignment: pw.Alignment.centerRight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(10),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Balance As Per Bank :',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText:
                        (data.summary.balanceAsPerBank >= 0) ? data.summary.balanceAsPerBank.toStringAsFixed(2) : '',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: (data.summary.balanceAsPerBank < 0)
                        ? data.summary.balanceAsPerBank.abs().toStringAsFixed(2)
                        : '',
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
