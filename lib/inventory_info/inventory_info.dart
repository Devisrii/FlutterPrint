import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../common/common.dart';
import '../inventory_info/inventory_info_input_model.dart';

Future<Uint8List> generateInventoryInfo(InventoryInfo data) async {
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
            title: data.title,
          ),
          buildDivider(),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 2),
            child: pw.Column(
              children: [
                buildFilterRow(
                  keyText: 'Branches',
                  valueText: data.branches.map((e) => e).join(','),
                ),
                buildFilterRow(
                  keyText: 'Inventory',
                  valueText: data.inventory,
                ),
              ],
            ),
          ),
          buildDivider(),
          pw.Table(
            border: pw.TableBorder.symmetric(),
            columnWidths: {
              0: const pw.FlexColumnWidth(2.5),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(1.5),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FlexColumnWidth(2),
              5: const pw.FlexColumnWidth(2),
              6: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'BatchNo',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Exp.Date',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Stock',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'P.Rate',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'MRP',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'S.Rate',
                    isHeader: true,
                    alignment: pw.Alignment.centerRight,
                  ),
                  buildTableCell(
                    valueText: 'Value',
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
              0: const pw.FlexColumnWidth(2.5),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(1.5),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FlexColumnWidth(2),
              5: const pw.FlexColumnWidth(2),
              6: const pw.FlexColumnWidth(2),
            },
            children: [
              for (final record in data.records)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      valueText: record.batchNo,
                    ),
                    buildTableCell(
                      valueText: record.expiry ?? '',
                    ),
                    buildTableCell(
                      valueText: record.closing.toString(),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.pRate.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.mrp.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.sRate.toStringAsFixed(2),
                      alignment: pw.Alignment.centerRight,
                    ),
                    buildTableCell(
                      valueText: record.value.toStringAsFixed(2),
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
                    valueText: 'Total Stock : ${data.summary.closing.toString()}',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Total Value : ${data.summary.value.toStringAsFixed(2)}',
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
