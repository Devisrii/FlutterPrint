import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../sale_analysis/sale_analysis_input_model.dart';
import '../common/common.dart';

Future<Uint8List> generateSaleAnalysis(SaleAnalysis data) async {
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
                if (data.group != 'branch')
                  buildFilterRow(
                    keyText: 'Groupby',
                    keyWidth: 60,
                    valueText: "${data.group![0].toUpperCase()}${data.group!.substring(1).toLowerCase()}",
                  ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(0.7),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(1.5),
              3: const pw.FlexColumnWidth(0.7),
              4: const pw.FlexColumnWidth(1.5),
              5: const pw.FlexColumnWidth(1.5),
              6: const pw.FlexColumnWidth(1.2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'Sl.No',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: (data.group != null)
                        ? "${data.group![0].toUpperCase()}${data.group!.substring(1).toLowerCase()}"
                        : 'Inventory',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Asset Value',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Sold',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Sale Value',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Profit Value',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Profit(%)',
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
              0: const pw.FlexColumnWidth(0.7),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(1.5),
              3: const pw.FlexColumnWidth(0.7),
              4: const pw.FlexColumnWidth(1.5),
              5: const pw.FlexColumnWidth(1.5),
              6: const pw.FlexColumnWidth(1.2),
            },
            children: [
              for (final (index, record) in data.records.indexed)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      valueText: (index + 1).toString(),
                    ),
                    buildTableCell(
                      valueText: record.name ?? '',
                    ),
                    buildTableCell(
                      valueText: record.assetValue.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.sold.toString(),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.saleValue.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.profitValue.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.profitPercent.abs().toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                      textStyle: pw.TextStyle(
                        color: (record.profitPercent >= 0) ? PdfColors.green900 : PdfColors.red,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildFilterRow(
                      keyText: 'Sale Value',
                      valueText: 'Rs. ${data.summary.saleValue.toStringAsFixed(2)}',
                    ),
                    buildFilterRow(
                      keyText: 'Profit Value',
                      valueText: 'Rs. ${data.summary.profitValue.toStringAsFixed(2)}',
                    ),
                    buildFilterRow(
                      keyText: 'Sold',
                      valueText: data.summary.sold.toString(),
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    buildFilterRow(
                      keyText: 'Asset Value',
                      valueText: 'Rs. ${data.summary.assetValue.toStringAsFixed(2)}',
                    ),
                    buildFilterRow(
                      keyText: 'Profit Percent',
                      valueText: data.summary.profitPercent.abs().toStringAsFixed(2),
                      textColor: (data.summary.profitPercent >= 0) ? PdfColors.green900 : PdfColors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildDivider(),
        ];
      },
    ),
  );

  return pdf.save();
}
