import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../schedule_drug_report/schedule_drug_report_input.dart';
import '../common/common.dart';

Future<Uint8List> generateScheduleDrug(ScheduleDrug data) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = pw.Font.courier();
  final bold = pw.Font.courierBold();
  final pageFormat = PdfPageFormat(mm(297), mm(210), marginAll: mm(10));

  pdf.addPage(
    pw.MultiPage(
      footer: (context) => buildPageFooter(context),
      maxPages: 50,
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(base: font, bold: bold),
        pageFormat: pageFormat,
        buildBackground: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey800),
            ),
          );
        },
      ),
      build: (context) {
        return [
          buildReportHeader(
            organizationName: data.organizationName,
            branchInfo: data.branchInfo,
            toDate: data.date,
            title: data.title,
          ),
          pw.SizedBox(height: 2),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey800),
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(2.3),
              2: const pw.FlexColumnWidth(3),
              3: const pw.FlexColumnWidth(3),
              4: const pw.FlexColumnWidth(3.5),
              5: const pw.FlexColumnWidth(2),
              6: const pw.FlexColumnWidth(1),
              7: const pw.FlexColumnWidth(2.3),
              8: const pw.FlexColumnWidth(3),
              9: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  buildTableCell(
                    valueText: 'S.No',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Bill No',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Doctor',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Patient',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Name of the Drug',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Batch',
                    isHeader: true,
                    alignment: pw.Alignment.center,
                  ),
                  buildTableCell(
                    valueText: 'Qty',
                    isHeader: true,
                    alignment: pw.Alignment.center,
                  ),
                  buildTableCell(
                    valueText: 'Expiry',
                    isHeader: true,
                    alignment: pw.Alignment.center,
                  ),
                  buildTableCell(
                    valueText: 'Manufacturer',
                    isHeader: true,
                  ),
                  buildTableCell(
                    valueText: 'Signature',
                    isHeader: true,
                  ),
                ],
              ),
            ],
          ),
          pw.Table(
            border: pw.TableBorder.symmetric(outside: const pw.BorderSide(color: PdfColors.grey800)),
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(20.2),
              2: const pw.FlexColumnWidth(2),
            },
            children: [
              for (final (index, record) in data.records.indexed)
                pw.TableRow(
                  children: [
                    buildTableCell(
                      valueText: (index + 1).toString(),
                    ),
                    pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.grey800),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(2.3),
                        1: const pw.FlexColumnWidth(3),
                        2: const pw.FlexColumnWidth(3),
                        3: const pw.FlexColumnWidth(3.5),
                        4: const pw.FlexColumnWidth(2),
                        5: const pw.FlexColumnWidth(1),
                        6: const pw.FlexColumnWidth(2.3),
                        7: const pw.FlexColumnWidth(3),
                      },
                      children: [
                        for (final (item) in record.invTrns)
                          pw.TableRow(
                            children: [
                              buildTableCell(
                                valueText: record.voucherNo,
                              ),
                              buildTableCell(
                                widget: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Dr.${record.doctor}',
                                      style: const pw.TextStyle(fontSize: 11),
                                    ),
                                    pw.Text(
                                      'Lic.No : ${record.licNo}',
                                      style: const pw.TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              buildTableCell(
                                widget: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      record.patient ?? '',
                                      style: const pw.TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    if (record.address.address != null)
                                      pw.Text(
                                        record.address.address!,
                                        style: const pw.TextStyle(fontSize: 11),
                                      ),
                                    if (record.address.city != null)
                                      pw.Text(
                                        '${record.address.city!} - ${record.address.pincode ?? 1}',
                                        style: const pw.TextStyle(fontSize: 11),
                                      ),
                                  ],
                                ),
                              ),
                              buildTableCell(
                                valueText: item.inventory,
                              ),
                              buildTableCell(
                                valueText: item.batchNo,
                                alignment: pw.Alignment.center,
                              ),
                              buildTableCell(
                                valueText: item.qty.toString(),
                                alignment: pw.Alignment.center,
                              ),
                              buildTableCell(
                                valueText: item.expiry,
                                alignment: pw.Alignment.center,
                              ),
                              buildTableCell(
                                valueText: item.manufacturer,
                              ),
                            ],
                          ),
                      ],
                    ),
                    buildTableCell(
                      valueText: '',
                    ),
                  ],
                ),
            ],
          ),
        ];
      },
    ),
  );

  return pdf.save();
}
